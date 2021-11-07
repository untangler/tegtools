use v6;

use Test; 
use lib 'lib';

use CaptureOut;

plan 3;


use-ok 'Teg';
use Teg;

my Teg $message .= new: parm => (:long), q => ($head, $tail);
my Teg $head .= new: q => ('hi', $reecipient, $comma, $longbr, 'the {$stuff} has arrived', $eou);
my Teg $tail .= new: q => ('and we hope hope you like it', $eou);
my Teg $recipient .= new: q=> "Harry";

isa-ok $message, 'Teg', ' is a  Teg';

my $shortResult = "hi Harry,\n\nthe piano has arrived.\n";
my $longResult = "hi Harry,\n\nthe piano has arrived, and we hope you like it.\n";

is $message.write(), $shortResult, 'short result';
is $message.write(:long), $longResult, 'long result';

# is capturing(->$fh { $db.publish($fh, True, (<aap>,)) }),
#   "#*  \n\n3\t4\t5\t6\tnoot\n#*^ 3 4\t6\t7\n",
#   'publishing';

done-testing;