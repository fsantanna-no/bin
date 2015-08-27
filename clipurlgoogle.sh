#!/bin/sh

BROWSER=/usr/local/firefox/firefox

# conteudo do buffer
url=`/chico/bin/xclip -o`

# espacos->+
url=`echo $url | sed -e "s/ /\+/g"`

if $BROWSER -remote "ping()"
then
	$BROWSER -remote "openurl(http://www.google.com/search?q=$url, new-tab)"
else
	$BROWSER http://www.google.com/search?q=$url
fi
