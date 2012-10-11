
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "FindBin" => 0,
    "Module::Build" => "0.4002",
    "Path::Class" => 0,
    "Test::More" => "0.98"
  },
  "configure_requires" => {
    "Module::Build" => "0.4002"
  },
  "dist_abstract" => "Basic file transformations on Perl Modules using PACKAGE VERSION BLOCK syntax.",
  "dist_author" => [
    "Kent Fredric <kentnl\@cpan.org>"
  ],
  "dist_name" => "Munge-Perl-PkgVersionBlock",
  "dist_version" => "0.1.0",
  "license" => "perl",
  "module_name" => "Munge::Perl::PkgVersionBlock",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Moo" => 0,
    "PPI" => 0,
    "perl" => "v5.10.0",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
