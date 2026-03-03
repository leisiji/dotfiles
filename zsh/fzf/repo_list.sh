if [[ ${1} == "directory" ]]; then
	fd -t d --no-ignore -a --base-directory ${2}
else
	for i in $(repo list 2>/dev/null | awk '{print $1}'); do
		git_dir=${2}/${i}
		if git -C ${git_dir} rev-parse --git-dir > /dev/null 2>&1; then
			git -C ${git_dir} ls-files | sed "s|^|${git_dir}/|"
		fi
	done
fi
