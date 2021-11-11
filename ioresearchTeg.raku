use v6;

# application of TegTools

use lib './lib';

use UntangleTeg;

my %form = (
  company => 'I&O Research',
  :called,
  :visit,
  # formal => False,
  :formal,
  :lang<nl>
);
produce(%form);
