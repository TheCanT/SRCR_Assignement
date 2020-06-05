:- use_module(library(lists)).


% - Data - %

:- dynamic paragem/11.
:- dynamic adjacencia/3.

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
%- findall(TRY,check_path('183','79',TRY),R). (not working)

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



% - Checks a path from B to A, pontos  - %

check_path_inter(A, B, L, R) :-
    append([L,[B]|[]], LR),
    build_path_inter(A, LR, P),
    append(P, R)
.

%- check_path_inter('183','79',[],R), calc_distance_path(R,N).

build_path_inter(_, [], []).
build_path_inter(A, [H|T], [NP|P]) :-
    check_path(A,H,NP),
    build_path_inter(H, T, P)
.







%% -- - -- --- - --- - --- -- - -- %%

% - Checks a path from B to A - %

check_path_2(A, B, P) :-
    build_path2(A, [B], P)
.

/*
check_path_2('183','79',R1), 
calc_distance_path(R1,N1), 
length(R1,L1),

check_path('183','79',R2), 
calc_distance_path(R2,N2),
length(R2,L2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_path_2('746','1025',R1), 
calc_distance_path(R1,N1), 
length(R1,L1),

check_path('746','1025',R2), 
calc_distance_path(R2,N2),
length(R2,L2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_path_2('182','345',R1), 
calc_distance_path(R1,N1), 
length(R1,L1),

check_path('182','345',R2), 
calc_distance_path(R2,N2),
length(R2,L2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check_path_2('706','720',R1), 
calc_distance_path(R1,N1), 
length(R1,L1),

check_path('706','720',R2), 
calc_distance_path(R2,N2),
length(R2,L2).

*/
%- check_path_2('746','1025',R), calc_distance_path(R,N).
%- check_path('746','1025',R), calc_distance_path(R,N).
%- check_path('183','79',R), calc_distance_path(R,N).
%- check_path('183','79',R), calc_distance_path(R,N).
%- findall(TRY,check_path_2('183','79',TRY),R). (not working)

build_path2(A, [A|P1], [A|P1]).
build_path2(A, [Y|P1], P) :-
   check_closerToEnd_adjacencia(X, Y, [Y|P1], A),
   build_path2(A, [X,Y|P1], P)
.

check_path_2(A, B, H) :-
    build_path2(A, [B], P1),
    build_path(A, [B], P2),
    calc_distance_path(P1, D1),
    calc_distance_path(P2, D2),
    keys_and_values(KV, [D1,D2|[]], [P1,P2|[]]),
    keysort(KV, SORTED),
    keys_and_values(SORTED, _, [H|_])
.
