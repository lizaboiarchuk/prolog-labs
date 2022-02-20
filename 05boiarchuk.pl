/**
Боярчук Єлизавета Сергіївна
1.+
2.+
3.+
4.+
5.+

Перебір (4б) = 5 * 0.8 = 4б - Самооцінка 

**/



/** 1. У тризначному числi, всi цифри якого непаpнi, закpеслили середню цифру. Виявилось, що отpимане двозначне число є дiльником вихiдного числа. Знайдiть всi такi тризначнi числа. **/
z05_01_divider():- 
    create(1000),
    h01_all(X),
    write(X),
    nl, fail.

/** 2. Знайдiть чотиризначне число, яке є точним квадратом, у якого двi першi цифри однаковi та двi останнi також однаковi. **/
z05_02_squared():-
    create(10000),
    h02_all(X),
    write(X),
    nl,fail.

/** 3. Скiльки iснує цiлих чисел вiд 1 до 1998, якi не дiляться на жодне з чисел 6, 10, 15? **/
z05_03_number_of():-
    not(h03_all()),
    count(C),
    write(C).

/** 4. Знайти найменше натуральне число M, яке має наступну властивiсть: сума квадратiв одинадцяти послiдовних натуральних чисел, починаючи з M, є точним квадратом? **/
z05_04_eleven():-
    not(h04_help()),
    n(R),
    write(R).

/** 5. В послiдовностi 1998737... кожна цифра, починаючи з п'ятої, дорiвнює останнiй цифрi суми чотирьох попеpеднiх цифр. Через скiльки цифр знову зустрiнитья початкова комбiнацiя 1998 (тобто скiльки цифр в перiодi)? **/
z05_05_period_length(L):-
    h05_search([1, 9, 9, 8, 7], L),
    !.


/** _____________________________________________________________________________________________________ **/

/** перевірка, чи виконується умова **/
h01_check(X):-
    D is 10 * div(X, 100) + mod(X, 10),
    M is mod(X, D),
    M is 0.

/** створити від d(0) до заданого d(N) **/
create(-1):-!.
create(N):-
    asserta( d(N) ), 
    M is N - 1,
    create(M).

/** перевірка всіх чисел **/  
h01_all(X):- 
    d(N), 
    N >= 100,
    h01_check(N),
    X is N.  

/** _____________________________________________________________________________________________________ **/

/** перевірка, чи виконується умова другої задачі **/
h02_check(S):-
    A1 is div(S, 1000),
    A2 is mod(div(S, 100), 10),
    A3 is mod(div(S, 10), 10),
    A4 is mod(S, 10),
    A1 == A2, A3 == A4,
    Q is floor(sqrt(S)),
    D is (Q^2 - S), 
    D is 0.

/** перевірка всіх чисел **/  
h02_all(X):- 
    d(N), 
    N >= 1000,
    h02_check(N),
    X is N. 

/** _____________________________________________________________________________________________________ **/

/** перевірка, чи виконується умова третьої задачі **/
h03_check(S):-
    M6 is mod(S, 6),
    M10 is mod(S, 10),
    M15 is mod(S, 15),
    M6 > 0, M10 > 0, M15 > 0.

/** підрахунок таких чисел **/
h03_count:-
    d(X), X > 0,
    h03_check(X),
    count(C),
    D is C + 1,
    retract(count(C)),
    asserta(count(D)).

h03_all():-
    create(1998),
    asserta(count(0)),
    h03_count(), fail.

/** _____________________________________________________________________________________________________ **/

/** чи є число квадратом **/
h04_square(X):-
    Q is floor(sqrt(X)),
    D is (Q^2 - X), 
    D is 0.

/** сума квадратів чисел від числа А до числа В **/
h0_sum_square(A, A, SUM):- SUM=A*A, !.
h0_sum_square(A, B, SUM):-
    A1 is A + 1,
    h0_sum_square(A1, B, MSUM),
    NSUM = A * A,
    SUM is NSUM + MSUM,
    !.

/** перевірка всіх чисел **/
h04_check():-
    n(-1),
    d(N),
    N > 0,
    B is N + 10,
    h0_sum_square(N, B, SUM),
    h04_square(SUM),
    retract(n(-1)),
    asserta(n(N)).

h04_help():-
    create(100000),
    asserta(n(-1)),
    h04_check(),
    fail.

/** _____________________________________________________________________________________________________ **/

/** сума чисел в масиві **/
h05_list_sum([], R):- R = 0.
h05_list_sum([X|XS], R):- h05_list_sum(XS, RES), R is RES + X.

/** наступний символ **/
h05_next([X|XS], N):-
    h05_list_sum([X|XS], R),
    N is mod(R, 10).

/** останні N елементів з масиву **/
lastN(L,N,R):- length(L,X), X1 is X-N, lastT(L,X1,R).
lastT(L,0,L).
lastT([_|T],X,L):- X2 is X-1, lastT(T,X2,L).

/** один лист є початком іншого **/
h05_starts([], _).
h05_starts([X|XS], [X|YS]):- 
    h05_starts(XS, YS).

/** обраховуємо наступні елементи до того моменту, коли 4 створені елементи не будуть дорівнювати 1998 **/
h05_search([X|XS], RES):-
    lastN([X|XS], 4, R),
    h05_starts(R, [X|XS]),
    RES = 1, !.

h05_search([X|XS], RES):-
    lastN([X|XS], 4, R),
    not(h05_starts(R, [X|XS])),
    h05_next(R, N),
    append([X|XS], [N], M),
    h05_search(M, P),
    RES is P + 1, !.