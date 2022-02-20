/* Визначити предикати для диференціювання тригонометричних функцій sin, cos, tg та ctg) та експоненти (e^Х). */

/** Приклади для вкладених, суперпозиції, складних:  **/
/**     1. d(3*x+sin(3*x*y+1), x, RES).
           RES = 3*1+cos(3*x*y+1)*(0*(3*x)+3*1*y+0) 

        2. d(cos(sin(2*x) + 1/y), x, RES).
           RES = -sin(sin(2*x)+1/y)*(cos(2*x)*(2*1)+1*(-1*y^(-1-1)*0)).

        3. d(pow(e, (tg(cos(2*x - y + 5)))), x, RES).
           RES = e^tg(cos(2*x-y+5))*(-sin(2*x-y+5)*(2*1-0+0)/cos(cos(2*x-y+5))^2).

        4. d(sin(y) + cos(x*y) + sin(x)*sin(y) * pow(e,cos(y)), y, RES).
           RES = cos(y)*1+ -sin(x*y)*(x*1)+(e^cos(y)*(-sin(y)*1)*(sin(x)*sin(y))+(cos(y)*1*sin(x)+cos(x)*0*sin(y))*pow(e, cos(y)))
**/ 


    

/** 1. SIN  **/
/** d(sin(U)|dx -> cos(U)*dU|dx  **/
/** Приклади: 
        1. d(sin(3*x), x, RES).
           RES = cos(3*x)*(3*1)
        2. d(sin(-4*x + 5), x, RES).
           RES = cos(-4*x+5)*(-4*1+0).  
**/
d(sin(U), X, cos(U)*W):- 
    d(U, X, W),
    !.


/** 2. COS  **/
/** d(cos(U)|dx -> -sin(U)*dU|dx **/
/** Приклади: 
        1. d(cos(x), x, RES).
           RES = -sin(x)*1.
        2. d(cos(x) + sin(2*x), x, RES).
           RES = -sin(x)*1+cos(2*x)*(2*1)  
**/
d(cos(U), X, -sin(U)*W):-
    d(U, X, W), 
    !.


/** 3. TG  **/
/** d(tg(U)|dx -> W|(cos(U))^2 **/
/** Приклади: 
        1. d(tg(5*x + 2), x, RES).
           RES =  (5*1+0)/cos(5*x+2)^2.
        2. d(tg(3*x/5 - z/2), x, RES).
           RES =  (-1*5^(-1-1)*0*(3*x)+3*1*5^ -1-z*(-1*2^(-1-1)*0))/cos(3*x/5-z/2)^2.
**/
d(tg(U), X, W / (cos(U)^2)):- 
    d(U, X, W), 
    !.


/** 4. CTG  **/
/** d(ctg(U)|dx -> -(W)|sin(U)^2 **/
/** Приклади: 
        1. d(ctg(5*x + 2), x, RES).
           RES = - (5*1+0)/sin(5*x+2)^2.
        2. d(ctg(3*x/5 - z/2), x, RES).
           RES = - (-1*5^(-1-1)*0*(3*x)+3*1*5^ -1-z*(-1*2^(-1-1)*0))/sin(3*x/5-z/2)^2.
**/
d(ctg(U), X, -(W) / (sin(U))^2):-
    d(U, X, W), 
    !.


/** 5. EXP  **/
/** d(e^U|dx -> e^U * (dU|dx) **/
/** Приклади: 
        1. d(pow(e,(x*2 +1)), x, RES).
           RES = e^(x*2+1)*(0*x+1*2+0).
        2. d(pow(e,(sin(x)*2 +1)), x, RES).
           RES = e^(sin(x)*2+1)*(0*sin(x)+cos(x)*1*2+0).
**/
d(pow(e, U), X, e^(U) * W):-
    d(U, X, W),
    !.


:-op(10,yfx,^).
:-op(9,fx,-).

% dx/dx->1
d(X,X,1):-!.

% dc/dx ->0
d(C,_,0):-atomic(C).

% d(-U)/dx ->-(dU/dx)
d(-U,X,-A):-d(U,X,A).

% d(U+V)/dx -> dU/dx+dV/dx
d(U+V,X,A+B):-d(U,X,A),d(V,X,B).

% d(U-V)/dx -> dU/dx-dV/dx
d(U-V,X,A-B):-d(U,X,A),d(V,X,B).

% d(cU)/dx -> c(dU/dx)
d(C*U,X,C*A):-atomic(C),C\=X,d(U,X,A),!.

% d(UV)/dx -> U(dV/dx)+V(dU/dx)
d(U*V,X,B*U+A*V):-d(U,X,A),d(V,X,B).

% d(U/V)/dx -> d(UV^-1)/dx
d(U/V,X,A):-d(U*V^(-1),X,A).

% d(U^c)/dx -> cU^(c-1)(dU/dx)
d(U^C,X,C*U^(C-1)*W):-atomic(C),C\=X,d(U,X,W).

% d(lnU)/dx -> U^(-1)(dU/dx) 
d(log(U),X,A*U^(-1)):-d(U,X,A).

% d(U(V))/dx -> (dV/dU)*dU/dx
d(U_V_X,X,DV*DU):-
	U_V_X=..[U,V_X],
	d(U_V_X,V_X,DU),
	d(V_X,X,DV).