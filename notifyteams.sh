#!/bin/bash
PATH="${PATH}":"${HOME}"/go/bin

# set flag vars to empty
TARGET=

while getopts :t: opt
do
    case $opt in
    t)     TARGET=$OPTARG
           ;;
    '?')   echo "$0: invalid option -$OPTARG" >&2
           echo "Usage: $0 -t target" >&2
           exit 1
           ;;
    esac
done

if [ ! -n "${TARGET}" ]; then
	echo "Usage: $0 -t target" 
	exit 1
fi

if [ -s "${HOME}/.proteus/rawdata/${TARGET}/host.txt.new" ]
then
        cat "${HOME}/.proteus/rawdata/${TARGET}/host.txt.new" | notify -silent -bulk -p teams -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml -mf "New ${TARGET} hosts found
	{{data}}"
fi

if [ -s "${HOME}/.proteus/rawdata/${TARGET}/url.txt.new" ]
then
        cat "${HOME}/.proteus/rawdata/${TARGET}/url.txt.new" | notify -silent -bulk -p teams -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml -mf "New ${TARGET} URLs found
	{{data}}"
fi

n=$(while read -r h; do grep "${h}" "${HOME}"/Projects/proteus_output/nuclei.new;done < "${HOME}/.proteus/scope/${TARGET}")

if [ -n "${n}" ]; then
	echo "${n}" | notify -silent -bulk -p teams -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml -mf "New ${TARGET} nuclei found
        {{data}}"
fi

# Log complete to discord
echo "notifyteams.sh ${TARGET} Complete" | notify -silent -p discord -id general -pc "${HOME}"/Projects/proteus_output/scripts/notify.yaml >/dev/null
