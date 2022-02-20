/** 1. Напишіть предикат, який перетворює вихідний список у список позицій від'ємних елементів: **/
/** z061(+список_чисел, -список_позицій). **/
/** Тести:
        1. z061([-3, 2, -1, 0, -5, -5], POS).
           POS = [0, 2, 4, 5]

        2. z061([-100, 0, 0, -1, 2], POS).
           POS = [0, 3]                    **/ 
z061(X, POSITIONS):- z061_help(X, [], 0, POSITIONS).

z061_help([X|XS], POSITIONS, I, RESULT):- X < 0, I1 is I + 1, append(POSITIONS, [I], POS), z061_help(XS, POS, I1, RESULT).
z061_help([X|XS], POSITIONS, I, RESULT):- X >= 0, I1 is I + 1, z061_help(XS, POSITIONS, I1, RESULT).
z061_help([], POSITIONS, _, RESULT):- RESULT = POSITIONS.



/** 2. Напишіть предикат, що замінює всі входження заданого елемента на символ change_done. **/
/** z062(+список_елементів, +заданий_символ, -список_результат). **/
/** Тести:
        1. z062([1, 2, 4, 5, 2, 2], 2, RES).
           RES = [1, "change_done", 4, 5, "change_done", "change_done"] 

        2. z062(["a", "b", "c", "a"], "a", RES).
           RES = ["change_done", "b", "c", "change_done"]        **/ 
z062(X, S, RES):-  z062_help(X, S, [], RES).

z062_help([X|XS], S, LIST, RES):- X == S, append(LIST, ["change_done"], L), z062_help(XS, S, L, RES).
z062_help([X|XS], S, LIST, RES):- X \= S, append(LIST, [X], L), z062_help(XS, S, L, RES).
z062_help([], _, LIST, RES):- RES = LIST.



/** 3. Напишіть предикат, що перетворює будь-який список арабських чисел (до 90 або без "С"==100) у список відповідних їм римських чисел. **/
/** z063(+список_чисел, -список_результат). **/
/** Тести:
        1. z063([11, 12, 45, 88, 1], RES).
           RES = ["XI", "XII", "XLV", "LXXXVIII", "I"]

        2. z063([7, 50, 2], RES).
           RES = ["VII", "L", "II"]        **/ 
z063(X, RES):- maplist(z063_one_number, X, RES).

z063_help(X, _):- X < 0, !.
z063_help(0, R):- R = [].
z063_help(1, R):- R = ['I'].
z063_help(4, R):- R = ['IV'].
z063_help(5, R):- R = ['V'].
z063_help(9, R):- R = ['IX'].
z063_help(10, R):- R = ['X'].
z063_help(50, R):- R = ['L'].
z063_help(X, ['I'| RS]):- X < 4, X1 is X - 1, z063_help(X1, RS).  
z063_help(X, ['V'| RS]):- X < 9, X1 is X - 5, z063_help(X1, RS). 
z063_help(X, ['X'| RS]):- X < 40, X1 is X - 10, z063_help(X1, RS). 
z063_help(X, ['XL'| RS]):- X < 50, X1 is X - 40, z063_help(X1, RS).
z063_help(X, ['L'| RS]):- X < 90, X1 is X - 50, z063_help(X1, RS).

z063_one_number(X, S):- z063_help(X, L), atomics_to_string(L, S).



/** 4. Напишіть предикат, що здійснює циклічний зсув елементів списку на один вправо. **/
/** z064(+список_вхідний, -список_результат). **/
/** Тести:
        1. z064([1, 2, 3, 4, 5], RES).
           RES = [5, 1, 2, 3, 4]

        2. z064([5, 1, 2, 3, 4], RES).
           RES = [4, 5, 1, 2, 3]              **/ 
z064(X, [R|RS]):- append(RS, [R], X).



/** 5. Напишіть предикат, що реалізує множення матриці (список списків) на вектор. **/
/** z065(+список_рядків, +вектор, -список_результат_Вектор). **/
/** Тести:
        1. z065([[2, 4, 0],[-2, 1, 3],[-1, 0, 1]],[1, 2, -1], RES).
           RES = [10, -3, -2]

        2. z065([[2, 4, 0, 8],[-2, 1, 3, 5],[-1, 0, 1, 10]],[1, 0, -1, 4], RES).
           RES = [34, 15, 38]                                **/ 
z065(X, V, RES) :- z065_help(X, V, RES, []).

z065_help([Y|YS], V, L, X) :- z065_mult(Y, V, 0, P), append(X, [P], A), z065_help(YS, V, L, A).
z065_help([], _, L, X) :- L = X.

z065_mult([X|XS], [Y|YS], V, R):- R1 is V + X * Y, z065_mult(XS, YS, R1, R).
z065_mult([], [], X, R):- R = X.










