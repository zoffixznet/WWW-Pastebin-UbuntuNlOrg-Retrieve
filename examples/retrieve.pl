#!/usr/bin/env perl

use strict;
use warnings;

use lib '../lib';
use WWW::Pastebin::UbuntuNlOrg::Retrieve;

die "Usage: perl retrieve.pl <paste_ID_or_URI>\n"
    unless @ARGV;

my $Paste = shift;

my $paster = WWW::Pastebin::UbuntuNlOrg::Retrieve->new;

my $res = $paster->retrieve( $Paste );

printf "The paste was posted on %s by %s\nIt is written in %s\n%s\n",
            @$res{ qw(posted_on  name  lang) }, $paster;


