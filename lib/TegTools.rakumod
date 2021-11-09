unit module TegTools:ver<0.0.1>:auth<Theo van den Heuvel>;

use TegTools::Teg;
use TegTools::Directive;

sub preprocessFrags(@frags, %parms) {
  # note @frags.raku;
  my Frag @out = ();
  if %parms<lang> eq 'nl' {
    if %parms<formal> {
      for @frags {
        when PN|PNDAT|PNACC { @out.push: "u" }
        when PNGEN { @out.push: "uw" }
        default { @out.push: $_ }
      }
    } elsif %parms<number>.defined and %parms<number> eq 'pl' {
      for @frags {
        when PN|PNDAT|PNACC|PNGEN { @out.push: "jullie" }
        default { @out.push: $_ }
      }
    } else {
      for @frags {
        when PN { @out.push: "jij" }
        when PNDAT|PNACC { @out.push: "jou" }
        when PNGEN { @out.push: "jouw" }
        default { @out.push: $_ }
      }
    }
  } else { # lang = en
    for @frags {
      when PN|PNDAT|PNACC { @out.push: "you" }
      when PNGEN { @out.push: "your" }
      default { @out.push: $_ }
    }

  }

  return @out;
}

sub processFrags(@infrags) {
  
  my Str @out = ();
  my @frags = @infrags;
  @frags.push: EMPTY; # so that the last element is considered
  @frags.unshift: EMPTY; # so that the last element is considered
  my $prev = @frags[0];
  for 1..^ @frags.elems -> $i {
    my $frag = @frags[$i];
    if $prev ~~ Str {
      if $frag ~~ Str|CAP|PN|PNACC|PNGEN|PNDAT  {
        $prev ~= ' ';
      }
      @out.push: $prev;
    } else {
      given $prev {
        when EMPTY { #no-op 
        }
        when XW {
        }
        when BR {
          @out.push: "\n";
        }
        when LONGBR {
          @out.push: "\n\n";
        }
        when OEOU {
          if $frag ~~ OSOU {
            @out.push: ". ";
          } elsif $frag ~~ EMPTY|BR|LONGBR {
            @out.push: ".";
          # } else {
          #   note "OEOU ignored if followed by ", $frag.raku;
          }
        }        
        when EOU {
          if $frag ~~ Str {
            @out.push: ". ";
          } else {
            @out.push: ".";
          }
        }
        when CAP {
          if $frag ~~ Str {
            $frag .= tc;
          }
        }
      }
    }
    $prev = $frag;
  }
  return @out;
}
sub process(TegTools::Teg $teg, %parms) is export {
  # my @interm = $teg.write(%parms);
  my Frag @interm = $teg.write();
  # note 'written ', @interm.raku;
  @interm = preprocessFrags(@interm, %parms);
  # note 'preprocessed ', @interm.raku;
  return processFrags(@interm).join;
}