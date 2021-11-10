# setup.md


## 20211107

setting up tegwriter

TODO

- create t/basic.t
- create basic model 
- create desired output

I don't know how to export contants of type Teg,
so for now we create them inside basic.t

some ideas:

special Teg class StageDirection
special class for processsed Tex fragments
either plain string (never empty) or direction.
process to create op on pairs of strings,
this is sort of a reduce operator.
Directions have traits like
- inline interpunction (comma, colon, semicolon), 
- expect whitespace
- whitespace
- single/double newline
- expect upper casing
- optional end of utterance
- optional start of utterance
between plain strings we put a blank.

maybe we use the traits as symbols,
and process them in parallel if consecutive.

## 20211108

where did I create union types before? see excel2app/lib/Type

new approach. top layer consists of Teg's 
This is transformed into a sequence of Frag's.
A Frag is a Str or a Directive

insert TegTools mod
set up module tree
 - TegTools (glue)
  - Teg
  - Directive (for now, an enum)
  - Frag

predefine set of sigilless Directives. (as callables?)

Think about a tool for e.g. pronouns (lang, number, formal, case). done

We allow for some actions on strings, but not a real look into them,
e.g. for initial uppercasing.