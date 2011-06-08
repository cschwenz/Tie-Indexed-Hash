#!perl -T

use Test::More tests => 6;
use Tie::Indexed::Hash;

{
  my %indexed; tie %indexed, 'Tie::Indexed::Hash';
  $indexed{'a'} = 1;
  $indexed{'b'} = 2;
  ok($indexed{'a'} == 1);
  ok($indexed{'b'} == 2);
}

{
  my %indexed; tie %indexed, 'Tie::Indexed::Hash';
  %indexed = ( c => 3, d => 4 );
  ok($indexed{'c'} == 3);
  ok($indexed{'d'} == 4);
}

{
  my %indexed; tie %indexed, 'Tie::Indexed::Hash';
  %indexed = ( e => 5, f => 6, g => 7 );
  my @k = keys %indexed;
  ok(scalar(@k) == 3);
  ok($k[1] eq 'f');
}

