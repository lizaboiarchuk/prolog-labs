family(
    person(torn, fox, date(7, may, 1960), works(bbc, 15200)),
    person(ann, fox, date(9, may, 1961), unemployed),
    [ person(pat, fox, date(5, may, 1983), works(bbc, 2000)), 
    person(jim, fox, date(5, may, 1981), unemployed)]
).
family(
    person(peter, green, date(7, may, 1938), works(bbc, 3000)),
    person(emily, green, date(9, may, 1958), works(bbc, 2000)),
    [ person(dave, green, date(5, may, 1981), unemployed), 
    person(john, green, date(5, may, 1981), unemployed), 
    person(steve, green, date(5, may, 1981), unemployed),
    person(bob, green, date(5, may, 1981), works(bbc, 2000))]
).
family(
    person(evan, green, date(7, may, 1940), unemployed),
    person(daria, green, date(9, may, 1940), works(bbc, 2000)),
    []
).


/* допоміжні правила */
husband(X) :- family(X, _, _).
wife(X) :- family(_, X, _).
child(X) :- family(_, _, Children), member(X, Children).
exists(Person) :- husband(Person); wife(Person); child(Person).
dateofbirth(person(_, _, date, _), date).
salary(person(_, _, _, works(_, S)), S).
salary(person(_, _, _, unemployed), 0).


/* 1. Знайти всіх дітей, які народилися у 1981. */
children1981(X) :- child(X), dateofbirth(X, date(_, _, 1981)).

/* 2. Знайти всіх жінок, які не працюють. */
unemployedWife(Name, Surname) :- wife(person(Name, Surname, _, unemployed)).

/* 3. Знайти всіх людей, які не працюють, але не досягли пенсійного віку. (Беремо пенсійний вік - 65 років) */
notRetiredUnemployed(Name, Surname) :- exists(person(Name, Surname, date(_, _, X), unemployed)), X > 2022 - 65.

/* 4. Знайти всіх людей, які народилися до 1961, та чий прибуток менше 10000. */
elder1961WithSalaryLess10000(Name, Surname) :-  exists(person(Name, Surname, date(_, _, X), works(_, Y))), X < 1961, Y < 10000.

/* 5. Знайти прізвища людей, які мають хоча б трьох дітей. */
has3Children(Name, Surname) :- family(_, person(Name, Surname, _, _), [_, _, _ | _]); family(person(Name, Surname, _, _), _, [_, _, _ | _]). 

/* 6. Знайти родини без дітей. */
familyWithoutChildren(Dad, Mom) :- family(Dad, Mom, []).

/* 7. Знайти всіх працюючих дітей. */
workingChildren(Name, Surname, Date, Salary) :- child(person(Name, Surname, Date, works(_, Salary))).

/* 8. Знайти родини, де жінка працює, а чоловік ні. */
familyWithWorkingWife(Dad, Mom, Children) :- family(Dad, Mom, Children), salary(Mom, MomSalary), MomSalary > 0, salary(Dad, DadSalary), DadSalary == 0.

/* 9. Знайти всіх дітей, для яких різниця у віці їх батьків більше 15 років. */
childrenOfParentsWithBigDifference(Child) :- family(person(_, _, date(_, _, X), _), person(_, _, date(_, _, Y), _), Children), (X - Y > 15; Y - X > 15), member(Child, Children).

