package Schema::Acls;

# Created by DBIx::Class::Schema::Loader v0.03006 @ 2007-11-10 15:38:01

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("PK::Auto", "Core");
__PACKAGE__->table("acls");
__PACKAGE__->add_columns(
  "acl_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "folder_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 10 },
  "user_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 10 },
  "mode",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 45 },
);
__PACKAGE__->set_primary_key("acl_id");

1;

