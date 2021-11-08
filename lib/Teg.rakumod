class Teg {
  # has %.p = (); # parms
  has @.q;
  method write() {
    my @result;
    for @!q -> $t {
      given $t {
        when Teg {
          @result.push: $t.write();
        }
        when Str {
          @result.push: $t;
        }
        when List {
          for @$t -> $e { @result.push: $e.write() }
        }
        when Callable {
          my $zzz = $t.().write;
          if $zzz {
            note " >>> callable: ", $zzz.raku;
            @result.push: $zzz;
          }
        }
        default {
          die "I do not know how to handle teg part of type {$t.raku}";
        }
      }
    }
    return |@result;
  }
}
