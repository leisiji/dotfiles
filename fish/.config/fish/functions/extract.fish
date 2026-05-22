function extract --description 'Extract various archive formats'
    if test (count $argv) -eq 0
        echo "Usage: extract [-r|--remove] [file ...]"
        return 1
    end

    set -l remove_archive
    if test "$argv[1]" = "-r" -o "$argv[1]" = "--remove"
        set remove_archive yes
        set -e argv[1]
    end

    set -l pwd (pwd)
    for file in $argv
        if not test -f "$file"
            echo "extract: '$file' is not a valid file" >&2
            continue
        end

        set -l full_path (realpath "$file")
        set -l basename (basename "$file")
        set -l rand (random)

        # Extract directory name (remove extension(s))
        set -l extract_dir (string replace -r '\.[^.]*$' '' "$basename")
        if string match -q '*.tar' "$extract_dir"
            set extract_dir (string replace -r '\.tar$' '' "$extract_dir")
        end

        if test -e "$extract_dir"
            set extract_dir "$extract_dir-$rand"
        end

        command mkdir -p "$extract_dir"
        cd "$extract_dir"

        switch (string lower "$basename")
            case '*.tar.gz' '*.tgz'
                if type -q pigz
                    tar -I pigz -xvf "$full_path"
                else
                    tar zxvf "$full_path"
                end
            case '*.tar.bz2' '*.tbz' '*.tbz2'
                if type -q pbzip2
                    tar -I pbzip2 -xvf "$full_path"
                else
                    tar xvjf "$full_path"
                end
            case '*.tar.xz' '*.txz'
                if type -q pixz
                    tar -I pixz -xvf "$full_path"
                else if tar --xz --help >/dev/null 2>&1
                    tar --xz -xvf "$full_path"
                else
                    xzcat "$full_path" | tar xvf -
                end
            case '*.tar.lzma' '*.tlz'
                if tar --lzma --help >/dev/null 2>&1
                    tar --lzma -xvf "$full_path"
                else
                    lzcat "$full_path" | tar xvf -
                end
            case '*.tar.zst' '*.tzst'
                if tar --zstd --help >/dev/null 2>&1
                    tar --zstd -xvf "$full_path"
                else
                    zstdcat "$full_path" | tar xvf -
                end
            case '*.tar'
                tar xvf "$full_path"
            case '*.tar.lz'
                if type -q lzip
                    tar xvf "$full_path"
                end
            case '*.tar.lz4'
                lz4 -c -d "$full_path" | tar xvf -
            case '*.tar.lrz'
                if type -q lrzuntar
                    lrzuntar "$full_path"
                end
            case '*.gz'
                if type -q pigz
                    pigz -cdk "$full_path" > (string replace -r '\.gz$' '' "$basename")
                else
                    gunzip -ck "$full_path" > (string replace -r '\.gz$' '' "$basename")
                end
            case '*.bz2'
                if type -q pbzip2
                    pbzip2 -d "$full_path"
                else
                    bunzip2 "$full_path"
                end
            case '*.xz'
                unxz "$full_path"
            case '*.lrz'
                if type -q lrunzip
                    lrunzip "$full_path"
                end
            case '*.lz4'
                lz4 -d "$full_path"
            case '*.lzma'
                unlzma "$full_path"
            case '*.z'
                uncompress "$full_path"
            case '*.zip' '*.war' '*.jar' '*.ear' '*.sublime-package' '*.ipa' '*.ipsw' '*.xpi' '*.apk' '*.aar' '*.whl'
                unzip "$full_path"
            case '*.rar'
                unrar x -ad "$full_path"
            case '*.rpm'
                rpm2cpio "$full_path" | cpio --quiet -id
            case '*.7z'
                7za x "$full_path"
            case '*.deb'
                command mkdir -p control data
                ar vx "$full_path" > /dev/null
                cd control
                extract ../control.tar.*
                cd ../data
                extract ../data.tar.*
                cd ..
                command rm *.tar.* debian-binary
            case '*.zst'
                unzstd --stdout "$full_path" > (string replace -r '\.zst$' '' "$basename")
            case '*.cab' '*.exe'
                cabextract "$full_path"
            case '*.cpio' '*.obscpio'
                cpio -idmvF "$full_path"
            case '*.zpaq'
                zpaq x "$full_path"
            case '*.zlib'
                zlib-flate -uncompress < "$full_path" > (string replace -r '\.zlib$' '' "$basename")
            case '*'
                echo "extract: '$file' cannot be extracted" >&2
                set success 1
        end

        if test "$remove_archive" -a $status -eq 0
            command rm "$full_path"
        end

        cd "$pwd"

        # If extract dir has a single entry, move it up
        set -l contents $extract_dir/*
        switch (count $contents)
            case 1
                if test -e "$contents[1]"
                    if test (basename "$contents[1]") = "$extract_dir"
                        command mv "$contents[1]" "$extract_dir-$rand"
                        command rmdir "$extract_dir"
                        command mv "$extract_dir-$rand" "$extract_dir"
                    else if not test -e (basename "$contents[1]")
                        command mv "$contents[1]" .
                        command rmdir "$extract_dir"
                    end
                end
            case 0
                command rmdir "$extract_dir"
        end
    end
end

alias x extract
