package Tie::Indexed::Hash;

use integer;

our $VERSION = '0.02';

sub HASH_DATA();
sub HASH_DATA() { 0; }
sub KEY_ARRAY();
sub KEY_ARRAY() { 1; }
sub COUNT();
sub COUNT() { 2; }

sub SELF();
sub SELF() { 0; }
sub USER_KEY();
sub USER_KEY() { 1; }
sub USER_VALUE();
sub USER_VALUE() { 2; }

sub TIEHASH {
  my $class = shift;
  my $self = [];
  $self->[HASH_DATA] = {};
  $self->[KEY_ARRAY] = [];
  $self->[COUNT] = 0;
  bless $self, $class;
  $self;
}

sub FETCH {
  $_[SELF][HASH_DATA]{$_[USER_KEY]};
}

sub STORE {
  push(@{$_[SELF][KEY_ARRAY]}, $_[USER_KEY]) if(not exists $_[SELF][HASH_DATA]{$_[USER_KEY]});    
  $_[SELF][HASH_DATA]{$_[USER_KEY]} = $_[USER_VALUE];
}

sub DELETE {
  my $return = undef;
  if(exists $_[SELF][HASH_DATA]{$_[USER_KEY]}) {
    $return = delete $_[SELF][HASH_DATA]{$_[USER_KEY]};
    $_ = 0;
    while(($_ < $#{$_[SELF][KEY_ARRAY]}) && ($_[SELF][KEY_ARRAY][$_] ne $_[USER_KEY])) { $_++; }
    splice @{$_[SELF][KEY_ARRAY]}, $_, 1;
  }
  $return;
}

sub CLEAR {
  $_[SELF][HASH_DATA] = {};
  $_[SELF][KEY_ARRAY] = [];
  $_[SELF][COUNT] = 0;
}

sub EXISTS {
  exists $_[SELF][HASH_DATA]{$_[USER_KEY]};
}

sub FIRSTKEY {
  $_[SELF][COUNT] = 0;
  $_[SELF][KEY_ARRAY][$_[SELF][COUNT]++];
}

sub NEXTKEY {
  $_[SELF][KEY_ARRAY][$_[SELF][COUNT]++]
}

sub SCALAR {
  scalar %{$_[SELF][HASH_DATA]};
}

#sub DESTROY { 1; }

#sub UNTIE { 1; }

1;
__END__

=pod

=head1 NAME

Tie::Indexed::Hash - A tweaked version of the venerable Tie::IxHash.


=head1 VERSION

Version 0.02


=head1 SYNOPSIS

If you do not need the OO interface of C<Tie::IxHash>, then strongly consider
replacing C<Tie::IxHash> with this module because C<Tie::Indexed::Hash> runs
between 14% and 33% faster for "normal" operations (see the BENCHMARKS file for
the details, in particular the "Clear/Reassign" benchmarks).

    use Tie::Indexed::Hash;
    
    my %indexed;
    tie %indexed, 'Tie::Indexed::Hash';


=head1 SUBROUTINES/METHODS

These are the standard C<TIEHASH> methods required by Perl.  You may use them
directly if you really want to.


=head2 C<TIEHASH>

Initializes this tied hash.


=head2 C<FETCH>

Returns the value associated with the given key or C<undef> if the key does not
exist.


=head2 C<STORE>

Save the given key/value pair in this tied hash.


=head2 C<DELETE>

Removes a key from this tied hash and returns its value or undef if the key does
not exist.


=head2 C<CLEAR>

Sets this tied hash back to its initial starting conditions.


=head2 C<EXISTS>

Returns true if the given key exists, false otherwise.


=head2 C<FIRSTKEY>

Initialize the key counter and return the first key or undef if there are no
keys in this tied hash.


=head2 C<NEXTKEY>

Return all subsequent keys after the first key; returns undef at the end of the
key list.


=head2 C<SCALAR>

Returns a scalar representation of this tied hash.


=head2 C<DESTROY>

Unused; we have no need to do any cleanup immediately before this tied hash is
destroyed.


=head2 C<UNTIE>

Unused; we have no need to do any cleanup immediately before this tied hash is
unbound.


=head1 AUTHOR

Calvin Schwenzfeier, C<< <calvin DOT schwenzfeier a~t gmail dotCOM> >>


=head1 BUGS

Please report any bugs or feature requests through GitHub's issue tracker web
interface at L<http://github.com/cschwenz/Tie-Indexed-Hash/issues>.

=begin COMMENT

Please report any bugs or feature requests to C<bug-tie-indexed-hash at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tie-Indexed-Hash>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=end COMMENT


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tie::Indexed::Hash

You can also look for information at:

=over

=item * The C<Tie::Indexed::Hash> online docs (hosted on GitHub):

L<http://cschwenz.github.com/Tie-Indexed-Hash/Tie/Indexed/Hash.html>

=item * GitHub's issue tracker:

L<http://github.com/cschwenz/Tie-Indexed-Hash/issues>

=item * The C<Tie::Indexed::Hash> wiki (hosted on GitHub):

L<http://wiki.github.com/cschwenz/Tie-Indexed-Hash>

=item * Source code (hosted on GitHub):

L<http://github.com/cschwenz/Tie-Indexed-Hash>

=back

=begin COMMENT

=over

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tie-Indexed-Hash>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tie-Indexed-Hash>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tie-Indexed-Hash>

=item * Search CPAN

L<http://search.cpan.org/dist/Tie-Indexed-Hash/>

=back

=end COMMENT


=head1 ACKNOWLEDGEMENTS

I would like to thank Richard Balint for the original idea and concept code.


=head1 LICENSE AND COPYRIGHT

Copyright 2010 Calvin Schwenzfeier.

=begin COMMENT

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

=end COMMENT

This program is free software; you can redistribute it and/or modify it under
the terms of either:

=over

=item a)

the GNU General Public License [L<http://dev.perl.org/licenses/gpl1.html>] as published by the Free Software Foundation [L<http://www.fsf.org/>]; either version 1 [L<http://dev.perl.org/licenses/gpl1.html>], or (at your option) any later version [L<http://www.fsf.org/licensing/licenses/#GNUGPL>], or

=item b)

the "Artistic License" [L<http://dev.perl.org/licenses/artistic.html>].

=back

    
    For those of you that choose to use the GNU General Public License, my
    interpretation of the GNU General Public License is that no Perl script
    falls under the terms of the GPL unless you explicitly put said script under
    the terms of the GPL yourself.
    
    Furthermore, any object code linked with perl does not automatically fall
    under the terms of the GPL, provided such object code only adds definitions
    of subroutines and variables, and does not otherwise impair the resulting
    interpreter from executing any standard Perl script. I consider linking in C
    subroutines in this manner to be the moral equivalent of defining
    subroutines in the Perl language itself. You may sell such an object file as
    proprietary provided that you provide or offer to provide the Perl source,
    as specified by the GNU General Public License. (This is merely an alternate
    way of specifying input to the program.) You may also sell a binary produced
    by the dumping of a running Perl script that belongs to you, provided that
    you provide or offer to provide the Perl source as specified by the GPL.
    (The fact that a Perl interpreter and your code are in the same binary file
    is, in this case, a form of mere aggregation.)
    
    This is my interpretation of the GPL. If you still have concerns or
    difficulties understanding my intent, feel free to contact me. Of course,
    the Artistic License spells all this out for your protection, so you may
    prefer to use that.
    
    -- Larry Wall
    

See L<http://dev.perl.org/licenses/> for more information.

Voir L<http://dev.perl.org/licenses/> pour plus d'information.

Ver L<http://dev.perl.org/licenses/> para mÃ¡s informaciÃ³n.

Ð¡Ð¼. L<http://dev.perl.org/licenses/> Ð—Ð° Ð´Ð¾Ð¿Ð¾Ð»Ð½Ð¸Ñ‚ÐµÐ»ÑŒÐ½Ð¾Ð¹ Ð¸Ð½Ñ„Ð¾Ñ€Ð¼Ð°Ñ†Ð¸ÐµÐ¹.

Se L<http://dev.perl.org/licenses/> kwa taarifa zaidi.

FÃ©ach L<http://dev.perl.org/licenses/> le haghaidh tuilleadh eolais.

Se L<http://dev.perl.org/licenses/> fÃ¶r mer information.


=cut

