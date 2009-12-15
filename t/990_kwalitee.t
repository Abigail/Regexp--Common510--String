#!/usr/bin/perl

use Test::More;

use strict;
use warnings;
no  warnings 'syntax';

my $garbage = "Debian_CPANTS.txt";

my $KWALITEE = '1.01';

eval "use Test::Kwalitee $KWALITEE; 1" or
      plan skip_all => "Test::Kwalitee $KWALITEE required to test Kwalitee";

if (-f $garbage) {
    unlink $garbage or die "Failed to clean up $garbage";
}


__END__
