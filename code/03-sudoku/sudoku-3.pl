#!/usr/bin/env gprolog --consult-file

% sudoku, n = 3

% split_at(N, List, Left, Right).
split_at(0, Xs, [], Xs).
split_at(_, [], [], []).
split_at(N, [X|Xs], [X|Xs1], Xs2) :-
  N > 0,
  N1 is N - 1,
  split_at(N1, Xs, Xs1, Xs2).

% check if a list of lists (rows, columns, squares)
% is valid
valid([]).
valid([Head | Tail]) :-
  fd_all_different(Head),
  valid(Tail).

sudoku(Puzzle, Solution) :-
  Solution = Puzzle,
  rows(Puzzle, Rows),
  cols(Puzzle, Cols),

  % "Squares" is the odd one out, that I didn't have
  % time to implement
  Squares = [[A1, B1, C1, A2, B2, C2, A3, B3, C3],
             [D1, E1, F1, D2, E2, F2, D3, E3, F3],
             [G1, H1, I1, G2, H2, I2, G3, H3, I3],
             [A4, B4, C4, A5, B5, C5, A6, B6, C6],
             [D4, E4, F4, D5, E5, F5, D6, E6, F6],
             [G4, H4, I4, G5, H5, I5, G6, H6, I6],
             [A7, B7, C7, A8, B8, C8, A9, B9, C9],
             [D7, E7, F7, D8, E8, F8, D9, E9, F9],
             [G7, H7, I7, G8, H8, I8, G9, H9, I9]],
  Puzzle  = [A1, B1, C1, D1, E1, F1, G1, H1, I1,
             A2, B2, C2, D2, E2, F2, G2, H2, I2,
             A3, B3, C3, D3, E3, F3, G3, H3, I3,
             A4, B4, C4, D4, E4, F4, G4, H4, I4,
             A5, B5, C5, D5, E5, F5, G5, H5, I5,
             A6, B6, C6, D6, E6, F6, G6, H6, I6,
             A7, B7, C7, D7, E7, F7, G7, H7, I7,
             A8, B8, C8, D8, E8, F8, G8, H8, I8,
             A9, B9, C9, D9, E9, F9, G9, H9, I9],
             fd_domain(Puzzle, 1, 9),
  valid(Rows),
  valid(Cols),
  valid(Squares).

width(Puzzle, Width) :-
  length(Puzzle, Length),
  Width is round(sqrt(Length)).

rows(Puzzle, Rows) :-
  width(Puzzle, Width),
  rows_(Puzzle, Width, Rows).
rows_([], _, []).
rows_(List, Width, Rows) :-
  split_at(Width, List, Row, Rest),
  rows_(Rest, Width, MoreRows),
  append([Row], MoreRows, Rows).

% to get the columns, we just transpose the rows
cols(Puzzle, Cols) :-
  rows(Puzzle, Rows),
  transposed(Rows, Cols).

% running out of time, so shamelessly stolen off Stack Overflow
% http://stackoverflow.com/questions/4280986/how-to-transpose-a-matrix-in-prolog
transposed(A, B) :- transposed(A, [], B).
transposed(M, X, X) :- blank(M), !.
transposed(M, A, X) :- columns(M, Hs, Ts), transposed(Ts, [Hs|A], X).
blank([[]|A]) :- blank(A).
blank([]).
columns([[Rh|Rt]|Rs], [Rh|Hs], [Rt|Ts]) :- columns(Rs, Hs, Ts).
columns([[]], [], []).
columns([], [], []).

% to get squares, would use existing rows,
% taking "size" elements off "size" rows,
% and repeating until nothing left to take
squares(Puzzle, Squares) :-
  rows(Puzzle, Rows),
  width(Puzzle, Width),
  Size is round(sqrt(Width)),
  squares_(Rows, Size, Squares).
squares_([], _, _).
  % TODO: the rest of it...

pretty(Puzzle) :-
  width(Puzzle, Width),
  pretty_(Puzzle, Width).
pretty_([], _).
pretty_(List, Width) :-
  split_at(Width, List, Row, Rest),
  write(Row), nl,
  pretty_(Rest, Width).

:- initialization(main).
main :-
  Puzzle = [_, _, _, 1, 5, _, _, 7, _,
            1, _, 6, _, _, _, 8, 2, _,
            3, _, _, 8, 6, _, _, 4, _,
            9, _, _, 4, _, _, 5, 6, 7,
            _, _, 4, 7, _, 8, 3, _, _,
            7, 3, 2, _, _, 6, _, _, 4,
            _, 4, _, _, 8, 1, _, _, 9,
            _, 1, 7, _, _, _, 2, _, 8,
            _, 5, _, _, 3, 7, _, _, _],
  sudoku(Puzzle, Solution),
  write('solution:'), nl,
  pretty(Solution),
  halt.
