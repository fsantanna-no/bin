#!/bin/sh

#/chico/bin/xclip -o | indent -bl > /chico/Temp/LIXAO.txt
/chico/bin/xclip -o  > /chico/Temp/LIXAO.txt
gvim -n /chico/Temp/LIXAO.txt
