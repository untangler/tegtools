use TegTools::Directive;

class TegTools::Teg {
  # has %.p = (); # parms
  has @.q;

  # constructor for brevity
  method new(*@t) {
    self.bless(q => @t);
  }
  method write(-->Array[Frag]) {
    
    sub recur(@f --> Array[Frag]) {
      my Frag @result;
      for @f -> $t {
        given $t {
          when TegTools::Teg {
            @result.append: |$t.write;
          }
          when Frag {
            @result.push: $t;
          }
          when List {
            @result.append: recur(@$t);
          }
          when Callable {
            my $calc = $t.();
            if $calc ~~ TegTools::Teg { 
              @result.append: $calc.write; 
            } else { 
              @result.append: recur([$calc]);
            }
          }
          default {
            die "I do not know how to handle teg part of type {$t.raku}";
          }
        }
      }
      return @result;
    }
    my Frag @res = recur(@!q);
    # note "return from recur with ", @res.raku;
    return @res;
  }
}
