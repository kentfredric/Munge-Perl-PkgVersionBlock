use strict;
use warnings;

package Munge::Perl::PkgVersionBlock::Package;
BEGIN {
  $Munge::Perl::PkgVersionBlock::Package::AUTHORITY = 'cpan:KENTNL';
}
{
  $Munge::Perl::PkgVersionBlock::Package::VERSION = '0.1.0';
}

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

__END__

=pod

=encoding utf-8

=head1 NAME

Munge::Perl::PkgVersionBlock::Package - Single Package Augmenter

=head1 VERSION

version 0.1.0

=head1 AUTHOR

Kent Fredric <kentnl@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Kent Fredric <kentnl@cpan.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
