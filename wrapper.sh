#!/bin/bash

# set flag vars to empty
COMMAND= SESSION=

while getopts :c:s: opt
do
    case $opt in
    c)     COMMAND=$OPTARG
           ;;
    s)     SESSION=$OPTARG
           ;;
    '?')   echo "$0: invalid option -$OPTARG" >&2
           echo "Usage: $0 -c command -s tmux-session" >&2
           exit 1
           ;;
    esac
done

if [ ! -n "${COMMAND}" ]; then
	echo "Usage: $0 -c command -s tmux-session" >&2
	exit 1
fi

if [ ! -n "${SESSION}" ]; then
	echo "Usage: $0 -c command -s tmux-session" >&2
	exit 1
fi


# If session doesn't exist, create it
if /usr/bin/tmux has -t "${SESSION}" 2>/dev/null
then
	:
else
	/usr/bin/tmux new-session -d -s "${SESSION}"
fi

# Run SCRIPT in the tmux SESSION
/usr/bin/tmux send-keys -t "${SESSION}":0 "${COMMAND}" ENTER
