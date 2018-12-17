#!/bin/sh

conf="${XDG_CONFIG_HOME:-$HOME/.config}/todo.sh"
conf="enabled" # TODO

if [ -n "$1" ]; then
	tool="$(echo "$2" | cut -f1)"
	id="$(echo "$2" | cut -f3)"
	grep -C 5 "$id" "$1" | while read tool date id summary; do
		printf "%s\t%s\n" "$(date -d "@$date")" "$summary"
	done
	echo "============================================================"
	"$conf/$tool/show" "$id"
	exit 0
fi

temp="$(mktemp)"
find "$conf" -mindepth 1 -maxdepth 1 -printf "%f\n" | while read tool; do
	"$conf/$tool/list" | sed "s/^/$tool\t/"
done | sort -rn > "$temp"

LESSOPEN="|$0 '$temp' %s" xargs -d'\n' less -R < "$temp"

rm "$temp"
