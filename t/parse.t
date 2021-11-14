use v6;

use Test;
use lib <lib>;

plan 7;

use-ok 'TegGrammar';
use TegGrammar;

my @tests = <alts comments dir greet str terms>;

my $in;

for @tests -> $t {
  note "\n\n$t:";
  my $in = slurp "gram/{$t}.teg";

  my $match = TegGrammar.parse($in);

  ok ?$match, "$t matches";
}