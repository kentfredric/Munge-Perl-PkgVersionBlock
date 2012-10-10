use strict;
use warnings;

package Munge::Perl::PkgVersionBlock;
BEGIN {
  $Munge::Perl::PkgVersionBlock::AUTHORITY = 'cpan:KENTNL';
}
{
  $Munge::Perl::PkgVersionBlock::VERSION = '0.1.0';
}

# ABSTRACT: Basic file transformations on Perl Modules using PACKAGE VERSION BLOCK syntax.

use Moo;


no Moo;

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Munge::Perl::PkgVersionBlock - Basic file transformations on Perl Modules using PACKAGE VERSION BLOCK syntax.

=head1 VERSION

version 0.1.0

=head1 SYNOPSIS

	use Path::Class qw( file );
	
	my $document = Munge::Perl::PkgVersionBlock->parse( scalar file('path/to/foo.pm')->slurp );
	
	for my $package ( $document->packages ) {
	
		next unless $package->is_block;
		
		if ( $package->has_block_version ) {
			printf "Package %s has version %s \n" , $package->name,   $package->block_version ;
		}
		
		$package->set_block_version( v5.12 );
		
		printf "Package %s now has version %s \n" , $package->name,   $package->block_version ;

	}

	file('path/to/foo.pm')->splat( $document->serialize );

=head1 FIRST PASS

This is a first pass attempt at present. Basically scans for 

	qr{
		^
		\s*
		package
		\s+
		$package_declaration_regex
		\s+
		$version_declaration_regex
		\s+
		\{
	}msx

And provides in-place removal/injection/replacement of the version part in that declaration.

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
