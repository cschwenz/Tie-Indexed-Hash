#!perl -T

use Test::More tests => 4;
use Tie::Indexed::Hash;

{
  my %indexed; tie %indexed, 'Tie::Indexed::Hash';
  $indexed{'a'} = 1;
  $indexed{'b'} = 2;
  delete $indexed{'b'};
  my @k = keys %indexed;
  ok(not exists $indexed{'b'});
  ok(scalar(@k) == 1);
}

{
  my %indexed; tie %indexed, 'Tie::Indexed::Hash';
  %indexed = ( c => 3, d => 4 );
  delete $indexed{'d'};
  my @k = keys %indexed;
  ok(not exists $indexed{'d'});
  ok(scalar(@k) == 1);
}

