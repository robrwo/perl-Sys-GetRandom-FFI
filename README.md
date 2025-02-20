# NAME

Sys::GetRandom::FFI - get random bytes from the system

# VERSION

version v0.1.2

# SYNOPSIS

```perl
use Sys::GetRandom::FFI qw( getrandom GRND_RANDOM GRND_NONBLOCK );

my $bytes = getrandom( $size, GRND_RANDOM | GRND_NONBLOCK );
if ( defined($bytes) ) {
   ...
}
```

# DESCRIPTION

This is a proof-of-concept module for calling the [getrandom(2)](http://man.he.net/man2/getrandom) system function via [FFI::Platypus](https://metacpan.org/pod/FFI%3A%3APlatypus).

# EXPORTS

## getrandom

```perl
my $bytes = getrandom( $size, $options );
```

This will return a scalar of up to `$size` bytes, or `undef` if there was an error.

It may return less than `$size` bytes if ["GRND\_RANDOM"](#grnd_random) was given as an option and there was less entropy or or if the
entropy pool has not been initialised, or if it was interrupted by a signal when `$size` is over 256.

The `$options` are optional.

## GRND\_RANDOM

When this bit is set, it will read from `/dev/random` instead of `/dev/urandom`.

## GRND\_NONBLOCK

This will exit with `undef` when there are no random bytes available.

# SEE ALSO

- [getrandom(2)](http://man.he.net/man2/getrandom)
- [Sys::GetRandom](https://metacpan.org/pod/Sys%3A%3AGetRandom)

    This is an XS module that calls [getrandom(2)](http://man.he.net/man2/getrandom) directly.  It has a slightly different interface but is faster.

- [Sys::GetRandom::PP](https://metacpan.org/pod/Sys%3A%3AGetRandom%3A%3APP)

    This is a pure-Perl module that makes syscalls to [getrandom(2)](http://man.he.net/man2/getrandom).

- [Rand::URandom](https://metacpan.org/pod/Rand%3A%3AURandom)

    This is a pure-Perl module that makes syscalls to [getrandom(2)](http://man.he.net/man2/getrandom), but falls back to reading from `/dev/urandom`.

- [Crypt::URandom](https://metacpan.org/pod/Crypt%3A%3AURandom)

    This is a pure-Perl module that reads data from `/dev/urandom`. It also uses [Win32::API](https://metacpan.org/pod/Win32%3A%3AAPI) to read random bytes on
    Windows.

- [Crypt::SysRandom::XS](https://metacpan.org/pod/Crypt%3A%3ASysRandom%3A%3AXS)

    This is another interface that will call [getrandom(2)](http://man.he.net/man2/getrandom) or [getentropy(2)](http://man.he.net/man2/getentropy) or the Windows equivalent.

# SUPPORT FOR OLDER PERL VERSIONS

This module requires Perl v5.20 or later.

Future releases may only support Perl versions released in the last ten (10) years.

# SOURCE

The development version is on github at [https://github.com/robrwo/perl-Sys-GetRandom-FFI](https://github.com/robrwo/perl-Sys-GetRandom-FFI)
and may be cloned from [git://github.com/robrwo/perl-Sys-GetRandom-FFI.git](git://github.com/robrwo/perl-Sys-GetRandom-FFI.git)

# BUGS

Please report any bugs or feature requests on the bugtracker website
[https://github.com/robrwo/perl-Sys-GetRandom-FFI/issues](https://github.com/robrwo/perl-Sys-GetRandom-FFI/issues)

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

## Reporting Security Vulnerabilities

Security issues should not be reported on the bugtracker website. Please see `SECURITY.md` for instructions how to
report security vulnerabilities

# AUTHOR

Robert Rothenberg <rrwo@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2024-2025 by Robert Rothenberg <rrwo@cpan.org>.

This is free software, licensed under:

```
The Artistic License 2.0 (GPL Compatible)
```
