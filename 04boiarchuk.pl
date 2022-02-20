/* 1. Ділення з остачею (лише для додатних цілих чисел) 
        Приклад: z01_div_mod(13, 3, DIV, MOD). */
z01_div_mod(X, Y, 0, X):- X<Y, !.
z01_div_mod(X, Y, DIV, MOD):-
    X>=Y,
    C is X-Y,
    z01_div_mod(C, Y, S, MOD),
    DIV is S+1,
    !.



/* 2. Піднесення до степеню (лінійне)
        Приклад: 02_pow_linear(3, 5, RES). */
z02_pow_linear(X, 1, X):- !.
z02_pow_linear(X, 0, 1):- !.
z02_pow_linear(X, N, RES):-
    M is N - 1,
    z02_pow_linear(X, M, R),
    RES is R * X.



/* 2. Піднесення до степеню (логарифмічне)
        Приклад: z02_pow_log(3, 5, RES). */
z02_pow_log(X, 1, X):- !.
z02_pow_log(X, 0, 1):- !.
z02_pow_log(X, N, RES):-
    M is div(N, 2),
    0 is mod(N, 2),
    z02_pow_log(X, M, R),
    RES is R * R,
    !.
z02_pow_log(X, N, RES):-
    M is div(N-1, 2),
    1 is mod(N, 2),
    z02_pow_log(X, M, R),
    RES is X * R * R,
    !.


/* 3. Числа Фібоначчі (рекурсія). Виводимо задане число Фібоначі.
        Приклад: z03_fibonacci(7, RES). */
z03_fibonacci(0, 0):- !.
z03_fibonacci(1, 1):- !.
z03_fibonacci(N, RES):-
    M is N-1,
    K is N-2,
    z03_fibonacci(M, V1),
    z03_fibonacci(K, V2),
    RES is (V1 + V2).




/* 4. Розклад числа на прості множники.
        Приклад: z04_factorize(60). */
z04_factorize(X, F):- F>=X, write(X), !.
z04_factorize(X, F):- 
    0 is mod(X,F),
    Y is div(X,F),
    write(F),
    nl,
    z04_factorize(Y,F),
    !.
z04_factorize(X, F):- 
    not(0 is mod(X,F)),
    Y is F+1,
    z04_factorize(X,Y),
    !.
z04_factorize(1):- write(1), !.
z04_factorize(X):- z04_factorize(X, 2), !.




/* 5. Обрахувати сумму 1/1! + 1/2! + 1/3! + ... 1/n!
        Приклад: z05_sum_rec(3, RES). */
z05_sum_rec(1, V, RES):- V is 1, RES is 1, !.
z05_sum_rec(N, V, RES):-
    M is N-1,
    z05_sum_rec(M, V1, R),
    V is V1 * N,
    RES is R + 1/V.
z05_sum_rec(N, RES):- 
    z05_sum_rec(N, _, RES).



/* 5. ОАлгоритм Евкліда (пошуку НСД)
        Приклад: z06_gcd(32, 48, RES). */
z06_gcd(0, M, M):- !.
z06_gcd(M, 0, M):- !.
z06_gcd(M, N, M):- M=N, !.
z06_gcd(M, N, RES):-
    M > N, 
    K is M - N,
    z06_gcd(K, N, RES), 
    !.
z06_gcd(M, N, RES):-
    M =< N, 
    K is N - M,
    z06_gcd(M, K, RES), 
    !.

