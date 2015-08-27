#LC_ALL=pt_BR
#LC_CTYPE=ISO-8859-1
#LESSCHARSET=latin1
#export LANG LC_ALL
#LC_CTYPE=LESSCHARSET

export PATH="$PATH:/linux/bin:/sbin:/usr/sbin:/usr/local/sbin"
export PATH="$PATH:/opt/android-ndk"
export PATH="$PATH:/data/bin"
export PATH="$PATH:/data/ceu/ceu"
export PATH="$PATH:/opt/freeciv/bin"

export CVS_RSH="/usr/bin/ssh"
export HISTFILESIZE=10000
export PS1="\u@\h:\w$ "

#export LUA_INIT="@/data/Lua/common/init.lua"
#export LUA_INIT="@/data/Lua/init.lua"
export LUA_PATH="/data/Lua/?.lua;?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua"
export LUA_CPATH="/data/Lua/?.so;/usr/local/share/lua/5.1/?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so"

export TOSROOT=/opt/tinyos-release
export TOSDIR=$TOSROOT/tos
export MAKERULES=$TOSROOT/support/make/Makerules
export CLASSPATH=$TOSROOT/support/sdk/java/tinyos.jar:.
export PYTHONPATH=$TOSROOT/support/sdk/python:$PYTHONPATH
export PATH=$TOSROOT/support/sdk/c:$PATH

export ANDROID_PATH="/opt/android-sdk"
export PATH="$PATH:$ANDROID_PATH/tools/:$ANDROID_PATH/platform-tools"

#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk/

#function parse_git_branch {
    #ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    #echo "("${ref#refs/heads/}") "
  #}
  #PS1="\$(parse_git_branch)$ "
#A command I miss:
#alias 
#cls="echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo"
#A visibility improvement (ls every time you cd):
#function cd() { builtin cd "$@" && ls; }

source bash_aliases.sh
source bash_functions.sh
