unit module TegTools:ver<0.0.1>:auth<Theo van den Heuvel>;

use TegTools::Teg;
use TegTools::Directive;

sub preprocessFrags(@frags) {
  # note @frags.raku;
  my Frag @out = ();
  for @frags {
    when PN|PNDAT|PNACC { @out.push: "you" }
    when PNGEN { @out.push: "your" }
    default { @out.push: $_ }
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
      if $frag ~~ Str {
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
            @frags[$i] .= tc;
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
  @interm = preprocessFrags(@interm);
  # note 'preprocessed ', @interm.raku;
  return processFrags(@interm).join;
}