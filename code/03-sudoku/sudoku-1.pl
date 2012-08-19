#!/usr/bin/env gprolog --consult-file

% simplest sudoku of all, the n = 1 case

valid([]).
valid([Head | Tail]) :-
  permutation(Head, [1]),
  valid(Tail).

sudoku(Puzzle, Solution) :-
  Solution = Puzzle,
  Puzzle   = Cells,
  Rows     = [[A1]],
  Cols     = [[A1]],
  Squares  = [[A1]],
  Cells    = [A1],
  valid(Rows),
  valid(Cols),
  valid(Squares).

:- initialization(main).
main :-
  sudoku([_], Solution),
  write('puzzle:'), nl,
  write('[_]'), nl,
  write('solution:'), nl,
  write(Solution),
  halt.
