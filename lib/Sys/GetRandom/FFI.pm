package Sys::GetRandom::FFI;

# ABSTRACT: get random bytes from the system

use v5.20;
use warnings;

use Exporter qw( import );
use FFI::Platypus 2.00;

use experimental qw( signatures );

use constant GRND_NONBLOCK => 0x0001;
use constant GRND_RANDOM   => 0x0002;

our @EXPORT_OK = qw( GRND_RANDOM GRND_NONBLOCK getrandom );

our $VERSION = 'v0.1.1';

=head1 SYNOPSIS

  use Sys::GetRandom::FFI qw( getrandom GRND_RANDOM GRND_NONBLOCK );

  my $bytes = getrandom( $size, GRND_RANDOM | GRND_NONBLOCK );
  if ( defined($bytes) ) {
     ...
  }

=head1 DESCRIPTION

This is a proof-of-concept module for calling the L<getrandom(2)> system function via L<FFI::Platypus>.

=export GRND_RANDOM

When this bit is set, it will read from F</dev/random> instead of F</dev/urandom>.

=export GRND_NONBLOCK

This will exit with C<undef> when there are no random bytes available.

=export getrandom

  my $bytes = getrandom( $size, $options );

This will return a scalar of up to C<$size> bytes, or C<undef> if there was an error.

It may return less than C<$size> bytes if L</GRND_RANDOM> was given as an option and there was less entropy or or if the
entropy pool has not been initialised, or if it was interrupted by a signal when C<$size> is over 256.

The C<$options> are optional.

=cut

sub getrandom( $size, $opts = 0 ) {

    state $ffi = FFI::Platypus->new(
        api => 2,
        lib => undef,    # libc
    );

    state $random = $ffi->function( getrandom => [ 'string', 'size_t', 'int' ] => 'size_t' );

    my $buffer = "\0" x $size;
    my $res    = $random->call( $buffer, $size, $opts );

    return $res != -1 ? $buffer : undef;
}

1;

=head1 SEE ALSO

=over 4

=item L<getrandom(2)>

=item L<Sys::GetRandom>

This is an XS module that calls L<getrandom(2)> directly.  It has a slightly different interface but is faster.

=item L<Rand::URandom>

This is a pure-Perl module that makes syscalls to L<getrandom(2)>, but falls back to reading from F</dev/urandom>.

=item L<Crypt::URandom>

This is a pure-Perl module that reads data from F</dev/urandom>. It also uses L<Win32::API> to read random bytes on
Windows.

=back

=head1 SUPPORT FOR OLDER PERL VERSIONS

This module requires Perl v5.20 or later.

Future releases may only support Perl versions released in the last ten (10) years.

=head1 append:BUGS

=head2 Reporting Security Vulnerabilities

Security issues should not be reported on the bugtracker website. Please see F<SECURITY.md> for instructions how to
report security vulnerabilities

=cut
