#!/usr/bin/fish

set var (cat ~/.ws-name-history | ilia -p textlist)

if [ "$var" = "" ]
	exit
end

i3-msg rename workspace to (i3-msg -t get_workspaces | jq 'map(select(.focused))[0].name' | string replace -r "(<span font_desc.*?>) (\d*)(.*?)(</span>)" "\$1 \$2$var \$4")

grep "^$var\$" ~/.ws-name-history || echo $var >> ~/.ws-name-history
