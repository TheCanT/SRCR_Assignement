
%:- use_module(library(lists)).


:- dynamic paragem/11.

:- include('stdout').


lol([H],H).
lol([H|T],R) :- lol(T,RT), maior_lista_de_carreiras(H,RT,R).

%- retorna o gid com mais numero de carreiras
maior_lista_de_carreiras(A,B,A) :-
    paragem(A,_,_,_,_,_,_,CA,_,_,_),
    paragem(B,_,_,_,_,_,_,CB,_,_,_),
    length(CA,TA),
    length(CB,TB),
    (TA > TB ;TA == TB).
maior_lista_de_carreiras(A,B,B) :-
    paragem(A,_,_,_,_,_,_,CA,_,_,_),
    paragem(B,_,_,_,_,_,_,CB,_,_,_),
    length(CA,TA),
    length(CB,TB),
    TA < TB.

%gids(L), lol(L,R).
%lol(['79','597','261','341'],R).