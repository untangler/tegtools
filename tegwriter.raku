use v6;


# letterEngine

=begin pod

=NAME tegwriter

=AUTHOR Theo van den Heuvel

based on letterEngine (also by me)


=end pod


# say $tmpl;
# my $stache = Template::Mustache.new: $tmplNL;

my $formatter = sub ($self) { sprintf "%04d%02d%02d", .year, .month, .day given $self; };
my $dt = Date.new(now, :$formatter);

my $company = prompt "company of recipient: ";
my $greet = prompt "hello recipient: ";
my $intro = prompt "intro: ";
my $question = prompt "what we are asking: ";
my $long = so prompt "want the long version?";
my $short = not $long;
my $formal = !$greet || so prompt "formal?";
# spurt "$company-$dt.txt", letter(
# publish letter(
  # language => 'NL',
  # :$greet,
  # :$intro,
  # :$question,
  # :$long,
  # :$short,
  # :$formal
# );

# say "company $company";
# say "greet $greet";
# say "intro $intro";
# say "question $question";
# say "long $long";
# say "short $short";
# say "formal $formal";

my $phrases = q:to/ENDPHRASES/;
complexe spreadsheetverzamelingen
We zouden graag willen weten of uw organisatie weleens tegen de grenzen van de bruikbaarheid van spreadsheets aanloopt en of onze organisatie daarbij van dienst Zou kunnen zijn.
Op uw website zien we dat u zich o.a. bezighoudt met dataverzameling en -verwerking.
ENDPHRASES

sub letter {
  my @letter = greet, intro, body, question, final, addr;
  return @letter;
}

sub greet {
  return ($greet || 'geachte lezer(es)'), ',';
}
sub intro {
  return $intro || ();
}

sub body {
  if $long {
    return qq:to/EOLONG/;
      Wij zetten op dit moment een consultancydienst op die organisaties helpt zich te bevrijden van diepe Excelvalkuilen.
      Daarbij moet {$formal ?? 'u' !! 'je'} denken aan organisaties die bijvoorbeeld Excel noodgedwongen 
      als database gebruiken (met alle risicos vandien) 
      of waarbij de verzamelingen bestanden groot en onoverzichtelijk worden. 
      {$formal ?? 'U' !! 'Je'} kunt ook denken aan organisaties die worstelen met pogingen om anderen toegang te geven tot de informatie uit de sheets 
      zonder ze te hoeven confronteren met woeste Excelstructuren. 

      We bieden een ander soort ondersteuning dan de meeste Excelexperts.
      Wij bieden een traject aan waarbij we het materiaal aan een geautomatiseerde analyze en scan onderwerpen.
      De resultaten kunnen we dan samen met {$formal ?? 'u' !! 'jullie'} bestuderen met een speciaal daarvoor ontwikkelde tool set.
      Zo kunnen we zwakheden vinden, waarvan de auteur mogelijk geen weet had.

      Onze eerste klant had miljoenen cellen met waardes en formules en moest de hele verzameling per administratief jaar kopiëren en bijwerken!
      We hebben daar veel pijn kunnen wegnemen.

      We hebben al stappen gezet om vanuit een spreadheet-verzameling een applicatie te kunnen genereren die ongeveer hetzelfde doet, maar met een database werkt.
      Hier worden dus rekenmodellen en grafieken uit Excel vertaald naar rekenmodellen en grafieken in een (web)applicatie.
      Het resultaat kun{$formal ?? 't u' !! ' je'} dan bijvoorbeeld aan {$formal ?? 'uw' !! 'je'} klanten ter beschikking stellen.
      Onze consultancy betreft dan bijvoorbeeld ook mogelijke rijkere visualisaties van informatie.
      EOLONG
  } else {
    return qq:to/EOSHORT/;
      Wij zijn op zoek naar mogelijke toepassingen van onze technologie om (grote) spreadsheetverzamelingen 
      doormiddel van een door onszelf ontwikkelde semantische scanner inzichtelijker te maken. 
      We zouden graag met iemand binnen {$formal ?? 'uw' !! 'je'} organisatie spreken die ervaring heeft met het analyzeren van spreadsheets van derden.
      EOSHORT
  }
}

sub question {
  $question || ();
}

sub final {
  if $formal {
    "met vriendelijk groet,"
  } else {
    "alvast bedankt,"
  }
}

sub addr {
  return q:to/EOADDR/;


    Theo van den Heuvel
    vdheuvel@heuvelhlt.nl
    0625492788
    EOADDR
}

sub publish {
  say @_.join("\n");
}