#!/usr/bin/env gprolog --consult-file

% tail-recursive Fibonacci
fib(1, [1]).
fib(2, [1, 1]).
fib(N, Result) :-
  N > 2,
  fib(N, 1, 1, [1, 1], Result).

fib(2, _, _, Rest, Result) :-
  reverse(Rest, Result).
fib(N, R1, R2, Rest, Result) :-
  N > 2,
  N1 is N - 1,
  NR1 is R1 + R2,
  append([NR1], Rest, NRest),
  fib(N1, NR1, R1, NRest, Result).

:- initialization(main).
main :-
  fib(10, Result),
  write(Result), nl,
  halt.
