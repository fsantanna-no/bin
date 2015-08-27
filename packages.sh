#!/bin/sh

cat lixo.pkg | while read LINHA
do
	pkg_add $LINHA
done

#while read LINHA < lixo.pkg
#do
	#PKG=`echo $LINHA | sed -e 's/\-*//'`
	#ls /var/db/pkg | grep $PKG
#done
