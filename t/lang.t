use v6;

use Test; 
use lib 'lib';

plan 6;


use-ok 'TegTools';
use TegTools;
use TegTools::Teg;
use TegTools::Directive;



my %parms;
my $out;

my TegTools::Teg $sentence .= new: (
  -> {
    given %parms<lang> {
      when 'en' { ('how are', PN, 'and', PNGEN, 'organization', 'doing?', BR); }
      when 'nl' { ('hoe gaat het met', PNDAT, 'en', PNGEN, 'organisatie?', BR); }
    }
  }
);

%parms = (:formal, :lang<en>);
$out = process($sentence, %parms);
is $out, "how are you and your organization doing?\n", 'elab pronoun english formal';
%parms = (:lang<en>);
$out = process($sentence, %parms);
is $out, "how are you and your organization doing?\n", 'elab pronoun english informal';
%parms = (:formal, :lang<nl>);
$out = process($sentence, %parms);
is $out, "hoe gaat het met u en uw organisatie?\n", 'elab pronoun dutch formal';
%parms = (:lang<nl>);
$out = process($sentence, %parms);
is $out, "hoe gaat het met jou en jouw organisatie?\n", 'elab pronoun dutch informal sg';
%parms = (:lang<nl>, :number<pl>);
$out = process($sentence, %parms);
is $out, "hoe gaat het met jullie en jullie organisatie?\n", 'elab pronoun dutch informal pl';

done-testing;