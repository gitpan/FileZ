package Schema::Users;

# Created by DBIx::Class::Schema::Loader v0.03006 @ 2007-11-10 15:38:01

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("PK::Auto", "Core");
__PACKAGE__->table("users");
__PACKAGE__->add_columns(
  "user_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "email",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 45 },
  "password",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 45 },
);
__PACKAGE__->set_primary_key("user_id");

1;

