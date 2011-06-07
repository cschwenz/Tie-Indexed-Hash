#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Tie::Indexed::Hash' ) || print "Bail out!
";
}

diag( "Testing Tie::Indexed::Hash $Tie::Indexed::Hash::VERSION, Perl $], $^X" );
