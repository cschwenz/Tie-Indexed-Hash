
use strict;
use warnings;
use lib './lib/';
use Tie::Indexed::Hash;
use Tie::IxHash;
use Benchmark qw(:hireswallclock timethese cmpthese);

$Benchmark::Default_Format = '6.3f';


my @alpha = ('A' .. 'Z', 'a' .. 'z', '0' .. '9', '_');

sub gen_key {
  $alpha[int(rand(scalar(@alpha)))] . $alpha[int(rand(scalar(@alpha)))] .
  $alpha[int(rand(scalar(@alpha)))] . $alpha[int(rand(scalar(@alpha)))];
}

sub large_dataset {
  my @data = ();
  while(scalar(@data) < 5000) {
    push @data, gen_key(), rand(50000);
  }
  @data;
}

sub small_dataset {
  my @data = ();
  while(scalar(@data) < 50) {
    push @data, gen_key(), rand(50000);
  }
  @data;
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = ();
  %ixhash = ();
  my %perlhash = ();
  print ' ' . ('=' x 78) . "\n";
  print "   [Increment : Empty]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      $indexed{gen_key()}++;
                    },
                  'Tie::IxHash' => sub {
                      $ixhash{gen_key()}++;
                    },
                  'PerlHash' => sub {
                      $perlhash{gen_key()}++;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Increment : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      $indexed{gen_key()}++;
                    },
                  'Tie::IxHash' => sub {
                      $ixhash{gen_key()}++;
                    },
                  'PerlHash' => sub {
                      $perlhash{gen_key()}++;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Increment : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      $indexed{gen_key()}++;
                    },
                  'Tie::IxHash' => sub {
                      $ixhash{gen_key()}++;
                    },
                  'PerlHash' => sub {
                      $perlhash{gen_key()}++;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = ();
  %ixhash = ();
  my %perlhash = ();
  print ' ' . ('=' x 78) . "\n";
  print "   [Insertion : Empty]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      $indexed{gen_key()} = 1;
                    },
                  'Tie::IxHash' => sub {
                      $ixhash{gen_key()} = 1;
                    },
                  'PerlHash' => sub {
                      $perlhash{gen_key()} = 1;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Insertion : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      $indexed{gen_key()} = 1;
                    },
                  'Tie::IxHash' => sub {
                      $ixhash{gen_key()} = 1;
                    },
                  'PerlHash' => sub {
                      $perlhash{gen_key()} = 1;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Insertion : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      $indexed{gen_key()} = 1;
                    },
                  'Tie::IxHash' => sub {
                      $ixhash{gen_key()} = 1;
                    },
                  'PerlHash' => sub {
                      $perlhash{gen_key()} = 1;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Retrieval : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my $temp = $indexed{gen_key()};
                    },
                  'Tie::IxHash' => sub {
                      my $temp = $ixhash{gen_key()};
                    },
                  'PerlHash' => sub {
                      my $temp = $perlhash{gen_key()};
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Retrieval : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my $temp = $indexed{gen_key()};
                    },
                  'Tie::IxHash' => sub {
                      my $temp = $ixhash{gen_key()};
                    },
                  'PerlHash' => sub {
                      my $temp = $perlhash{gen_key()};
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Clear/Reassign : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 100, {
                  'Tie::Indexed::Hash' => sub {
                      %indexed = ();
                      %indexed = large_dataset();
                    },
                  'Tie::IxHash' => sub {
                      %ixhash = ();
                      %ixhash = large_dataset();
                    },
                  'PerlHash' => sub {
                      %perlhash = ();
                      %perlhash = large_dataset();
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Clear/Reassign : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 20_000, {
                  'Tie::Indexed::Hash' => sub {
                      %indexed = ();
                      %indexed = small_dataset();
                    },
                  'Tie::IxHash' => sub {
                      %ixhash = ();
                      %ixhash = small_dataset();
                    },
                  'PerlHash' => sub {
                      %perlhash = ();
                      %perlhash = small_dataset();
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Exists : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my $key = gen_key();
                      if(exists $indexed{$key}) {
                        $indexed{$key} = 1;
                      }
                    },
                  'Tie::IxHash' => sub {
                      my $key = gen_key();
                      if(exists $ixhash{$key}) {
                        $ixhash{$key} = 1;
                      }
                    },
                  'PerlHash' => sub {
                      my $key = gen_key();
                      if(exists $perlhash{$key}) {
                        $perlhash{$key} = 1;
                      }
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Exists : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my $key = gen_key();
                      if(exists $indexed{$key}) {
                        $indexed{$key} = 1;
                      }
                    },
                  'Tie::IxHash' => sub {
                      my $key = gen_key();
                      if(exists $ixhash{$key}) {
                        $ixhash{$key} = 1;
                      }
                    },
                  'PerlHash' => sub {
                      my $key = gen_key();
                      if(exists $perlhash{$key}) {
                        $perlhash{$key} = 1;
                      }
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Exists/Delete : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my $key = gen_key();
                      if(exists $indexed{$key}) {
                        delete $indexed{$key};
                      }
                    },
                  'Tie::IxHash' => sub {
                      my $key = gen_key();
                      if(exists $ixhash{$key}) {
                        delete $ixhash{$key};
                      }
                    },
                  'PerlHash' => sub {
                      my $key = gen_key();
                      if(exists $perlhash{$key}) {
                        delete $perlhash{$key};
                      }
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Exists/Delete : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my $key = gen_key();
                      if(exists $indexed{$key}) {
                        delete $indexed{$key};
                      }
                    },
                  'Tie::IxHash' => sub {
                      my $key = gen_key();
                      if(exists $ixhash{$key}) {
                        delete $ixhash{$key};
                      }
                    },
                  'PerlHash' => sub {
                      my $key = gen_key();
                      if(exists $perlhash{$key}) {
                        delete $perlhash{$key};
                      }
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Exists/Defined : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my $key = gen_key();
                      if((exists $indexed{$key}) && (defined $indexed{$key})) {
                        $indexed{$key} += 2;
                      }
                    },
                  'Tie::IxHash' => sub {
                      my $key = gen_key();
                      if((exists $ixhash{$key}) && (defined $ixhash{$key})) {
                        $ixhash{$key} += 2;
                      }
                    },
                  'PerlHash' => sub {
                      my $key = gen_key();
                      if((exists $perlhash{$key}) && (defined $perlhash{$key})) {
                        $perlhash{$key} += 2;
                      }
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Exists/Defined : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my $key = gen_key();
                      if((exists $indexed{$key}) && (defined $indexed{$key})) {
                        $indexed{$key} += 2;
                      }
                    },
                  'Tie::IxHash' => sub {
                      my $key = gen_key();
                      if((exists $ixhash{$key}) && (defined $ixhash{$key})) {
                        $ixhash{$key} += 2;
                      }
                    },
                  'PerlHash' => sub {
                      my $key = gen_key();
                      if((exists $perlhash{$key}) && (defined $perlhash{$key})) {
                        $perlhash{$key} += 2;
                      }
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Keys : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 5_000, {
                  'Tie::Indexed::Hash' => sub {
                      my @keys = keys %indexed;
                    },
                  'Tie::IxHash' => sub {
                      my @keys = keys %ixhash;
                    },
                  'PerlHash' => sub {
                      my @values = keys %perlhash;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Keys : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my @keys = keys %indexed;
                    },
                  'Tie::IxHash' => sub {
                      my @keys = keys %ixhash;
                    },
                  'PerlHash' => sub {
                      my @values = keys %perlhash;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Values : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 10_000, {
                  'Tie::Indexed::Hash' => sub {
                      my @values = values %indexed;
                    },
                  'Tie::IxHash' => sub {
                      my @values = values %ixhash;
                    },
                  'PerlHash' => sub {
                      my @values = values %perlhash;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Values : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 1_000_000, {
                  'Tie::Indexed::Hash' => sub {
                      my @values = values %indexed;
                    },
                  'Tie::IxHash' => sub {
                      my @values = values %ixhash;
                    },
                  'PerlHash' => sub {
                      my @values = values %perlhash;
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = large_dataset();
  %ixhash = large_dataset();
  my %perlhash = large_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Each : Large]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 500, {
                  'Tie::Indexed::Hash' => sub {
                      my @e;
                      while(@e = each %indexed) {
                        $indexed{$e[0]} = $e[1] + 2;
                      }
                    },
                  'Tie::IxHash' => sub {
                      my @e;
                      while(@e = each %ixhash) {
                        $ixhash{$e[0]} = $e[1] + 2;
                      }
                    },
                  'PerlHash' => sub {
                      my @e;
                      while(@e = each %perlhash) {
                        $perlhash{$e[0]} = $e[1] + 2;
                      }
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}


{
  my %indexed;  tie %indexed, 'Tie::Indexed::Hash';
  my %ixhash;  tie %ixhash, 'Tie::IxHash';
  %indexed = small_dataset();
  %ixhash = small_dataset();
  my %perlhash = small_dataset();
  print ' ' . ('=' x 78) . "\n";
  print "   [Each : Small]\n";
  print ' ' . ('-' x 78) . "\n";
  my $results = timethese( 50_000, {
                  'Tie::Indexed::Hash' => sub {
                      my @e;
                      while(@e = each %indexed) {
                        $indexed{$e[0]} = $e[1] + 2;
                      }
                    },
                  'Tie::IxHash' => sub {
                      my @e;
                      while(@e = each %ixhash) {
                        $ixhash{$e[0]} = $e[1] + 2;
                      }
                    },
                  'PerlHash' => sub {
                      my @e;
                      while(@e = each %perlhash) {
                        $perlhash{$e[0]} = $e[1] + 2;
                      }
                    },
                });
  print ' ' . ('-' x 78) . "\n";
  cmpthese($results);
  print ' ' . ('=' x 78) . "\n";
  print "\n";
}

