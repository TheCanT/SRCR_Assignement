
:- use_module(library(lists)).

% - Data - %
:- dynamic paragem/11.
:- dynamic adjacencia/2.

:- include('./prologData/paragens.pl').
:- include('./prologData/adjacencias.pl').


% - Auxiliar Files - %
:- include('path_algorithm.pl').



%- all_paths('183','79',R).
%- all_paths('183','79',R), length(R,N).
all_paths(A,B,R) :-
    findall(TRY,check_path(A,B,TRY),R)
.

%- check_path('183','79',R).
check_path(A, B, P) :-
    build_path(A, [B], P)
.

build_path(A, [A|P1], [A|P1]).
build_path(A, [Y|P1], P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   \+ memberchk(X, [Y|P1]),
   build_path(A, [X,Y|P1], P)
.


%- check_closer_adjacencia(X,'255',[]).
check_closer_adjacencia(X, Y, PATH) :-
    findall(TRY, adjacencia(TRY, Y), ADJACENTES),
    remove_equal(PATH, ADJACENTES, NOT_EQUALS),
    remove_dups(NOT_EQUALS, NO_DUPS),
    sort_distance(Y, NO_DUPS, SORTED_BY_DISTANCE),
    member(X, SORTED_BY_DISTANCE)
.

check_adjacencia(X, Y, _) :-
    adjacencia(X, Y)
.


%- check_path('183','79',R), calc_distance_path(R,N).
calc_distance_path([_],0).
calc_distance_path([H1,H2|T],R) :-
    calc_distance_path([H2|T],RS),
    distance(H1,H2,D),
    R is D + RS
.