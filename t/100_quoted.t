#!/usr/bin/perl
    
use 5.010;
    
use strict;
use warnings;
no  warnings 'syntax';
    
use Test::More 0.88;
use Test::Regexp 2009121001;
    
our $r = eval "require Test::NoWarnings; 1";
    
use Regexp::Common510 'String';
    
my $quoted   = RE String => 'quoted';
my $quoted_k = RE String => 'quoted', -Keep => 1;

my $checker  = Test::Regexp -> new -> init (
    pattern      => $quoted,
    keep_pattern => $quoted_k,
    name         => "String quoted",
);

my @pass = (
    ["",        "body is empty"],
    [" ",       "body is space"],
    ["\n",      "body is a newline"],
);

foreach my $pass (@pass) {
    my ($body, $test) = @$pass;
    my $subject       = qq {"$body"};

    $checker -> match (
        $subject,
        [[string          =>  $subject],
         [open_delimiter  => '"'],
         [body            => $body],
         [close_delimiter => '"']],
        test  => $test
    );
}

done_testing;
