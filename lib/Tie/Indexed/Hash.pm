package Tie::Indexed::Hash;

use warnings;
use strict;
use integer;
require Tie::Hash;

our @ISA = qw(Tie::Hash);
our $VERSION = '0.01';

sub TIEHASH {
    my $class = shift;
    my $self = [];
    $self->[0] = {}; # hash
    $self->[1] = []; # array of keys
    $self->[2] = 0; # count
}

sub FETCH { $_[0][0]{$_[1]}; }

sub STORE {
    my ($self, $key, $value) = (shift, shift, shift);
    push(@{$self->[1]}, $key) if(not exists $self->[0]{$key});
    $self->[0]{$key} = $value;
}

sub DELETE {
    my ($self, $key) = (shift, shift);
    if(exists $self->[0]{$key}) {
        my $old_value = delete $self->[0]{$key};
        my $i = 0;
        while($i < $#{$self->[1]}) {
            last if($self->[1]->[$i] eq $key);
            $i++;
        }
        splice(@{$self->[1]}, $i, 1);
        return $old_value;
    }
    return;
}

sub EXISTS { exists $_[0][0]{$_[1]}; }

sub FIRSTKEY {
  $_[0][2] = 0;
  $_[0]->[1][$_[0]->[2]++];
}

sub NEXTKEY { $_[0]->[1][$_[0]->[2]++]; }

1;
__END__

=pod

=head1 NAME

Tie::Indexed::Hash - The great new Tie::Indexed::Hash!


=head1 VERSION

Version 0.01


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Tie::Indexed::Hash;

    my $foo = Tie::Indexed::Hash->new();
    ...


=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.


=head1 SUBROUTINES/METHODS

=head2 function1

=head2 function2


=head1 AUTHOR

Calvin Schwenzfeier, C<< <calvin.schwenzfeier at gmail.com> >>


=head1 BUGS

Please report any bugs or feature requests to C<bug-tie-indexed-hash at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tie-Indexed-Hash>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tie::Indexed::Hash

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tie-Indexed-Hash>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tie-Indexed-Hash>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tie-Indexed-Hash>

=item * Search CPAN

L<http://search.cpan.org/dist/Tie-Indexed-Hash/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Calvin Schwenzfeier.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Tie::Indexed::Hash
