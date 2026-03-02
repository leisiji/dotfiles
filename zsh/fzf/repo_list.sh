for i in $(repo list 2>/dev/null | awk '{print $1}'); do
	[[ ${1} == "directory" ]] && echo ${2}/${i};
	fd -t ${1} -a --base-directory ${2}/${i};
done
