#!/usr/bin/env bash
set -e

description="Install docker-compose"

while :
do
    case $1 in
        --compose-version=*)
            compose_version=${1#*=}
            shift
            ;;
        --provisioned-dir=*)
            provisioned_dir=${1#*=}
            shift
            ;;
        --runfile-name=*)
            runfile_name=${1#*=}
            shift
            ;;
        --script-dir=*)
            script_dir=${1#*=}
            shift
            ;;
        --) # End of all options
            shift
            break
            ;;
        -*)
            echo "WARN: Unknown option (ignored): $1" >&2
            shift
            ;;
        *)  # no more options. Stop while loop
            break
            ;;
    esac
done

runfile="${provisioned_dir}/${runfile_name}"

curl -L https://github.com/docker/compose/releases/download/${compose_version}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

touch "${runfile}"