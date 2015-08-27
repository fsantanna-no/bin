#!/bin/sh

find /chico/Doc/Prog/Java/Oficial/api -name "*`xclip -o`*" -exec less {} \;
