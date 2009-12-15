package Regexp::Common510::String;

use 5.006;
use strict;
use warnings;
no  warnings 'syntax';

our $VERSION = '2009121501';

use Regexp::Common510;

pattern String   =>  'quoted',
        -config  => {-delim => ['"', '"'],
                     -esc   => '\\'},
        -pattern => \&delimited;

pattern String   =>  'delimited',
        -config  => {-delim => ['{', '}'],
                     -esc   => undef},
        -pattern => \&delimited;


sub delimited {
    my  %arg = @_;
    my  $esc = $arg {-esc} // "";
    my ($open, $close);

    if (@{$arg {-delim}} >= 2) {
        ($open, $close) = @{$arg {-delim}};
    }
    else {
        $close = $open = $arg {-delim} [0];
        $close =~ tr !({[<!)}]>!;
    }

    #
    # Sanity checks.
    #
    die "Delimiters need to be at least one character"
         if grep {!defined ($_) || length ($_) < 1} $open, $close;
    die "You need as many open as close delimiter"
         unless length ($open) == length ($close);
    die "The escape character needs to be a single character"
         unless length ($_) <= 1;

    $_ = quotemeta $_ for $esc, $open, $close;

    my @pats;
    for (my $i = 0; $i < length $open; $i ++) {
        my $o = substr $open,  $i, 1;
        my $c = substr $close, $i, 1;

        my $body;
        if (length $esc) {
            $body = "[^$c$esc]*(?:$esc(?s:.)[^$c$esc]*)*";
        }
        else {
            $body = "[^$c]*";
        }

        push @pats =>      "(?k<string>:(?k<open_delimiter>:$o)" .
                      "(?k<body>:$body)(?k<close_delimiter>:$c)";
    }

    local $" = "|";
    "(?k<string>:(?|@pats))";
}

1;

__END__

=head1 NAME

Regexp::Common510::String - Abstract

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 BUGS

=head1 TODO

=head1 SEE ALSO

=head1 DEVELOPMENT

The current sources of this module are found on github,
L<< git://github.com/Abigail/Regexp--Common510--String.git >>.

=head1 AUTHOR

Abigail, L<< mailto:cpan@abigail.be >>.

=head1 COPYRIGHT and LICENSE

Copyright (C) 2009 by Abigail.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),   
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT
OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

=head1 INSTALLATION

To install this module, run, after unpacking the tar-ball, the 
following commands:

   perl Makefile.PL
   make
   make test
   make install

=cut
