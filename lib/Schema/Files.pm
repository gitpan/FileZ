package Schema::Files;

# Created by DBIx::Class::Schema::Loader v0.03006 @ 2007-11-10 15:38:01

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("PK::Auto", "Core");
__PACKAGE__->table("files");
__PACKAGE__->add_columns(
  "file_id",
  { data_type => "INT", default_value => undef, is_nullable => 0, size => 10 },
  "user_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 10 },
  "folder_id",
  { data_type => "INT", default_value => "", is_nullable => 0, size => 10 },
  "file_name",
  { data_type => "VARCHAR", default_value => "", is_nullable => 0, size => 255 },
  "file_content",
  {
    data_type => "LONGBLOB",
    default_value => "",
    is_nullable => 0,
    size => 4294967295,
  },
);
__PACKAGE__->set_primary_key("file_id");

1;

