#source $CONF/funcoeszz

# TIPO: funcoes
# help das funções procurando "$1"
# cchelp prog
function cchelp()
{
	cat $CONF/bash_functions.rc |
	while read LINE
	do
		if (echo $LINE | grep "TIPO:" | grep -qv "LIXO")		# LIXO
		then
			TIPO=${LINE:8}		# :8 a partir do 8 caractere da string
			COM=
			while read LINE
			do
				if (echo $LINE | grep -q "function ")
				then
					FUNC=${LINE:9}
					break
				else
					COM="$COM\n\t${LINE:2}"
				fi
			done

			if (echo $FUNC | grep -q "$1") || (echo $TIPO | grep -q "$1") ||
				(echo $COM | grep -q "$1")
			then
				echo $FUNC:
				echo -n "	$TIPO"
				echo -e "$COM"		# -e interpreta \n \t
				echo
			fi
		fi
	done
}

# TIPO: apps
# extrai os arquivos da máquina digital para o diretório corrente
function cccam()
{
	SRC=/mnt/usb-storage/device-0/dcim/101msdcf
	DST=${1:-.}
	I=0

	# para todos arquivos em SRC, mova para DST com nome unico
	for ARQ in $SRC/*.jpg
	do
		I=$((I+1))						# nome unico
		SEQ=`date +%s`_$I				# nome com data atual
		mv $ARQ $DST/$SEQ.jpg			# move SRC->DST
	done

	killa gqview						# mata atual gqview
	gqview -f -s $DST/*.jpg &			# fullscreen, slideshow
}

# TIPO: apps
# executa o xmms no subdiretório "$1" das MP3's
# ccmp3 Forro
function ccmp3()
{
	xmms /chico/Files/Mp3/$1 &
}

# TIPO: shell
# procura arquivos recursivamente que case com a pattern
function lsg()
{
	find . -name "*$1*"
}

# TIPO: shell
# extrai arquivos do pacote RPM para diretório currente
function ccrpmcpio()
{
	rpm2cpio $1 | cpio -iv --make-directories
}

# TIPO: shell
# executa tarefas demoradas enquanto o computador ficar livre
function ccidle()
{
	ccidle_aux 2>&1 | tee /tmp/CCIDLE
}

function ccidle_aux()
{
	echo ----------------------------------------
	echo	CCDOC
	echo ----------------------------------------
	ccdoc ...
	echo
	echo ----------------------------------------
	echo	CCBACKUP
	echo ----------------------------------------
	ccbackup all
	ccbackup data
	echo
	echo ----------------------------------------
	echo	CCBIG
	echo ----------------------------------------
	ccbig /
	echo
}

# TIPO: shell
# cria índice para ccdoc
function ccindex()
{
	doc ... $@ 2>&1 | tee /tmp/CCINDEX
}

# TIPO: shell
# procura palavra-chave na documentação
function ccdoc()
{
	doc $@ 2>&1 | tee /tmp/CCDOC
}

# TIPO: shell
# lista 20 maiores arquivos (acima de 1M) a partir do diretório corrente
function ccbig()
{
	DIR=${1:-.}				# o default de DIR é .
	sudo find $DIR -size +1000 -exec ls -s {} \; | sort -nr | head -n 100 | tee /tmp/CCBIG
	# 2000 == 1MB
}

# TIPO: shell
# procura a partir do diretório atual por arquivos que contenham "$1"
# ccfind .sh
function ccfind()
{
	find . -name "*$1*"
}

# TIPO: prog
# mostra arquivos do diretório atual com versões alteradas em relação
# ao ",v" correspondente
function ccrcsdiff()
{
	rcsdiff * 2>&1 | less
}

# TIPO: prog
# executa o less no manual java que encontrar "$1"
# ccapi Rectangle
function ccapi()
{
	find /chico/Doc/Prog/Java/Oficial/api -name "*$1*" -exec less {} \;
}

# TIPO: prog
# apaga arquivos core a partir do diretório corrente
function ccrmcore()
{
	find . -name core -exec rm {} \;
}

# TIPO: prog
function ccjava()
{
	find . -name "*.java*" -exec grep -H "$1" {} \;
}

# TIPO: prog
function ccj()
{
	javac -d ../ $1
}

# TIPO: shell
# BUGENTO
# executa "$1" em um outro wterm
function x()
{
	wterm -e $@ &
}

# TIPO: shell
# faz um backup instantâneo do notebook
# ccbackup etc
function ccbackup()
{
	ccbackup_aux $@ 2>&1 | tee /tmp/CCBACKUP
}
function ccbackup_aux()
{
	make -f $CONF/backup.mk $1
}

# TIPO: shell
# traduz ou retorna o significado de "$1" ou "$2"
# ccdict -t snake
# ccdict worm
function ccdict()
{
	if [ "$1" = "-t" ]
	then
		dict -d freedict-eng-por $2
		dict -d freedict-por-eng $2
		return
	fi
	dict $1
	zzdictodos $1
}

# TIPO: shell
# retorna o conteúdo captado pelo mouse
function ccpaste()
{
	xclip -o $@
}

# TIPO: shell
# imprime o arquivo, mostrando o preview e pedindo confirmação
# ccprint -4 Editor.java
function ccprint()
{
	TOT=$1; shift;
	mpage $TOT -c -b A4 -a $@ > /tmp/tmp-$$.ps
	gv /tmp/tmp-$$.ps &
	sim Imprimir ?
	kill $!

	if [ "$res" = "s" ]
	then
		lpr -o media=A4 -o prettyprint /tmp/tmp-$$.ps
	fi

	rm /tmp/tmp-$$.ps
}

# TIPO: shell
function ccrpm()
{
	URL=http://espelhos.edugraf.ufsc.br/conectiva/10/cds/cd1/conectiva/
	if [ "$1" = "-i" ]
	then
		shift
		echo Instalados:
		rpm -qa | grep -i $1
	fi

	echo
	echo Disponíveis:
	grep -i $1 $CONF/RPMS.txt | tee tmp.$$

	URL=`head -1 tmp.$$ | sed 's/.*	//'`
	rm tmp.$$

	nao "Baixar ?"

	if [ "$res" = "s" ]
	then
		wget --passive-ftp ftp://$URL
	else
		return
	fi

	ARQ=`echo $URL | sed 's|.*/||'`
	ARQ=/data/Temp/$ARQ

	sim "Instalar ?"
	if [ "$res" = "s" ]
	then
		s rpm -U $ARQ
	else
		return
	fi

	sim "Remover ?"
	if [ "$res" = "s" ]
	then
		rm $ARQ
	fi
}

# TIPO: shell
# executar o untar de "$1" mostrando o conteúdo e pedindo confirmação
# ccuntar teste.tgz
function ccuntar()
{
	tar tvzf $1
	sim "Extrair ?"
	if [ "$res" = "s" ]
	then
		tar xvzf $1
	fi
}

# TIPO: shell
# mostra as portas TCP abertas
function cclisten()
{
	netstat -na | grep LISTEN | grep -v "^unix"
}

# TIPO: shell
# aciona o beep do speaker "$1" vezes
# ccbeep 3
function ccbeep()
{
	TOT=${1:-1}				# o default de TOT é 1
	i=1
	while [ $i -le $TOT ]
	do
		echo -n -e "\a"
		sleep 1
		i=$(($i+1))
	done
}

# TIPO: shell
function ccshorts()
{
	grep SHORTCUT /chico/GNUstep/Library/WindowMaker/menu.pt | sort +2 > /chico/Temp/shortcuts.txt
}

# TIPO: outros
# transforma curric.html em formato para o catho
function cccatho()
{
	 DIR=/chico/Chico
	 tr "\n" " " < $DIR/curric.html | tr -d "\t" | \
	 	sed 's|<br><br>||g' | \
		sed 's| style=display:none||g' | \
		sed 's|<a href=javascript:toggle[^<]*</a>||g' > \
		$DIR/curric_catho.html
}

# TIPO: shell
# acompanha o andamento do download de "$1" a cada "$2" segundos
# ccprogress linux.iso 10
function ccprogress()
{
	SEC=${2:-3}				# o default de SEC é 3
	while [ -n 0 ];
	do
		ls -l $1
		sleep $SEC
	done
}

# DESUSO
function contents() {
	less ${1}+CONTENTS
}
function required() {
	less ${1}+REQUIRED_BY
}
function desc() {
	less ${1}pkg-descr
}
function package() {
	#cd /chico/Files/FreeBSD/Listas
	cd /chico/Files/Linux
	grep $1 *.pkg | awk "{ print $5	$9 }"
	cd -
}
function package_list() {
	cd /cdrom/packages/All
	ll > /chico/Files/FreeBSD/Listas/temp.pkg
	cd -
}
function package_pkg() {
	cdpkg
	ll > /chico/Files/FreeBSD/Listas/atual.pkg
	cd -
}

function ppp() {
	sudo kldload ltmdm
	sudo /usr/sbin/ppp
	sudo kldunload ltmdm
}

function iso() {
	sudo vnconfig /dev/vn0 $1
	sudo mount_cd9660 /dev/vn0 /cdrom
}
function uniso() {
	sudo vnconfig -u /dev/vn0
	sudo umount /cdrom
}

function scan() {
	sudo nmap -O $1 > /chico/Server/ataque`date "+%s"`
}

function sup() {
	ARQ=`grep -i $1 /net-open/nas/webadmin/www/cgi-bin/sup_*`
	echo $ARQ
	ARQ=`echo $ARQ | awk -F: '{ print $1 }'`
}
