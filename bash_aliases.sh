# GDB

alias bt='gdb -batch -ex "run" -ex "bt" --args'

# APPS

alias eclipse='s /opt/eclipse/eclipse -vm /usr/lib/java/bin/java'

# MUDA OPCOES

alias l='ls -lFA --color=auto'	# long / indicator(*/=@|)
alias lst='l /tmp'
alias less='less -m'		# long prompt
#alias wget='wget -P /data/Download'
alias bc='bc -l'		# -lmath
alias aspell='aspell -l pt-br -c'

# GREP

alias gcc='gcc -Wall'		  # todos os warnings
alias grep='grep -s --color'  # sem err msgs / ignore case
alias psg='/bin/ps ax | grep' # com grep, espera key
alias h='history | grep'      # com grep, espera key

alias ps='ps ax | less'
alias s='sudo'
alias gvim='gvim -geom 86x50'
alias vi='vim'

# TAIL
alias t='s tail -f'
alias th='t -f /var/log/httpd-error.log'
alias tm='t -f /var/log/messages'
alias tmail='t -f /var/log/maillog'
alias tf='t -f /var/log/fetchmail.log'
alias tnas='t -f /webadmin/logs/nas.log'

# CD
alias -- '-'='cd -'
alias ..='cd ..'
alias cdd='cd /data/Download'
alias cdm='cd /data/Mp3'
alias cdc='cd $CONF'
#alias cd='pushd'
#alias p='popd'
alias cdpkg='cd /var/db/pkg'
alias cdlog='cd /var/log'
alias cdt='cd /data/Puc/tv'
alias cdg='cd /home/chico/Telemidia/ginga/gingacc-player/src'

# DESUSO

alias msg_teste='echo teste | mail -steste chico.santanna@uol.com.br'
alias ispellbr='ispell -d br'
alias doc='. doc'
#alias wterm='wterm -fb arial +wm'

# PILOT
alias isilo='iSiloBSD'
alias pilot_man='man -M /usr/local/pilot/man'

alias civclient='LANG=en civclient'
alias civserver='cd /usr/local/freeciv/jogos; LANG=en civserver'
alias tina='sudo shlight //tina/c /tina -n'
#alias pilot_backup='sudo pilot-xfer --backup $CONF/Pilot/Backup'
#alias iso='cd /desktop ; sudo /usr/local/bin/wget --passive-ftp -c -N ftp://ftp.br.freebsd.org/pub/FreeBSD/releases/i386/ISO-IMAGES/4.3-install.iso'
