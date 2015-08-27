function is_up()
{
	ping -c 1 $1 > /dev/null 2>&1
}

function default() {
	if [ -z $2 ]
	then
		res=$1
	else
		res=$2
	fi
}

function nao() {
	echo -n "$* [s/N]: "
	read res
	default n $res
}

function sim() {
	echo -n "$* [S/n]: "
	read res
	default s $res
}
