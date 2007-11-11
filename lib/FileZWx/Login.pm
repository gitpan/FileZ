package FileZWx::Login;

use strict;
use warnings;

use Wx ':everything';
use Catalyst::Engine::Wx::Event qw(
    CAT_EVT
    CAT_EVT_QUIT
    CAT_EVT_CLOSE
    CAT_EVT_LIST_ITEM_SELECTED
    CAT_EVT_BUTTON
    CAT_EVT_CHAR
);
use Data::Dumper;
use base 'Glade::Login';

sub new {
    my ($class, $catalyst, $c ) = @_;
    my $self = $class->SUPER::new( undef, -1, 'Caisse', [0, 0], [300,800] );
   
    $self->Refresh();
    $self->Show(1);
    
    $self->{redirect} = $c->request->uri;

    if ($c->stash->{message}) {
        $self->{message}->Show(1);
    }
    else {
        $self->{message}->Show(0);
    }
    
    $self->Refresh();
    
    CAT_EVT_BUTTON($self, $self->{button_login}, \&login);
    CAT_EVT_CLOSE($self, sub { CAT_EVT_QUIT } ); 
    return 1;
}

sub login {
    my ($self, $event) = @_;

    my $username = $self->{username}->GetValue;
    my $password = $self->{password}->GetValue;

    if ($username ne '' && $password ne '') {
        CAT_EVT($self, $self->{redirect}, { 
            username    => $username, 
            password    => $password,
            action      => 'login'
        });
        $self->Destroy;
    }
}


1;
