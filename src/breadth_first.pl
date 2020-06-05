% helper predicate
prepend(L, X, [X | L]).

% if goal is at the head of the queue, return it
breadth_first(_, [[Goal | Rest] | _], _, Goal, [Goal | Rest]).

% main recursive predicate: breadth_first(+Succ, +Queue, +Visited, +Goal, -Solution)
breadth_first(Succ, [[State | Path] | Queue], Visited, Goal, Solution) :-
    findall(X, call(Succ, State, X, _), Next),      % find all neighboring states
    subtract(Next, Visited, Next1),                 % remove already-visited states
    maplist(prepend([State | Path]), Next1, Next2), % prepend each state to path
    append(Queue, Next2, Queue2),                   % add all new states to queue
    append(Next1, Visited, Visited1),               % add all new states to visited set
    breadth_first(Succ, Queue2, Visited1, Goal, Solution)     % recurse
.

% top-level predicate: breadth_first(+Succ, Start, +Goal, -Solution)
breadth_first(Succ, Start, Goal, Solution) :-
    breadth_first(Succ, [[Start]], [Start], Goal, Solution1),
    reverse(Solution1, Solution)
.