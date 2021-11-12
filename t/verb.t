use v6;

use Test; 
use lib 'lib';

plan 4;

use-ok 'TegTools';
use TegTools;
use TegTools::Teg;
use TegTools::Directive;

my %parms;
my $out;

my TegTools::Teg $sentence .= new: ('hoe ga', V, PN, XW, '? Wat zie', V, PN, XW, '? Wat zeg', VC2, PN, XW, '? Waarvan leef', VVZ, PN, XW, '?', BR);
%parms = (:lang<nl>);
$out = process($sentence, %parms);
is $out, "hoe ga jij? Wat zie jij? Wat zeg jij? Waarvan leef jij?\n", 'informal';
%parms = (:formal, :lang<nl>);
$out = process($sentence, %parms);
is $out, "hoe gaat u? Wat ziet u? Wat zegt u? Waarvan leeft u?\n", 'formal';
%parms = (:lang<nl>, :number<pl>);
$out = process($sentence, %parms);
is $out, "hoe gaan jullie? Wat zien jullie? Wat zeggen jullie? Waarvan leven jullie?\n", 'informal  pl';

done-testing;