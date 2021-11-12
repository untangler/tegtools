unit module TegTools::Directive:ver<0.0.1>:auth<Theo van den Heuvel>;

enum Directive is export <EMPTY XW BR LONGBR OSOU OEOU SOU EOU CAP 
  PN PNGEN PNDAT PNACC V VC2 VZ VV VVZ>;

subset Frag is export of Any where * ~~ Str|Directive;