unit module UntangleTeg:ver<0.0.1>:auth<Theo van den Heuvel>;

use TegTools;
use TegTools::Teg;
use TegTools::Directive;

sub produce(%parms) is export {
  # note %parms;
  # we need a date string for the file name
  my $formatter = sub ($self) { sprintf "%04d%02d%02d", .year, .month, .day given $self; };
  my $dt = Date.new(now, :$formatter);

  # declare elements of type Teg
  my TegTools::Teg ($letter, $greet, $intro, $body,
    $question, $final, $addr, $formdate);

  # check consistency of parms
  # called and intro are mutually exclusive
  die "called and intro are mutually exclusive" if %parms<called>:exists and %parms<intro>:exists;
  die "long and short are mutually exclusive" if %parms<long>:exists and %parms<short>:exists;
  die "visit and long are mutually exclusive" if %parms<visit>:exists and %parms<long>:exists;
  die "visit and short are mutually exclusive" if %parms<visit>:exists and %parms<short>:exists;

  # unused
  my $phrases = q:to/ENDPHRASES/;
  We hebben elkaar zojuist telefonisch gesproken, vandaar deze mail.
  complexe spreadsheetverzamelingen
  We zouden graag willen weten of uw organisatie weleens tegen de grenzen van de bruikbaarheid van spreadsheets aanloopt en of onze organisatie daarbij van dienst Zou kunnen zijn.
  Op uw website zien we dat u zich o.a. bezighoudt met dataverzameling en -verwerking.
  ENDPHRASES

  $greet .= new: ( %parms<greet> // 'geachte', -> { %parms<name> // 'lezer(es)' } , XW, ',', LONGBR);
  $intro .= new: ( %parms<intro> // -> { %parms<called> 
    ?? ('We hebben elkaar zojuist telefonisch gesproken, vandaar deze mail.', BR, BR)
    !! EMPTY });
  $question .= new: ( %parms<question> // EMPTY );
  $body .= new: (
    -> {
      if (%parms<yourdata>) {
        ('Wij bieden consultancy aan op het gebied van dataverzameling en -verwerking.',
        BR,
        %parms<company>, 'heeft veel data. We begrijpen dat', PN, 'daar een sleutelfiguur bent op dat gebied.', BR, BR,

        'Sta', -> { %parms<formal> ?? ( XW, 'at u') !! 'je' }, 'open voor een vrijblijvend gesprek',
        'om te zien of wij uw dataverwerking kunnen stroomlijnen en robuuster maken?', BR,
        'Dat kan desgewenst remote, hoewel een bezoek aan', %parms<location>,  'onze voorkeur zou hebben.', BR, BR,
        PN, 'vindt meer informatie op onze splinternieuwe website: untanglelogic.nl.')
      } elsif (%parms<visit>) {
        ('Op uw website zien we dat u zich o.a. bezighoudt met dataverzameling en -verwerking.',
        BR, BR,
        'Wij bieden consultancy aan op het gebied van dataverzameling en -verwerking.',
        'We hebben ervaring op het gebied van complexe spreadsheet- en database-configuraties.',
        'Sta', -> { %parms<formal> ?? ( XW, 'at u') !! 'je' }, 'open voor een vrijblijvend gesprek',
        'om te zien of wij uw dataverwerking kunnen stroomlijnen en robuuster maken?',
        'Dat kan desgewenst remote.',
        CAP, PN, 'vindt meer informatie op onze splinternieuwe website: untanglelogic.nl.')
      } elsif (%parms<long>) {
        ('Wij zetten op dit moment een consultancydienst op die organisaties helpt',
        'zich te bevrijden van diepe Excelvalkuilen.  Daarbij moet',  PN, 
        'denken aan organisaties die bijvoorbeeld Excel noodgedwongen',
        'als database gebruiken (met alle risicos van dien)',
        'of waarbij de verzamelingen bestanden groot en onoverzichtelijk worden.',
        CAP, PN, 'kunt ook denken aan organisaties die worstelen met pogingen',
        'om anderen toegang te geven tot de informatie uit de sheets',
        'zonder ze te hoeven confronteren met woeste Excelstructuren.', BR, BR,

        'We bieden een ander soort ondersteuning dan de meeste Excelexperts.',
        'Wij bieden een traject aan waarbij we het materiaal aan een geautomatiseerde analyze en scan onderwerpen.',
        'De resultaten kunnen we dan samen met', PNDAT, 'bestuderen met een speciaal daarvoor ontwikkelde tool set.',
        'Zo kunnen we zwakheden vinden, waarvan de auteur mogelijk geen weet had.', BR, BR,

        'Onze eerste klant had miljoenen cellen met waardes en formules en moest de hele verzameling per administratief jaar kopiëren en bijwerken!',
        'We hebben daar veel pijn kunnen wegnemen.', BR, BR,

        'We hebben al stappen gezet om vanuit een spreadheet-verzameling een applicatie te kunnen genereren die ongeveer hetzelfde doet, maar met een database werkt.',
        'Hier worden dus rekenmodellen en grafieken uit Excel vertaald naar rekenmodellen en grafieken in een (web)applicatie.',
        'Het resultaat kun', -> {%parms<formal> ?? ( XW, 't u') !! 'je'}, 
        'dan bijvoorbeeld aan', PNGEN, 'klanten ter beschikking stellen.',
        'Onze consultancy betreft dan bijvoorbeeld ook mogelijk rijkere visualisaties van informatie.')
      } else { # short
        ('Wij zijn op zoek naar mogelijke toepassingen van onze technologie om (grote) spreadsheetverzamelingen',
        'doormiddel van een door onszelf ontwikkelde semantische scanner inzichtelijker te maken.',
        'We zouden graag met iemand binnen', PNGEN, 'organisatie spreken',
        'die ervaring heeft met het analyzeren van spreadsheets van derden.', BR, BR)
      }
    }
  );
  $final .= new: ( %parms<formal> ?? "met vriendelijk groet," !!  "alvast bedankt," );
  $addr .= new: (
    q:to/EOADDR/;


      Theo van den Heuvel
      vdheuvel@untanglelogic.nl
      0625492788
      EOADDR

  );
  $letter .= new: ($greet, $intro, $body, $question, LONGBR, $final, $addr);


  spurt %parms<company>.lc.trans('a'..'z' => '', :complement) ~ "-$dt", process($letter, %parms);
}

