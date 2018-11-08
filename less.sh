#!/bin/sh

conf="${XDG_CONFIG_HOME:-$HOME/.config}/todo.sh"
conf="enabled" # TODO

if [ -n "$1" ]; then
	tool="$(dirname "$2")"
	item="$(basename "$2")"
	grep -C 5 "$2" "$1" | while read toolitem; do
		ntool="$(dirname "$toolitem")"
		nitem="$(basename "$toolitem")"
		ndate="$("$ntool/date" "$nitem")"
		printf "%s\t%s\n" "$(date -d "@$ndate")" "$("$ntool/summarize" "$nitem")"
	done
	echo "============================================================"
	"$tool/show" "$item"
	exit 0
fi

temp="$(mktemp)"
find "$conf" -mindepth 1 -maxdepth 1 | while read tool; do
	"$tool/list" | while read item; do
		date="$("$tool/date" "$item")"
		printf "%d\t%s\n" "$date" "$tool/$item"
	done
done | sort -rn | cut --complement -f1 > "$temp"

tr '\n' '\0' < "$temp" | LESSOPEN="|$0 '$temp' '%s'" xargs -0 less -R
# LESSOPEN="|$0 '$temp' '%s'" xargs -0 less -R

rm "$temp"
