#!/bin/bash
TEMP=`getopt --long repo_name:,tag:,push_date: -n 'logging.sh' -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments.
while true; do
    case $1 in
        --repo_name)
            case "$2" in 
                "") shift 2 ;;
                *) repo_name=$2 ; shift 2 ;;
            esac ;;
        --tag)
            case "$2" in 
                "") shift 2 ;;
                *) tag=$2 ; shift 2 ;;
            esac ;;
        --push_date)
            case "$2" in 
                "") shift 2 ;;
                *) push_name=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

short_name=$(echo "${repo_name}"|cut -d '/' -f 2)
echo '{ service_name: "nginx@1", docker_image: "surycat/nginx", version: "0.2.0" }'
line="{ service_name: "\"${short_name}\""@1, docker_image: "\"${repo_name}\"", version: "\"${tag}\""}, "
echo ${line} >> logs/ansible-line.store