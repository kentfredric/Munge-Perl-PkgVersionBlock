
use strict;
use warnings;
use Test::More 0.90;

use Path::Class qw( file dir );
use FindBin;

my (@files) = map { dir( $FindBin::Bin )->parent->subdir('corpus')->file( 'Sample_' . $_  . '.pm' ) }
	qw( A B C D E F G H );

use Munge::Perl::PkgVersionBlock;

for my $file ( @files ) {

	my $document = Munge::Perl::PkgVersionBlock->parse( scalar $file->slurp() );

	note "Opened $file happily";
	subtest $file->basename => sub {

		for my $package ( $document->packages ){ 
			if ( $package->is_block ) {
				pass "Block";
			}
			else {
				pass "Non-Block";
			}
			
			note explain $package->_ppi_package->children;
		}
		
		
	}

}

done_testing;