%- (+[string], -R)
%- dado lista de gids retorna o gid com mais carreiras
paragem_com_mais_carreiras([H],H).
paragem_com_mais_carreiras([H|T],R) :- 
    paragem_com_mais_carreiras(T,RT), 
    maior_lista_de_carreiras(H,RT,R)
.


%- (+string, +string, -R)
%- dado dois gids retorna o gid com mais carreiras
%gids(L), maior_lista_de_carreiras(L,R).
%maior_lista_de_carreiras(['79','597','261','341'],R).
maior_lista_de_carreiras(A,B,A) :-
    paragem(A,_,_,_,_,_,_,CA,_,_,_),
    paragem(B,_,_,_,_,_,_,CB,_,_,_),
    length(CA,TA),
    length(CB,TB),
    (TA > TB ;TA == TB)
.


maior_lista_de_carreiras(A,B,B) :-
    paragem(A,_,_,_,_,_,_,CA,_,_,_),
    paragem(B,_,_,_,_,_,_,CB,_,_,_),
    length(CA,TA),
    length(CB,TB),
    TA < TB
.


%- P_PROX tem alguma carreira em comum com P_ATUAL
%carreira_em_comum('003',R).
%findall(XO,carreira_em_comum('284',XO),R).
carreira_em_comum(P_ATUAL,P_PROX) :-
    paragem(P_ATUAL,_,_,_,_,_,_,CA,_,_,_),
    paragem(P_PROX,_,_,_,_,_,_,CB,_,_,_),
    \+ (P_ATUAL == P_PROX),
    \+ -any_match(CA,CB)
.


%- verdadei se duas listas nao tiverem algo em comum
%any_match(['005','009'],['001','005','009'],R).
-any_match([],_).
-any_match([C],CS) :- \+ memberchk(C,CS).
-any_match([C|CT],CS) :-
    \+ memberchk(C,CS), 
    -any_match(CT,CS)
.


%*
%- existe_caminho('001','003',R).
%- existe_caminho('183','79',R).
existe_caminho(A,B,P) :- caminho(A,[B],P).

caminho(A,[A|P1],[A|P1]).
caminho(A,[Y|P1],P) :- 
   % \+ memberchk(X,[Y|P1]),
    adjacente(Y,[Y|P1],X),
    caminho(A,[X,Y|P1],P)
.


%adjacentes('001',['003','004','005'],R).
%adjacente('001',[],R).
%- R = lista de paragens igualmente perto da paragem X
adjacentes(X,PATH,R) :- findall(TRY,adjacente(X,PATH,TRY),R).

adjacente(X,PATH,R) :-
    findall(TRY,carreira_em_comum(X,TRY),L),
    remove_equal(PATH,L,RL),
    closer_list(X,RL,R)
.


%mais_perto_list('005',['002','003','004','005'],R).
%- dado uma paragem P e uma lista de paragens L
%- retorna o ponto mais proximo de P em L
closer_list(P,L,R) :-
    member(R,L),
    closer_aux(P,L,R)
.


%mais_perto_aux('001',['002','003','004','005'],'005').
closer_aux(_,[],_).
closer_aux(P,[HL|TL],MP) :-
    closer_aux(P,TL,MP),
    closer(P,MP,HL)
.


%- B é o ponto mais perto de A
closer(A,B,C) :-
    distance(A,B,D1),
    distance(A,C,D2),
    (D1 < D2 ; D1 == D2)
.
