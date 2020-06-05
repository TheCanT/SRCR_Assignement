% - Returns the next stop closer - %

check_closer_adjacencia(NEXT_STOP, CURRENT_STOP, PATH) :-
    findall(TRY, adjacencia(TRY, CURRENT_STOP,_), ADJACENTES),
    remove_dups(ADJACENTES, NO_DUPS),
    remove_equal(PATH, NO_DUPS, NOT_EQUALS),
    sort_distance(CURRENT_STOP, NOT_EQUALS, SORTED_BY_DISTANCE),
    member(NEXT_STOP, SORTED_BY_DISTANCE)
.


%- sort_distance('183',['791','595','182'],R).
% - sorts a list o stops with a given stop - %

sort_distance(FST, LIST, SORTED) :-
    adjacentes_to_distanceKey(FST, LIST, PAIR_LIST),
    keysort(PAIR_LIST, SORTED_LIST),
    keys_and_values(SORTED_LIST, _, SORTED)
.



% - with stop FST and List of stops - %
% - makes list of (Distance to FST)-(stop) - %

adjacentes_to_distanceKey(_, [], []).
adjacentes_to_distanceKey(FST, [HL|TL], [PAIR|PAIR_LIST]) :-
    distance_key(FST, HL, PAIR),
    adjacentes_to_distanceKey(FST, TL, PAIR_LIST)
.


% - makes pair of (Distance to FST)-(stop) - %

distance_key(FST, Old, Dist - Old) :-
    distance(FST, Old, Dist)
.


%remove_equal(['003','004','005'],['002','003','007','005','005'],R).
remove_equal([],L,L).
remove_equal([H|T],L,R) :-
    remove_equal(T,L,RL),
    delete(RL,H,R)
.


% - R = arithmetic distance between A and B - %

distance(A,B,R) :-
    paragem(A,AX,AY,_,_,_,_,_,_,_,_),
    paragem(B,BX,BY,_,_,_,_,_,_,_,_),
    R is sqrt((BX - AX) ** 2 + (BY - AY) ** 2)
.



%% -- - -- --- - --- - --- -- - -- %%


%get_career_connected('183', LIST_CAREERS).
get_career_connected_IN(A, LIST_CAREERS) :-
    findall(TRY, adjacencia(A, _, TRY), LIST_CAREERS)
.
get_career_connected_OUT(B, LIST_CAREERS) :-
    findall(TRY, adjacencia(_, B, TRY), LIST_CAREERS)
.


%get_num_stops_career('01', NUM_STOPS).
get_num_stops_career(C, NUM_STOPS) :-
    findall(TRY, adjacencia(TRY, _, C), S),
    length(S, NUM_STOPS)
.


%% -- - -- --- - --- - --- -- - -- %%

% - Returns the next stop closer - %
check_closerToEnd_adjacencia(NEXT_STOP, CURRENT_STOP, PATH, END) :-
    findall(TRY, adjacencia(TRY, CURRENT_STOP, _), ADJACENTES),
    remove_dups(ADJACENTES, NO_DUPS),
    remove_equal(PATH, NO_DUPS, NOT_EQUALS),
    sort_distance(END, NOT_EQUALS, SORTED_BY_DISTANCE),
    member(NEXT_STOP, SORTED_BY_DISTANCE)
%    firstN_elements(SORTED_BY_DISTANCE, 2, ARG),
%    member(NEXT_STOP, ARG)
.


%- firstN_elements(['791','595','182','791','595','182'],4,R).
firstN_elements(_,0,[]).
firstN_elements([H],_,[H]).
firstN_elements([HL|TL], N, [HL|T]) :-
    N >= 0,
    R is N-1,
    firstN_elements(TL, R, T)
.