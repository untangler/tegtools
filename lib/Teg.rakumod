class Teg {
  # has %.p = (); # parms
  has @.q;
  method write(%parms) {
    my @result;
    for @!q -> $t {
      given $t {
        when Teg {
          @result.push: $t.write(%parms);
        }
        when Str {
          @result.push: $t
        }
        default {
          die "I do not know how to handle teg part fo type $t"
        }
      }
    }
  }
}

constant Teg $comma is export .= new: q => (',');
constant Teg $longbr is export .= new: q => (" \t\t");
constant Teg $eou is export .= new: q => ('<eou>');
