#!/usr/bin/env gprolog --consult-file

% True if X is the last element of List, and Remainder
% is the rest of List without X.
pop(List, X, Rest) :-
  reverse(List, Reversed),
  Reversed = [X|Tail],
  reverse(Tail, Rest).

fib(1, [1]).
fib(2, [1, 1]).
fib(N, Result) :-
  Prev is N - 1,
  fib(Prev, Sequence),
  pop(Sequence, X, Rest),
  pop(Rest, Y, _),
  F is X + Y,
  append(Sequence, [F], Result).

:- initialization(main).
main :-
  fib(10, Result),
  write(Result), nl,
  halt.
