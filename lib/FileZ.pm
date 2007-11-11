package FileZ;

use strict;
use warnings;
use FindBin;
use Catalyst::Runtime '5.70';

use Catalyst qw/
    ConfigLoader
    -Debug
    Session
    Session::State::Cookie
    Session::Store::File
    Static::Simple
    Authentication
    Authorization::Roles
    Prototype
/;

my @extra_plugins;
    
if ( $ENV{CATALYST_ENGINE} eq 'Wx' ) {
    push @extra_plugins => qw/ 
        Session::State::Wx
    /;
}

__PACKAGE__->setup( @extra_plugins );

our $VERSION = '0.01_01';

1;

=head1 NAME

FileZ - A Catalyst application to share files on a website from your desktop

=head1 DESCRIPTION

Caution, this is _very_ early stage, it does almost nothing now and it's just
a demo for a perl workshop.

Actually files are stored in a database, the DB schema is in db.sql.

Play with it, comment it and have ideas eventually to improve it.

Thank you

Eriam

=head1 AUTHORS

Eriam Schaffter, C<eriam@cpan.org>.

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it 
under the same terms as Perl itself.

=cut
