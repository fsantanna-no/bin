#!/bin/sh

cd /etc/X11

case $1 in

casa)
	modprobe hid; modprobe mousedev
	cp XF86Config-4.usb XF86Config-4
	;;
*)
	#dhclient -1 eth0
	cp XF86Config-4.ps2 XF86Config-4
	;;

esac
