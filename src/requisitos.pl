:- use_module(library(lists)).
:- use_module(library(sets)).

% - Data - %

:- dynamic paragem/11.
:- dynamic adjacencia/3.

:- include('./prologData/paragens.pl').
:- include('./prologData/adjacencias.pl').


% - Auxiliar Files - %

:- include('path_algorithm.pl').
:- include('filter_predicates.pl').
:- include('breadth_first.pl').




% - Checks a path from B to A - %

check_path(A, B, P) :-
    build_path(A, [B], P)
.


build_path(A, [A|P1], [A|P1]).
build_path(A, [Y|P1], P) :-
   prox_adjacencias(Y, [Y|P1], XS),
   member(X, XS),
   build_path(A, [X,Y|P1], P)
.



% - Checks a path in a set of firms - %

check_path_firms(A, B, S, P) :-
    build_path_firms(A, [B], S, P)
.


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


build_path_cover(A, [A|P1], [A|P1]).
build_path_cover(A, [Y|P1], P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   prox_with_cover(X, Y),
   build_path_cover(A, [X,Y|P1], P)
.




% - Checks a path from B to A with - %
% - the intermidiate points given. - %

check_path_inter(A, B, L, R) :-
    append([L,[B]|[]], LR),
    build_path_inter(A, LR, P),
    append(P, R)
.

build_path_inter(_, [], []).
build_path_inter(A, [H|T], [NP|P]) :-
    check_path(A,H,NP),
    build_path_inter(H, T, P)
.




% - Checks shortest path from B to A - %

check_path_dist(A, B, P) :-
    build_path_dist(A, [B], P)
.


build_path_dist(A, [A|P1], [A|P1]).
build_path_dist(A, [Y|P1], P) :-
   check_closer_adjacencia(X, Y, [Y|P1]),
   build_path_dist(A, [X,Y|P1], P)
.




% - Path with the least stops   - %

check_path_least_stops(A, B, S) :-
    breadth_first(adjacencia,A,B,S)
.




% - list of gids to list of paragem - %

gids_to_paragens(LG, LP) :-
    maplist(get_paragem, LG, LP)
.




% - list of gids to list of paragem (users) - %

gids_to_paragens_user(LG, LP) :-
    maplist(get_paragem_user, LG, LP)
.

