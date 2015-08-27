#!/usr/bin/perl -w
# vim: set sw=4 ts=4 si et:
# copyright: GPL
# version 1.0
use strict;
use vars qw($opt_h);
use Getopt::Std;
#
my $prevhead="";
my $url;
my $title;
my $search;
#
&getopts("h")||die "ERROR: No such option. -h for help.n";
&help if ($opt_h);
if ($ARGV[0]){
    $search=quotemeta($ARGV[0]);
}
open(BOOK,"$ENV{HOME}/.mozilla/chico/kcl4assf.slt/bookmarks.html")||die "ERROR: can not read $ENV{HOME}/.netscape/bookmarks.html\n";
while(<BOOK>){
    if(/<H\d.+?>(.+?)</){
        print "== $1 ==\n" unless($search);
        $prevhead="== $1 ==\n";
    }
    if (/(<A HREF=\"[^\"]+\").+?>(.+?)</){
        $url=$1;$title=$2;
        if ($search){
            if (/$search/io){
                print $prevhead;
                $prevhead="";
            }else{
                next;
            }
        }
        print "$url>$title</A>\n";
    }
}
close BOOK;

#
sub help{
print "showbook -- show my bookmarks or search in them
USAGE: showbook [-h] [search string]

showbook prints your ~/.netscape/bookmarks.html file in text
format or searches for specific bookmarks when a search string
is provided on the command line.

OPTIONS: -h this help text
EXAMPLE: search for .org in my bookmarks
  showbook .org\n";
exit;
}
# showbook was written by guido socher (guido@linuxfocus.org)
__END__ 

