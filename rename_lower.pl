#!/usr/bin/perl

my $directory = ".";
opendir(dir, $directory) || warn "Oh noooo ... $!\n";

foreach(readdir(dir))
{
	next if -d $_;
	chomp;
	if (!/[A-Z]/)
	{
		print "file $_ is already in lowercase\n";
		next;
	}
	print "lets lowercase the file $_\n";
	rename "$_", eval
	{
		tr/[A-Z]/[a-z]/;
		$_;
	};
}

close dir;
