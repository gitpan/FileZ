package FileZWx::Files;

use strict;
use warnings;

use Wx ':everything';

use base 'Wx::ListCtrl';

sub new {
    my ($class, $catalyst, $c ) = @_;

    my $self = $c->stash->{_parent}->{filez};
    return unless defined $self;
 
    $self->DeleteAllItems();
   
    my $i = 0;
    foreach (@{ $c->stash->{files} }) {
        my $idx_1 = $self->InsertStringItem($i, $_->file_name);
        $self->SetItem($idx_1, 1, 100);
        $self->SetItem($idx_1, 2, $_->user_id);
        $i++;
    }


}

1;

