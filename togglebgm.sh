#!/bin/bash 
#Toggle to start / stop any Music Player or Video Player
#source https://www.reddit.com/r/RetroPie/comments/7r3ney/background_music_bgm_menu_toggle/

command="mpg123"

pids="$( pgrep "$command" )"

#if [[ -z "$pids" ]]; then
#    printf '"%s" is not running\n' "$command" >&2
#    exit 1
#fi

for pid in $pids; do
    state="$( ps -ostate= -p "$pid" )"

    stopped=0

    case "$state" in
        *T*)    stopped=1 ;;
    esac

    if (( stopped )); then
        kill -s CONT "$pid"
#        printf '"%s" (%d) has been unpaused\n' "$command" "$pid"
    else
        kill -s STOP "$pid"
#        printf '"%s" (%d) has been paused\n' "$command" "$pid"
    fi
done
