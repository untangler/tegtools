use v6;

# application of TegTools

use lib './lib';

use UntangleTeg;

my %form = (
  company => 'Onderzoeksbureau EVA',
  location => 'Rotterdam',
  :visit,
  # formal => False,
  :formal,
  :lang<nl>
);
produce(%form);
