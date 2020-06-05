% - Returns the stops with most busess - %

max_carreiras(PATH, LIST_WITH_MORE_CARR) :-
    maplist(aux_num_carreiras, PATH, NUM_CARR),
    keys_and_values(KV_LIST, NUM_CARR, PATH),
    keysort(KV_LIST, SORTED),
    reverse(SORTED, [H|T]),
    check_equal_key(H, T, KV_MAX),
    keys_and_values(KV_MAX, _, LIST_WITH_MORE_CARR)
.
%max_carreiras(['79','261','341'],R).
%check_path('183','79',R), calc_distance_path(R,N), max_carreiras(R,S).


check_equal_key(H,[],[H]).
check_equal_key(KH-VH, [KT-VT|TS], [KT-VT|KV_MAX]) :-
    KH == KT,
    check_equal_key(KH-VH, TS, KV_MAX)
.
check_equal_key(KH-VH, [KT-_|TS], KV_MAX) :-
    \+ KH == KT,
    check_equal_key(KH-VH, TS, KV_MAX)
.


aux_num_carreiras(A,TA) :-
    paragem(A,_,_,_,_,_,_,CA,_,_,_),
    length(CA,TA)
.


% - Calculates the distance from a path - %

calc_distance_path([_], 0).
calc_distance_path([H1,H2|T], R) :-
    calc_distance_path([H2|T], RS),
    distance(H1, H2, D),
    R is D + RS
.


% - Next stop from a set of firms - %

prox_in_setOfFirm(A, B, SET) :-
    adjacencia(A, B, _),
    paragem(A,_,_,_,_,_,A_FIRM,_,_,_,_),
    paragem(B,_,_,_,_,_,B_FIRM,_,_,_,_),
    memberchk(A_FIRM, SET),
    memberchk(B_FIRM, SET)
.


% - Next stop not from a set of firms - %

-prox_in_setOfFirm(A, B, SET) :-
    adjacencia(A, B, _),
    paragem(A,_,_,_,_,_,A_FIRM,_,_,_,_),
    paragem(B,_,_,_,_,_,B_FIRM,_,_,_,_),
    \+ memberchk(A_FIRM, SET),
    \+ memberchk(B_FIRM, SET)
.


% - Next stop with advertisement - %

prox_with_advertisement(A, B) :-
    adjacencia(A, B, _),
    paragem(A,_,_,_,_,A_ADV,_,_,_,_,_),
    paragem(B,_,_,_,_,B_ADV,_,_,_,_,_),
    A_ADV == 'Yes',
    B_ADV == 'Yes'
.


% - Next stop with cover - %

prox_with_cover(A, B) :-
    adjacencia(A, B, _),
    paragem(A,_,_,_,A_COVER,_,_,_,_,_,_),
    paragem(B,_,_,_,B_COVER,_,_,_,_,_,_),
    \+ A_COVER == 'Sem Abrigo',
    \+ B_COVER == 'Sem Abrigo'
.