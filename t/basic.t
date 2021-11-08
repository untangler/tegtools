use v6;

use Test; 
use lib 'lib';

plan 4;

use-ok 'TegTools';
use TegTools;
use TegTools::Teg;
use TegTools::Directive;

my %parms;

my TegTools::Teg ($message, $head, $tail, $recipient, $stuff);
$stuff .= new: q => ("piano");
$recipient .= new: q => ("Harry");
$head .= new: q => ('hi', $recipient, XW, ',', LONGBR, 'the', $stuff, 'has arrived', OEOU);
$tail .= new: q => (XW, ', and we hope you like it', EOU);
# $message .= new: q => ($head, $tail);
$message .= new: q => ($head, -> { %parms<long> ?? $tail !! (EMPTY,) }, BR );

# note $message.raku;
isa-ok $message, 'TegTools::Teg', ' is a  Teg';

my $shortResult = "hi Harry,\n\nthe piano has arrived.\n";
my $longResult = "hi Harry,\n\nthe piano has arrived, and we hope you like it.\n";

%parms = ();
is process($message, %parms), $shortResult, 'short result';

%parms = (:long);
is process($message, %parms), $longResult, 'long result';

# is capturing(->$fh { $db.publish($fh, True, (<aap>,)) }),
#   "#*  \n\n3\t4\t5\t6\tnoot\n#*^ 3 4\t6\t7\n",
#   'publishing';

done-testing;