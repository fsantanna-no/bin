#!/bin/sh

BROWSER=/usr/local/firefox/firefox

if $BROWSER -remote "ping()"
then
	$BROWSER -remote "openurl(`xclip -o`, new-tab)"
else
	$BROWSER `xclip -o`
fi
