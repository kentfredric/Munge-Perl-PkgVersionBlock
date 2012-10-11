use strict;
use warnings;

package Munge::Perl::PkgVersionBlock::Package;

# ABSTRACT: Single Package Augmenter

use Moo;

has _ppi_package => ( is => rwp =>, required => 1 );

sub _parts {
	my ( $self, ) = @_;

	my ( @children ) = $self->_ppi_package->children;

	my ( %patterns ) = (
		package_name_block => [
			{ isa => 'PPI::Token::Word', content => 'package' },
			{ isa => 'PPI::Token::Whitespace' },
			{ isa => 'PPI::Token::Word' },
			{ isa => 'PPI::Token::Whitespace' },
			{ isa => 'PPI::Structure::Block' },
		],
		package_name_numberfloat_block => [
			{ isa => 'PPI::Token::Word', content => 'package' },
			{ isa => 'PPI::Token::Whitespace' },
			{ isa => 'PPI::Token::Word' },
			{ isa => 'PPI::Token::Whitespace' },
			{ isa => 'PPI::Token::Number::Float' },
			{ isa => 'PPI::Token::Whitespace' },
			{ isa => 'PPI::Structure::Block' },
		],
		package_name_numberversion_block => [
			{ isa => 'PPI::Token::Word', content => 'package' },
			{ isa => 'PPI::Token::Whitespace' },
			{ isa => 'PPI::Token::Word' },
			{ isa => 'PPI::Token::Whitespace' },
			{ isa => 'PPI::Token::Number::Version' },
			{ isa => 'PPI::Token::Whitespace' },
			{ isa => 'PPI::Structure::Block' },
		],
	);

	for my $pattern_name ( keys %patterns ) {
		my ( @pattern ) = @{ $patterns{$pattern_name} };
		for my $i ( 0 .. $#pattern ) {
			my $want = $pattern[ $i ];
			my $got  = $children[ $i ];
			if ( defined $want->{isa} ) {

			}
		}
	}
}

sub is_block {
	my ( $self, ) = @_;
	my $block = $self->_ppi_package->find( 'PPI::Structure::Block' );
	return if not $block;
	return @{$block};
}

no Moo;

1;
