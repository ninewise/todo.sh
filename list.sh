#!/bin/sh

conf="${XDG_CONFIG_HOME:-$HOME/.config}/todo.sh"
conf="enabled" # TODO

find "$conf" -mindepth 1 -maxdepth 1 | while read tool; do
	"$tool/list" | while read date id summary; do
		printf "%d\t%s\t%s\n" "$date" "$(date -d "@$date")" "$summary"
	done
done | sort -rn | cut -f2-
