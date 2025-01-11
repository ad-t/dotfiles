#!/usr/bin/env bash

set -euo pipefail

SINK="@DEFAULT_AUDIO_SINK@"

add() {
  python3 -c "print(min(round(${1} + ${2}, 2), 1.0))"
}

sub() {
  python3 -c "print(max(round(${1} - ${2}, 2), 0))"
}

set_absolute_volume() {
  local index="${1}"
  local vol="${2}"
  wpctl set-volume "${index}" "${vol}"
}

get_sink_volume() {
  local index="${1}"
  echo "$(wpctl get-volume ${index} | sed "s/.*: //")"
}

direction="${1}"
current_volume="$(get_sink_volume "${SINK}")"
case "${direction}" in
  up)
    new_volume=$(add ${current_volume} 0.05)
    ;;
  down)
    new_volume=$(sub ${current_volume} 0.05)
    ;;
  *)
    echo "${direction}"
    echo "Invalid command, exiting" && exit 1
    ;;
esac
set_absolute_volume "${SINK}" "${new_volume}"
resulting_volume="$(get_sink_volume "${SINK}")"
percentage_volume="$(python3 -c "print(round(${resulting_volume} * 100, 0))")"
dunstify --replace=1111 --hints=int:value:"${percentage_volume}%" "Volume" --timeout=500
