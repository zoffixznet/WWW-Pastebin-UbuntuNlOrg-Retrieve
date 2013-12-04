#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 16;

my $URI = 'http://paste.ubuntu-nl.org/60877/';
my $ID = '60877';
my $Dump = {
          "lang" => "Perl",
          "posted_on" => "March 24th 18:15",
          "content" => "{ test => 1 }, [ foo => 'bar' ]",
          "name" => "Zoffix"
        };

BEGIN {
    use_ok('Carp');
    use_ok('WWW::Pastebin::Base::Retrieve');
    use_ok('HTML::TokeParser::Simple');
    use_ok('HTML::Entities');
    use_ok('URI');
    use_ok('WWW::Pastebin::UbuntuNlOrg::Retrieve');
}

diag( "Testing WWW::Pastebin::UbuntuNlOrg::Retrieve $WWW::Pastebin::UbuntuNlOrg::Retrieve::VERSION, Perl $], $^X" );

my $o = WWW::Pastebin::UbuntuNlOrg::Retrieve->new(timeout => 10);
isa_ok( $o, 'WWW::Pastebin::UbuntuNlOrg::Retrieve' );
can_ok( $o, qw( new content uri id results retrieve error _set_error _parse));
isa_ok( $o->ua, 'LWP::UserAgent');

SKIP: {
    my $r = $o->retrieve($URI);
    
    unless ( $r ) {
        diag "\nGot error: " . $o->error . "\n\n";
        ok( (defined $o->error and length $o->error),
            'error() contains error'
        );
        skip "Got error", 6;
    }
    is_deeply( $r, $Dump, 'output from retrieve() matches dump' );
    isa_ok( $o->uri, 'URI::http', 'uri() method' );
    is( $o->uri, $URI, 'uri() matches URI');
    is( $o->id, $ID, 'id() matches ID');
    is( $r->{content}, $o->content, 'content() method' );
    is( $r->{content}, "$o", 'overloads' );
    is_deeply( $r, $o->results, 'results() methods' );
}


