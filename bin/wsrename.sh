#!/usr/bin/fish

set filename "$HOME/.ws-name-history"

if test -e $filename
    echo -n
else
    touch $filename
end

set var (cat $filename | ilia -p textlist)

if [ "$var" = "" ]
	exit
end

i3-msg rename workspace to (i3-msg -t get_workspaces | jq 'map(select(.focused))[0].name' | string replace -r "(<span font_desc.*?>) (\d*)(.*?)(</span>)" "\$1 \$2$var \$4")

grep "^$var\$" ~/.ws-name-history || echo $var >> ~/.ws-name-history
