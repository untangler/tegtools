# realetter.md

use tegtools two create letters we wrote earlier.

## 20211109

- rewrite letterEngine. done
- specific case e.g. kbadata
- no prompts, use tegs. done
- pass %parms. done
- separate company specific from untangle specific
- lang. done

Getting error when informal:

Type check failed in binding to parameter '@f'; expected Positional but got Str ("je")
  in sub recur at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 8
  in block  at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 26
  in sub recur at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 10
  in block  at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 26
  in sub recur at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 10
  in method write at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 36
  in block  at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 13
  in sub recur at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 10
  in method write at /home/theo/project/tegwriter/lib/TegTools/Teg.rakumod (TegTools::Teg) line 36
  in sub process at /home/theo/project/tegwriter/lib/TegTools.rakumod (TegTools) line 91
  in block <unit> at teg_kbadata.raku line 99

Why not same message when formal?

Does not happen in e.g. t/lang.t

## 20211110

yesterday's bug still unsolve.

focus on createing untangleTeg.rakumod