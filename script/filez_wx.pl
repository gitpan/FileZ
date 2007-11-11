
BEGIN {
    $ENV{CATALYST_ENGINE} ||= 'Wx';
    require Catalyst::Engine::Wx;
}  

use FindBin;
use lib "$FindBin::Bin/../lib";

use strict;
use warnings;

use Wx qw[ :everything ]; 

require FileZ;
use Catalyst::Log::Wx;

FileZ->log(Catalyst::Log::Wx->new);

FileZ->config(
    setup_components => { except => qr/MyApp::Controller::Base/ }
);

FileZ->run({
   bootstrap   => 'Root->default',
});

1;
