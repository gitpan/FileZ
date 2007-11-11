package FileZWx::Hello;

use strict;
use warnings;

use Wx ':everything';

sub new {
   my ($class, $catalyst, $c ) = @_;

   Wx::MessageBox($c->stash->{message}, 'Hello' );
}

1;

