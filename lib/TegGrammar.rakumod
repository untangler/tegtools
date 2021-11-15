use v6;

grammar TegGrammar is export {
  token TOP { ^ <TegFile> $ }
  rule TegFile { <TegDecl>+ }
  rule TegDecl { <Name> '=' <TegTerm> }
  rule TegTerm { <String> | <Name> | Directive | <Block> }
  rule Block { '{' ~ '}' <TegExpr> }
  rule TegExpr { <TegAlt> + %% '|' }
  rule TegAlt { <TegTerm> + % ',' }
  

  rule Directive { <:U>+ [ ' [' ~ ' ]' <DirParms> ]? }
  rule DirParms { <DirParm> + % ',' }
  token DirParm { \w+ }

  token Name { <:L> \w+ }
  token String { 
        '"' $<content>=<-[ " ]> * '"' 
    || "'" $<content>=<-[ ' ]> * "'" 
  }

  regex ws {
    <!ww> [
      | \s* '#' .* $
      | \s* '/*' \s* .*? \s* '*/' \s*
    ]
  }
}