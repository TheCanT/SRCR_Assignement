:- use_module(library(lists)).

% - Data - %

:- dynamic paragem/11.
:- dynamic adjacencia/2.

:- include('./prologData/paragens.pl').
:- include('./prologData/adjacencias.pl').


% - Auxiliar Files - %

:- include('path_algorithm.pl').
:- include('aux_predicates.pl').



% - Checks a path from B to A - %

check_path(A, B, P) :-
    build_path(A, [B], P)
.


%- check_path('183','79',R).

build_path(A, [A|P1], [A|P1]).
build_path(A, [Y|P1], P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   \+ memberchk(X, [Y|P1]),
   build_path(A, [X,Y|P1], P)
.


% - Calculates the distance from a path - %

calc_distance_path([_], 0).
calc_distance_path([H1,H2|T], R) :-
    calc_distance_path([H2|T], RS),
    distance(H1, H2, D),
    R is D + RS
.

%- check_path('183','79',R), calc_distance_path(R,N).




















%--- pesquisa em profundidade primeiro Multi_Estados

%- findall(TRY, resolve_pp_h('183','79',TRY), R).
%- resolve_pp_h('183','79',R), calc_distance_path(R,N).
resolve_pp_h(Origem, Destino, Caminho) :-
    profundidade(Origem, Destino, [Origem], Caminho)
.

profundidade(Destino, Destino, H, D) :- reverse(H,D).
profundidade(Origem, Destino, Path, C):-
    check_closer_adjacencia1(Origem, Path, Prox),
    profundidade(Prox, Destino, [Prox|Path], C)
.

check_closer_adjacencia1(CURRENT_STOP, PATH, NEXT_STOP) :-
    findall(TRY, adjacencia(CURRENT_STOP, TRY), ADJACENTES),
    remove_equal(PATH, ADJACENTES, NOT_EQUALS),
    remove_dups(NOT_EQUALS, NO_DUPS),
    sort_distance(CURRENT_STOP, NO_DUPS, SORTED_BY_DISTANCE),
    member(NEXT_STOP, SORTED_BY_DISTANCE)
.
