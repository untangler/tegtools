use v6;

use Test; 
use lib 'lib';

plan 2;


use-ok 'TegTools';
use TegTools;
use TegTools::Teg;
use TegTools::Directive;



my %parms;

my TegTools::Teg $sentence .= new: q => ('how are', PN, 'and', PNGEN, 'organization', 'doing?', BR);

%parms = (:formal, :lang<en>);
my $out = process($sentence, %parms);
is $out, "how are you and your organization doing?\n", 'elab pronoun';

done-testing;