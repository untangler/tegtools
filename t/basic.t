use v6;

use Test; 
use lib 'lib';

plan 4;


use-ok 'Teg';
use Teg;


my Teg $comma .= new: q => ('<xw>', ',');
my Teg $longbr .= new: q => ('<xw>', '<br>', '<br>' );
my Teg $osou .= new: q => ('<osou/>');
my Teg $oeou .= new: q => ('<oeou/>');
my Teg $empty .= new: q => ();
# note $comma.raku;

sub glue(Str $l, $r) {
  if $r.startsWith('<') {
    given $r {
      when '<xw>' { # no-op
        return $r;
      }
      when '<br>' {
        return $r ~ "\n"; 
      }
      when '<'
    }
  }
}


# empty should produce an empty list
note $empty.write.raku;

my %parms;

my Teg ($message, $head, $tail, $recipient, $stuff);
$stuff .= new: q => ("piano");
$recipient .= new: q => ("Harry");
$head .= new: q => ('hi', $recipient, $comma, $longbr, 'the', $stuff, 'has arrived', $eou);
$tail .= new: q => ('and we hope hope you like it', $eou);
# $message .= new: q => ($head, $tail);
$message .= new: q => ($head, -> { %parms<long> ?? $tail !! $empty }, '<br>' );

# note $message.raku;
isa-ok $message, 'Teg', ' is a  Teg';

my $shortResult = "hi Harry,\n\nthe piano has arrived.\n";
my $longResult = "hi Harry,\n\nthe piano has arrived, and we hope you like it.\n";

%parms = ();
my @out = |$message.write();
note @out.raku;

is @out.join, $shortResult, 'short result';

%parms = (:long);
# note %parms.raku;
is $message.write().join(''), $longResult, 'long result';

# is capturing(->$fh { $db.publish($fh, True, (<aap>,)) }),
#   "#*  \n\n3\t4\t5\t6\tnoot\n#*^ 3 4\t6\t7\n",
#   'publishing';

done-testing;