#!/bin/sh

source /chico/bin/bash_lib.rc

sim "PortuguÍs?"
[ $res = "n" ] && ENG="-d american"
echo $ENG
/chico/bin/xclip -o  | ispell $ENG -a | less
