use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Tie::Indexed::Hash',
    license             => 'perl',
    dist_author         => q{Calvin Schwenzfeier <calvin.schwenzfeier@gmail.com>},
    dist_version_from   => 'lib/Tie/Indexed/Hash.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Tie-Indexed-Hash-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
