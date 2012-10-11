use strict;
use warnings;

package Munge::Perl::PkgVersionBlock;

# ABSTRACT: Basic file transformations on Perl Modules using PACKAGE VERSION BLOCK syntax.

use Moo;

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

=cut

use PPI;

has _ppi_document => ( is => rwp =>, required => 1 );

sub parse {
	my ( $self, $content ) = @_;
	my $doc;
	if ( ref $content ) {
		$doc = PPI::Document->new( $content );
	}
	else {
		$doc = PPI::Document->new( \$content );
	}
	if ( not defined $doc ) {
		die PPI::Document->errstr;
	}
	return $self->new( _ppi_document => $doc );

}

sub packages {
	my ( $self, ) = @_;
	return map {
		require Munge::Perl::PkgVersionBlock::Package;
		Munge::Perl::PkgVersionBlock::Package->new( _ppi_package => $_ )
	} @{ $self->_ppi_document->find( 'PPI::Statement::Package' ) };
}

no Moo;

1;
