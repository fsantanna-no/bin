#!/usr/bin/perl -w

$conf = '/chico/.conf/manual_html.rc';
$html = '/chico/Doc/manual.html';

open ( CONF, "$conf" ) or
	warn "Erro ao abrir $conf" and
	exit 1;

open ( HTML, ">$html") or
	warn "Erro ao abrir $html" and
	exit 1;

print HTML <<EOF;
<title>Manuais e Referências</title>
<body bgcolor=white>
<center><h1> Manuais e Referências </h1></center>

EOF
		
while (<CONF>)
{
	print HTML "<br>\n";

	($titulo, $link) = /([^\t]*)\t+(.*)/;

	next if (!$titulo);

	($file) = $link =~ /(.*)\#/;
	$file = $link unless $file;
	if (! -e $file)
	{
		print "ERRO - $titulo: $link: $file\n";
		next;
	}

	print "$titulo...\n";
	print HTML "<a href=\"$link\">$titulo</a><br>\n";
	next;
}
