#!perl -T

use Test::More tests => 13;
use Tie::Indexed::Hash;

{
  my @list = ('foo', 'bar', 'baz', 'quux', 'asdf', 'zxcv');
  my %indexed; tie %indexed, 'Tie::Indexed::Hash';
  $indexed{'foo'} = 1;
  $indexed{'bar'} = 2;
  $indexed{'baz'} = 3;
  $indexed{'quux'} = 4;
  $indexed{'asdf'} = 5;
  $indexed{'zxcv'} = 6;
  my @k = keys %indexed;
  ok(scalar(@k) == scalar(@list));
  ok($k[0] eq $list[0]);
  ok($k[1] eq $list[1]);
  ok($k[2] eq $list[2]);
  ok($k[3] eq $list[3]);
  ok($k[4] eq $list[4]);
  ok($k[5] eq $list[5]);
  ok($indexed{$k[0]} == 1);
  ok($indexed{$k[1]} == 2);
  ok($indexed{$k[2]} == 3);
  ok($indexed{$k[3]} == 4);
  ok($indexed{$k[4]} == 5);
  ok($indexed{$k[5]} == 6);
}

