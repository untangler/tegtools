use v6;

# application of TegTools

use lib './lib';

use UntangleTeg;

my %form = (
  company => 'Naturalis',
  name => 'heer Koureas',
  location => 'Leiden',
  :yourdata,
  # formal => False,
  :formal,
  :lang<nl>
);
produce(%form);
