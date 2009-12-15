#!/usr/bin/perl

use 5.006;

use strict;
use warnings;
no  warnings 'syntax';

use Test::More 0.88;

our $r = eval "require Test::NoWarnings; 1";

BEGIN {
    use_ok ('Regexp::Common510::String') or
        BAIL_OUT ("Loading of 'Regexp::Common510::String' failed");
}

ok defined $Regexp::Common510::String::VERSION, "VERSION is set";

Test::NoWarnings::had_no_warnings () if $r;

done_testing;
