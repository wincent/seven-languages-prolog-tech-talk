#!/usr/bin/env gprolog --consult-file

% Simplest possible battleship game:
%   - single player
%   - one ship, hardcoded to occupy row 2
%   - recurse endlessly until you hit the ship

% Magic numbers
%  -1 = miss
%   0 = open water
%   1 = ship
%   2 = hit

row_at(X, Row, State) :-
  nth(X, State, Row).

column_at(Y, Row, Cell) :-
  nth(Y, Row, Cell).

ship_at(X, Y, State) :-
  row_at(X, Row, State),
  column_at(Y, Row, Cell),
  Cell > 0.

fire_at(X, Y, State, NewState) :-
  (ship_at(X, Y, State) ->
    write('a hit, a very palpable hit!'), nl,
    set_at(X, Y, 2, State, NewState) ;
    write('he shoots, he scores... not!'), nl,
    set_at(X, Y, -1, State, NewState)).

set_at(X, Y, Value, State, NewState) :-
  NewState = State,
  row_at(X, Row, State),
  setarg(Y, Row, Value).

alive(State) :-
  flatten(State, Flattened),
  member(1, Flattened).

prompt_number(Prompt, Number) :-
  write(Prompt),
  write(': '),
  read_integer(Number).

run(State) :-
  prompt_number('enter row number', Row),
  prompt_number('enter column number', Col),
  fire_at(Row, Col, State, NewState),
  (alive(NewState) ->
    write('keep trying!'), nl, run(NewState) ;
    write('you won!'), nl, halt).

:- initialization(main).
main :-
  InitialState = [[0, 0],
                  [1, 1]],
  run(InitialState).
