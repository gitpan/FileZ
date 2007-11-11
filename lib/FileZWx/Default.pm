package FileZWx::Default;

use strict;
use warnings;

use Wx ':everything';

use base 'Glade::Browser';
use File::Slurp;

use Catalyst::Engine::Wx::Event qw(
   CAT_EVT_BUTTON
   CAT_EVT_QUIT
   CAT_EVT
   CAT_EVT_CLOSE
   CAT_EVT_MENU
   CAT_EVT_TREE_SEL_CHANGED
   CAT_EVT_SIZE
);

sub new {
    # We receive from the view all the necessary things
    my ($class, $catalyst, $c ) = @_;
    
    # We create the parent window
    my $self = $class->SUPER::new( undef, -1, 'Default', [0, 0], [475,300] );
    

    # Declare the filez listctrl as a drop target
    $self->{filez}->SetDropTarget( 
        FileZWx::Default::FilesDropTarget->new( $self->{filez}, $self->{folders}, $c ) 
     );

    # Populate files
    $self->{filez}->InsertColumn( 0, "Filename" );
    $self->{filez}->InsertColumn( 1, "Size" );
    $self->{filez}->InsertColumn( 2, "Owner" );

    my $i = 0;
    foreach (@{ $c->stash->{files} }) {
        my $idx_1 = $self->{filez}->InsertStringItem($i, $_->file_name);
        $self->{filez}->SetItem($idx_1, 1, 100);
        $self->{filez}->SetItem($idx_1, 2, $_->user_id);
        $i++;
    }

    # Populate the folders
    my $root_id = $self->{folders}->AddRoot( $c->user->email, -1, -1, Wx::TreeItemData->new(0));
    $self->{id_maps}->{0} = $root_id;
    $self->build_folders($c);

    # Make a new folder
    CAT_EVT_MENU( $self, $self->{new_folder}, \&new_folder );

    CAT_EVT_TREE_SEL_CHANGED( $self, $self->{folders}, sub {  
        my( $self, $event ) = @_;
        if(my $data = $self->{folders}->GetItemData( $event->GetItem ) ) {
            CAT_EVT($self, 'Root->read_folder', { folder_id => $data->GetData } ) ;
        }
    });

    CAT_EVT_MENU( $self, wxID_ABOUT, \&on_about );
    CAT_EVT_MENU( $self, wxID_EXIT, sub { CAT_EVT_QUIT; } );
    
    CAT_EVT_CLOSE( $self, sub { CAT_EVT_QUIT; } );
    CAT_EVT_SIZE($self, \&update_size);

	$self->Layout();
	$self->Centre();
    $self->update_size();
    $self->Show(1);

    return 1;
}

sub build_folders {
    my($self, $c) = @_;
   
    foreach (@{ $c->stash->{folders} }) {
        my $parent_folder_id = $self->{id_maps}->{ $_->parent_folder_id };

        if (!defined $parent_folder_id) {
            $self->build_folders($c);
        }
        else {
            $self->{id_maps}->{$_->folder_id} = $self->{folders}->AppendItem(
                $parent_folder_id, $_->folder_name, -1, -1, Wx::TreeItemData->new( $_->folder_id )
            );
        }
    }
}

sub on_about {
    my( $self ) = @_;
    use Wx qw(wxOK wxCENTRE wxVERSION_STRING);

    Wx::MessageBox( "FileZ, (c) 2007 Eriam Schaffter\n" .
                    "wxPerl $Wx::VERSION, " . wxVERSION_STRING,
                    "About FileZ", wxOK|wxCENTRE, $self );
}

sub new_folder {
    my($self) = @_;

    my $dialog = Wx::TextEntryDialog->new($self, 'Please input folder name', 'New folder' );

    if (wxID_OK == $dialog->ShowModal) {
        my $folder_parent_id    = $self->{folders}->GetPlData( $self->{folders}->GetSelection ); 
        my $folder_name         = $dialog->GetValue;

        CAT_EVT($self, 'Root->create_folder', { 
            folder_name         => $folder_name,
            parent_folder_id    => $folder_parent_id,
        });
        
        my $newitem = $self->{folders}->AppendItem(
            $self->{folders}->GetSelection, $dialog->GetValue
        );

        $self->{folders}->SelectItem($newitem);
    }
}

sub update_size {
    my ($self, $event) = @_;
    
    my ($ctrl_width, $ctrl_height ) = $self->{filez}->GetSizeWH();

    $self->{filez}->SetColumnWidth(0, $ctrl_width / 3 - 5);
    $self->{filez}->SetColumnWidth(1, $ctrl_width / 3 + 13 );
    $self->{filez}->SetColumnWidth(2, $ctrl_width / 3 - 10);
    
    $self->Refresh;

    $event->Skip if defined $event;
}

package FileZWx::Default::FilesDropTarget;

use strict;
use base qw(Wx::FileDropTarget);
use File::Basename;

use Catalyst::Engine::Wx::Event qw(
   CAT_EVT
);

sub new {
    my $class = shift;
    my $files = shift;
    my $folders = shift;
    my $c = shift;
    my $self = $class->SUPER::new( @_ );

    $self->{filez} = $files;
    $self->{folders} = $folders;
    $self->{c} = $c;

    return $self;
}

sub OnDropFiles {
    my( $self, $x, $y, $files ) = @_;
    
    my $j = 0;
    foreach my $i ( @$files ) {
        if (-e $i) {
            my $folder_id    = $self->{folders}->GetPlData( $self->{folders}->GetSelection );     
             
            my $file_name = basename($i);

            my $idx_1 = $self->{filez}->InsertStringItem($self->{filez}->GetItemCount, $file_name);
            $self->{filez}->SetItem($idx_1, 1, 100 );
            $self->{filez}->SetItem($idx_1, 2, $self->{c}->user->email); 
    
            CAT_EVT($self, 'Root->add_file', {
                file_name   => $i,
                folder_id   => $folder_id 
            });
        }
    }
    
    return 1;
}
1;
