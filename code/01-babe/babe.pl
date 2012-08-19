#!/usr/bin/env gprolog --consult-file

% Facts
%
% - Babe is a pig
% - pigs like mud

type(babe, pig).
likes(pig, mud).

% "is" is a built-in (native-code) predicate,
% and those cannot be redefined; we use "type" instead

% Rules
%
% - an animal likes mud if it is a pig

likes(X, mud) :- type(X, pig).

% Query
%
% - does Babe like mud?
%
% Interactively, would write:
%
%   ?- likes(babe, mud).
%
% and prolog would reply "yes", but in script form have to jump through
% a hoop or two

:- initialization(main).
main :-
  write('does babe like mud?'), nl,
  (likes(babe, mud) -> write(true) ; write(false)), nl,
  halt.
