# generated by wxGlade 0.5 on Mon Aug 27 07:42:19 2007 from /home/eriam/Desktop/Projets/Ibiz/_src/Wxglade/Login.wxg
# To get wxPerl visit http://wxPerl.sourceforge.net/

use Wx 0.15 qw[:allclasses];
use strict;
package Glade::Login;

use Wx qw[:everything];
use base qw(Wx::Dialog);
use strict;

# begin wxGlade: ::dependencies
# end wxGlade

sub new {
	my( $self, $parent, $id, $title, $pos, $size, $style, $name ) = @_;
	$parent = undef              unless defined $parent;
	$id     = -1                 unless defined $id;
	$title  = ""                 unless defined $title;
	$pos    = wxDefaultPosition  unless defined $pos;
	$size   = wxDefaultSize      unless defined $size;
	$name   = ""                 unless defined $name;

# begin wxGlade: Interfaces::Login::new

	$style = wxDEFAULT_DIALOG_STYLE 
		unless defined $style;

	$self = $self->SUPER::new( $parent, $id, $title, $pos, $size, $style, $name );
	$self->{panel_1} = Wx::Panel->new($self, -1, wxDefaultPosition, wxDefaultSize, );
	$self->{label_1} = Wx::StaticText->new($self, -1, "Please logon !\n", wxDefaultPosition, wxDefaultSize, );
	$self->{label_2} = Wx::StaticText->new($self, -1, "Username", wxDefaultPosition, wxDefaultSize, );
	$self->{label_3} = Wx::StaticText->new($self, -1, "Password", wxDefaultPosition, wxDefaultSize, );
	$self->{username} = Wx::TextCtrl->new($self->{panel_1}, -1, "", wxDefaultPosition, wxDefaultSize, );
	$self->{password} = Wx::TextCtrl->new($self->{panel_1}, -1, "", wxDefaultPosition, wxDefaultSize, wxTE_PASSWORD);
	$self->{button_login} = Wx::Button->new($self->{panel_1}, -1, "Login");
	$self->{message} = Wx::StaticText->new($self, -1, "Wrong username and password !", wxDefaultPosition, wxDefaultSize, wxALIGN_CENTRE);

	$self->__set_properties();
	$self->__do_layout();

# end wxGlade
	return $self;

}


sub __set_properties {
	my $self = shift;

# begin wxGlade: Interfaces::Login::__set_properties

	$self->SetTitle("Login");
	$self->{label_1}->SetFont(Wx::Font->new(12, wxDEFAULT, wxNORMAL, wxNORMAL, 0, ""));
	$self->{label_2}->SetFont(Wx::Font->new(10, wxDEFAULT, wxNORMAL, wxNORMAL, 0, ""));
	$self->{label_3}->SetFont(Wx::Font->new(10, wxDEFAULT, wxNORMAL, wxNORMAL, 0, ""));
	$self->{panel_1}->SetBackgroundColour(Wx::Colour->new(212, 208, 200));
	$self->{message}->SetForegroundColour(Wx::Colour->new(255, 0, 0));
	$self->{message}->SetFont(Wx::Font->new(12, wxDEFAULT, wxNORMAL, wxBOLD, 0, ""));

# end wxGlade
}

sub __do_layout {
	my $self = shift;

# begin wxGlade: Interfaces::Login::__do_layout

	$self->{sizer_3} = Wx::BoxSizer->new(wxVERTICAL);
	$self->{sizer_4} = Wx::BoxSizer->new(wxHORIZONTAL);
	$self->{sizer_6} = Wx::BoxSizer->new(wxVERTICAL);
	$self->{sizer_5} = Wx::BoxSizer->new(wxVERTICAL);
	$self->{sizer_3}->Add($self->{label_1}, 0, wxALIGN_CENTER_HORIZONTAL, 0);
	$self->{sizer_4}->Add(20, 20, 0, 0, 0);
	$self->{sizer_5}->Add($self->{label_2}, 0, 0, 0);
	$self->{sizer_5}->Add($self->{label_3}, 0, 0, 0);
	$self->{sizer_5}->Add(20, 20, 0, 0, 0);
	$self->{sizer_4}->Add($self->{sizer_5}, 2, wxEXPAND, 0);
	$self->{sizer_6}->Add($self->{username}, 0, 0, 0);
	$self->{sizer_6}->Add($self->{password}, 0, 0, 0);
	$self->{sizer_6}->Add($self->{button_login}, 0, 0, 0);
	$self->{panel_1}->SetSizer($self->{sizer_6});
	$self->{sizer_4}->Add($self->{panel_1}, 1, wxEXPAND, 0);
	$self->{sizer_4}->Add(20, 20, 0, 0, 0);
	$self->{sizer_3}->Add($self->{sizer_4}, 1, wxEXPAND, 0);
	$self->{sizer_3}->Add($self->{message}, 0, wxALIGN_CENTER_HORIZONTAL|wxALIGN_CENTER_VERTICAL, 0);
	$self->SetSizer($self->{sizer_3});
	$self->{sizer_3}->Fit($self);
	$self->Layout();
	$self->Centre();

# end wxGlade
}

# end of class Interfaces::Login

1;
