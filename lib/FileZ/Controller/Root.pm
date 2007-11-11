package FileZ::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';
use Schema;
use Digest::MD5 qw( md5_hex md5_base64 );
use File::Slurp;
use File::Basename;

__PACKAGE__->config->{namespace} = '';

sub begin : Private {
    my ( $self, $c ) = @_;
        
    # We can login from anywhere ..
    if ($c->request) {

        # Login or register check
        if ($c->request->param('username') && $c->request->param('password')) {
            $c->log->info('Login ! ');            
            $c->stash->{username} = $c->request->param('username');
            $c->stash->{password} = $c->request->param('password');
            
            if ($c->authenticate({  
                email       => $c->request->param('username'),
                password    => $c->request->param('password')
            })) {
                $c->log->info('Authenticated '.$c->request->param('username'));
            }
            else {
                $c->log->info('Ooops ? Wrong password or email, could you check that please ! ');
                $c->stash->{ERROR} = "Ooops ? Wrong password or email, could you check that please !";
                $c->detach('/login');
            }
        }
        elsif ($c->request->param('username') && $c->request->param('action') eq 'register') {
            $c->log->info('Register ! ');
            $c->stash->{username} = $c->request->param('username');
            $c->detach('/user/account/register');
        }
    }
    
    unless ($c->user) {
	    $c->forward('/login');
    }
}

sub create_folder : Local {
    my ( $self, $c ) = @_;

    my $folder_name         = $c->request->param('folder_name') || 'New folder';
    my $parent_folder_id    = $c->request->param('parent_folder_id') || 0;

    $c->model('Schema::Folders')->create({
        user_id             => $c->user->user_id,
        folder_name         => $folder_name,
        parent_folder_id    => $parent_folder_id,
    });
}

sub read_folder : Local {
    my ( $self, $c ) = @_;

    $c->stash->{files} = [$c->model('Schema::Files')->search({
        user_id     => $c->user->user_id,
        folder_id   => $c->request->param('folder_id')
    })];

    $c->stash->{class} = 'Files';
    $c->stash->{template} = 'files.plain.html';
}

sub add_file : Local {
    my ( $self, $c ) = @_;
    
    my $file_name   = $c->request->param('file_name');
    my $folder_id   = $c->request->param('folder_id');    
    my $content     = read_file($file_name);

    $c->log->info('file_name = '.$file_name);
    $c->log->info('user_id = '.$c->user->user_id);
    $c->log->info('length($content) = '.length($content));
    $c->log->info('folder_id = '.$folder_id);
 
    $c->model('Schema::Files')->create({
        user_id         => $c->user->user_id,
        file_name       => basename($file_name),
        folder_id       => $folder_id,
        file_content    => $content
    });
}

sub login : Local {
    my ( $self, $c ) = @_;
    
    $c->stash->{class}      = 'Login';
    
    $c->detach();
}

sub default : Local {
    my ( $self, $c ) = @_;

    $c->log->info('OK OK ');

    $c->stash->{folders} = [$c->model('Schema::Folders')->search({
        user_id     => $c->user->user_id,
    })];

    $c->stash->{files} = [$c->model('Schema::Files')->search({
        user_id     => $c->user->user_id,
        folder_id   => 0
    })];

    $c->stash->{class} = 'Default';
}

sub end : Private {
    my ( $self, $c ) = @_;
    
    if ($ENV{CATALYST_ENGINE} eq 'Wx') {
        if ($c->stash->{class}) {
    	    $c->forward('FileZ::View::Wx');
        }
    }
    else {
        $c->stash->{template} = lc($c->stash->{class}).'.html'
            if !defined $c->stash->{template};

        if ($c->stash->{template}) {
            $c->forward( 'FileZ::View::TT' );
        }
    }
    
}


1;

=head1 NAME

FileZ::Controller::Root - The main controller for the application

=head1 DESCRIPTION

The cool thing about this is that the code is used both on the
desktop and on the website.

=head1 AUTHORS

Eriam Schaffter, C<eriam@cpan.org>.

=head1 COPYRIGHT

This program is free software, you can redistribute it and/or modify it 
under the same terms as Perl itself.

=cut
