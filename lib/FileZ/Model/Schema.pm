package FileZ::Model::Schema;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'Schema',
);


1;
