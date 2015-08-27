#!/usr/bin/perl -w

do 'ch.pl';
do 'sec_suid_arqs.pl';

@arqs = `find / -perm -4000 -user 0`;

foreach $arq (@arqs)
{
	if ( !defined($suid_arqs{$arq}) )
	{
		$suid_arqs{$arq} = 0;

		$arq_vars = 'sec_suid_arqs.pl';
		open ( ARQ, ">>$arq_vars" ) or
			ch_log("$0", '01', "Erro ao abrir $arq_vars") and
			exit 1;
		
		print ARQ "\$suid_arqs{'$arq'} = 0;\n";

		close (ARQ);
	}
}
