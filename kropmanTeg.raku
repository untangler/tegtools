use v6;

# application of TegTools

use lib './lib';

use UntangleTeg;

my %form = (
  company => 'Kropman',
  name => 'mw Hermens',
  location => 'Nijmegen',
  :visit,
  # formal => False,
  :formal,
  :lang<nl>
);
produce(%form);
