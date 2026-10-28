function ng --description 'Open nvim with MyGrugFar'
    if set -q NVIM
        nvim +"chdir $PWD" +"MyGrugFar --nogit=$argv[1]"
    else
        nvim +"MyGrugFar --nogit=$argv[1]" +"tabonly"
    end
end
