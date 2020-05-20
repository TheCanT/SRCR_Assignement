%- check_closer_adjacencia(X,'255',[]).
check_closer_adjacencia(NEXT_STOP, CURRENT_STOP, PATH) :-
    findall(TRY, adjacencia(TRY, CURRENT_STOP), ADJACENTES),
    remove_equal(PATH, ADJACENTES, NOT_EQUALS),
    remove_dups(NOT_EQUALS, NO_DUPS),
    sort_distance(CURRENT_STOP, NO_DUPS, SORTED_BY_DISTANCE),
    member(NEXT_STOP, SORTED_BY_DISTANCE)
.


%- sort_distance('183',['791','595','182'],R).
%- sorts a list o stops with a given stop
sort_distance(FST, LIST, SORTED) :-
    adjacentes_to_distanceKey(FST, LIST, PAIR_LIST),
    keysort(PAIR_LIST, SORTED_LIST),
    listKV_to_listV(SORTED_LIST, SORTED)
.


%- list of Key-Value to list of Value
listKV_to_listV([],[]).
listKV_to_listV([PAIR|T], [VALUE|VALUES]) :-
    listKV_to_listV(T, VALUES),
    get_value(PAIR, VALUE)
.


%- get_value('791'-1,R).
get_value(_ - Value , Value).


%- with stop FST and List of stops
%- makes list of (Distance to FST)-(stop)
adjacentes_to_distanceKey(_, [], []).
adjacentes_to_distanceKey(FST, [HL|TL], [PAIR|PAIR_LIST]) :-
    distance_key(FST, HL, PAIR),
    adjacentes_to_distanceKey(FST, TL, PAIR_LIST)
.


%- makes pair of (Distance to FST)-(stop)
distance_key(FST, Old, Dist - Old) :-
    distance(FST, Old, Dist)
.


%- remove_equal(['003','004','005'],['002','003','007','005','005'],R).
remove_equal([],L,L).
remove_equal([H|T],L,R) :-
    remove_equal(T,L,RL),
    delete(RL,H,R)
.


%- R = arithmetic distance between A and B
distance(A,B,R) :-
    paragem(A,AX,AY,_,_,_,_,_,_,_,_),
    paragem(B,BX,BY,_,_,_,_,_,_,_,_),
    R is sqrt((BX - AX) ** 2 + (BY - AY) ** 2)
.
