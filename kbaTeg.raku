use v6;

# application of TegTools

use lib './lib';

use UntangleTeg;

my %form = (
  company => 'Kbadata',
  intro => 'Op uw website zien we dat u zich o.a. bezighoudt met dataverzameling en -verwerking.',
  :long,
  # formal => False,
  :lang<nl>
);
produce(%form);
