use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    ( MM->can( 'signature_target' ) ? ( SIGN => 1 ) : () ),
    NAME          => 'FileZ',
    AUTHOR        => 'Eriam Schaffter <eriam@cpan.org>',
    VERSION_FROM  => 'lib/FileZ.pm',
    ABSTRACT_FROM => 'lib/FileZ.pm',
    LICENSE       => 'perl',
    PL_FILES      => {},
    PREREQ_PM     => {
        'Test::More'            => 0,
        'version'               => 0,
        'Catalyst'              => 0,
        'Catalyst::Engine::Wx'  => '0.38',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);

