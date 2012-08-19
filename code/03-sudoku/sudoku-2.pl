#!/usr/bin/env gprolog --consult-file

% sudoku, n = 2

valid([]).
valid([Head | Tail]) :-
  permutation(Head, [1, 2, 3, 4]),
  valid(Tail).

sudoku(Puzzle, Solution) :-
  Solution = Puzzle,
  Puzzle   = Cells,
  Rows     = [[A1, B1, C1, D1],
              [A2, B2, C2, D2],
              [A3, B3, C3, D3],
              [A4, B4, C4, D4]],
  Cols     = [[A1, A2, A3, A4],
              [B1, B2, B3, B4],
              [C1, C2, C3, C4],
              [D1, D2, D3, D4]],
  Squares  = [[A1, B1, A2, B2],
              [C1, D1, C2, D2],
              [A3, B3, A4, B4],
              [C3, D3, C4, D4]],
  Cells    = [A1, A2, A3, A4,
              B1, B2, B3, B4,
              C1, C2, C3, C4,
              D1, D2, D3, D4],
  valid(Rows),
  valid(Cols),
  valid(Squares).

pretty([]).
pretty(List) :-
  [A, B, C, D | Tail] = List,
  Head = [A, B, C, D],
  write(Head), nl,
  pretty(Tail).

:- initialization(main).
main :-
  sudoku([_, _, 2, 3,
          _, _, _, _,
          _, _, _, _,
          3, 4, _, _], Solution),
  write('puzzle:'), nl,
  %write('[_]'), nl,
  write('solution:'), nl,
  pretty(Solution),
  halt.
