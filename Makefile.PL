use inc::Module::Install;

name     'Tie-Indexed-Hash';
all_from 'lib/Tie/Indexed/Hash.pm';
author   q{Calvin Schwenzfeier <calvin.schwenzfeier@gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

