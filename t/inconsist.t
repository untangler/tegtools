use v6;

use Test; 
use lib 'lib';

plan 1;
use UntangleTeg;

my %parms = (:called, :intro<how are the kids?>, :lang<en>);
dies-ok { produce(%parms) }, 'dies';


done-testing;