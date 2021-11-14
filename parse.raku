use v6;

use lib <lib>;

use TegGrammar;

my @tests = <alts comments dir greet str terms>;

my $in;

for @tests -> $t {
  note "\n\n$t:";
  my $in = slurp "gram/{$t}.teg";

  my $match = TegGrammar.parse($in);

  note $match;
}
