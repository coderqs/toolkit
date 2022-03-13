#! /bin/bash

project_name="$1"
full_struct="${2:-0}"

# ------------
platform_list=( \
	"vs2019" \
	"linux" \
	"android" \
	)

required_dir_list=( \
	"builds" \
	"cmak" \
	"config" \
	"sample" \
	"scripts" \
	"src" \
	"test/uint" \
)

optional_dir_list=(\
	"3rdparty" \
	"data" \
	"doc" \
	"bin" \
	"lib" \
	"include" \
)

function CheckParam() {
    if [ -z ${project_name} ]; then
        echo "The first argument entered error, project name can't is empty."
        exit 1
    fi

    if [ ${full_struct} -ne 0 -a ${full_struct} -ne 1 ]; then
        echo "The second argument entered error, can't is "\"${full_struct}\"", it can only be 0 or 1."
        exit 1
    fi

}

function CreateDirStruct() {
	for _dir in ${required_dir_list[@]};do
		mkdir -p ./${project_name}/${_dir}
	done
	for _dir in ${platform_list[@]};do
		mkdir -p ./${project_name}/builds/${_dir}
	done
	
	if [ ${full_struct} -eq 1 ];then
		for _dir in ${optional_dir_list[@]};do
			mkdir -p ./${project_name}/${_dir}
		done
	fi
	
	echo "#${project_name}" > ${project_name}/readme.txt
}

function main() {
	CheckParam

	CreateDirStruct
}

main