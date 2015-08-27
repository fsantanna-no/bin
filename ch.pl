$path_log = '/var/log/ch.log';
	
sub ch_data
{
	my @data = localtime();

	# segundo
	$data[0] = 0 . $data[0] if ($data[0] < 10);
	# minuto
	$data[1] = 0 . $data[1] if ($data[1] < 10);
	# hora
	$data[2] = 0 . $data[2] if ($data[2] < 10);
	# dia
	$data[3] = 0 . $data[3] if ($data[3] < 10);
	# mes
	$data[4] = 0 . $data[4] if ($data[4] < 10);
	# ano
	$data[5] += 1900;

	# dia/mes/ano hh:mm:ss
	my $data = "$data[3]/$data[4]/$data[5] $data[2]:$data[1]:$data[0]";

	return $data;
}

sub sup_cod_arq
{
	my $arq = shift;

	do 'ch_cod_arqs.pl';

	if ( !defined($cod_arqs{$arq}) )
	{
		$cod = 0;

		$cod_arqs{$arq} = $cod;

		$arq_vars = 'ch_cod_arqs.pl';
		open ( ARQ, ">>$arq_vars" ) or
			die "Erro na abertura do ch_cod_arqs.pl!";
		
		print ARQ "\$cod_arqs{'$arq'} = $cod;\n";

		close (ARQ);
	}
	return $cod;
}

sub ch_log
{
	# parametros da funcao
	my $arq = shift;
	my $cod = shift;
	my $msg = shift;

	# abre arquivo de log
	open ( LOG, ">>$path_log" ) or die "Erro na abertura do LOG geral!";

	# data do log
	my $data = ch_data();

	# codigo do log
	my $cod_arq = ch_cod_arq($arq);
	$cod = "$cod_arq-$cod";

	# escreve no log
	print LOG "$data # $arq # $msg\n";

	# fecha o log
	close (LOG);
}
