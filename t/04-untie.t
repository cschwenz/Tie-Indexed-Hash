#!perl -T

use Test::More tests => 1;
use Tie::Indexed::Hash;

{
  my @list = ('foo', 'bar', 'baz', 'quux');
  my %indexed; tie %indexed, 'Tie::Indexed::Hash';
  $indexed{'foo'} = 1;
  $indexed{'bar'} = 2;
  $indexed{'baz'} = 3;
  $indexed{'quux'} = 4;
  my $status = untie %indexed;
  ok($status == 1);
}

