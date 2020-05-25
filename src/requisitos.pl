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

%- check_path('183','79',R), calc_distance_path(R,N).

build_path(A, [A|P1], [A|P1]).
build_path(A, [Y|P1], P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   build_path(A, [X,Y|P1], P)
.



% - Checks a path in a set of firms - %

check_path_firms(A, B, S, P) :-
    build_path_firms(A, [B], S, P)
.

%- check_path_firms('183','79',['Vimeca'],R), calc_distance_path(R,N).

build_path_firms(A, [A|P1], _, [A|P1]).
build_path_firms(A, [Y|P1], S, P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   prox_in_setOfFirm(X, Y, S),
   build_path_firms(A, [X,Y|P1], S, P)
.



% - Checks a path not in a set of firms - %

check_path_nFirms(A, B, S, P) :-
    build_path_nFirms(A, [B], S, P)
.

%- build_path_nFirms('183','79',['lol'],R), calc_distance_path(R,N).

build_path_nFirms(A, [A|P1], _, [A|P1]).
build_path_nFirms(A, [Y|P1], S, P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   -prox_in_setOfFirm(X, Y, S),
   build_path_nFirms(A, [X,Y|P1], S, P)
.



% - Checks a path from B to A - %

check_path_advertisement(A, B, P) :-
    build_path_adv(A, [B], P)
.

%- check_path_advertisement('183','79',R), calc_distance_path(R,N).

build_path_adv(A, [A|P1], [A|P1]).
build_path_adv(A, [Y|P1], P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   prox_with_advertisement(X, Y),
   build_path_adv(A, [X,Y|P1], P)
.



% - Checks a path from B to A - %

check_path_cover(A, B, P) :-
    build_path_cover(A, [B], P)
.

%- check_path_cover('183','79',R), calc_distance_path(R,N).

build_path_cover(A, [A|P1], [A|P1]).
build_path_cover(A, [Y|P1], P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   prox_with_cover(X, Y),
   build_path_cover(A, [X,Y|P1], P)
.













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
