/* Факти */
movieSession(
    cinema(201, 'South', '191 Portobello Road', '340576', 30),
    movie(1001, 'The Graduate', 1967, 'Lawrence Turman', 1),
    date(19, 3, 2020),
    time(20,20),
    150).
movieSession(
    cinema(201, 'South', '191 Portobello Road', '340576', 30),
    movie(1002, 'Some Like It Hot', 1967, 'Billy Wilder', 1),
    date(18, 3, 2020),
    time(19,40),
    120).
movieSession(
    cinema(201, 'South', '191 Portobello Road', '340576', 30),
    movie(1003, 'Singin in the Rain', 1952, 'Arthur Freed', 2),
    date(20, 3, 2020),
    time(20,20),
    180).
movieSession(
    cinema(202, 'North', '2 Television Centre', '340364', 20),
    movie(1001, 'The Graduate', 1967, 'Lawrence Turman', 1),
    date(18, 3, 2020),
    time(18,20),
    90).
movieSession(
    cinema(202, 'North', '2 Television Centre', '340364', 20),
    movie(1002, 'Some Like It Hot', 1967, 'Billy Wilder', 1),
    date(18, 3, 2020),
    time(16,40),
    100).
movieSession(
    cinema(202, 'North', '2 Television Centre', '340364', 20),
    movie(1004, 'It is a Wonderful Life', 1946, 'Sam Spiegel', 1),
    date(19, 3, 2020),
    time(19,10),
    190).
movieSession(
    cinema(202, 'North', '2 Television Centre', '340364', 20),
    movie(1005, 'On the Waterfront', 1954, 'Sam Spiegel', 2),
    date(18, 3, 2020),
    time(21,20),
    135).
movieSession(
    cinema(203, 'East', '101 Wood Lane', '340584', 50),
    movie(1001, 'The Graduate', 1967, 'Lawrence Turman', 1),
    date(21, 3, 2020),
    time(18,35),
    90).
movieSession(
    cinema(203, 'East', '101 Wood Lane', '340584', 50),
    movie(1003, 'Singin in the Rain', 1952, 'Arthur Freed', 2),
    date(17, 3, 2020),
    time(16,55),
    100).
movieSession(
    cinema(203, 'East', '101 Wood Lane', '340584', 50),
    movie(1004, 'It is a Wonderful Life', 1946, 'Sam Spiegel', 1),
    date(18, 3, 2020),
    time(20,15),
    190).
movieSession(
    cinema(204, 'West', '29 Notting Hill', '340094', 15),
    movie(1002, 'Some Like It Hot', 1967, 'Billy Wilder', 1),
    date(21, 3, 2020),
    time(23, 20),
    55).
movieSession(
    cinema(204, 'West', '29 Notting Hill', '340094', 15),
    movie(1004, 'It is a Wonderful Life', 1946, 'Sam Spiegel', 1),
    date(15, 3, 2020),
    time(22, 40),
    210).
movieSession(
    cinema(204, 'West', '29 Notting Hill', '340094', 15),
    movie(1005, 'On the Waterfront', 1954, 'Sam Spiegel', 2),
    date(18, 3, 2020),
    time(17, 10),
    140).




/* Правила-запити */

/* 1. Телефон кінотеатру, що показує потрібний фільм
    Приклад: z01_CinemaPhone('Some Like It Hot',Phone). */
z01_CinemaPhone(Name, Phone) :- 
    movieSession(cinema(_, _, _, Phone, _), movie(_, Name, _, _, _), _, _, _).


/* 2. В яких кінотеатрах йдуть фільми заданого режисера
    Приклад: z02_CinemaWithDirector('Sam Spiegel', Name, Date, Time). */
z02_CinemaWithDirector(Director, Name, Date, Time) :- 
    movieSession(cinema(_, Name, _, _, _), movie(_, _, _, Director, _), Date, Time, _).


/* 3. Дата та місце, коли можно подивитись заданий фільм 
    Приклад: z03_MovieTimes('Singin in the Rain', CinemaName, Date, Time). */
z03_MovieTimes(Name, CinemaName, Date, Time) :- 
    movieSession(cinema(_, CinemaName, _, _, _), movie(_, Name, _, _, _), Date, Time, _).
    

/* 4. Фільми, які можна подивитись у кінотеатрах з заданою кількістю місць (місць не менше, ніж задана кількість) 
    Приклад: z04_MoviesByPlaces(30,CinemaName,Date,MovieName). */
z04_MoviesByPlaces(SeatsNumber, CinemaName, Date, MovieName) :- 
    movieSession(cinema(_, CinemaName, _, _, Seats), movie(_, MovieName, _, _, _), Date, _, _),
    Seats >= SeatsNumber.

/* 5. Ціни та час на сеанси заданого режисера 
    Приклад: z05_PricesByDirector('Lawrence Turman', MovieName, Price, Date, Time, CinemaName). */
z05_PricesByDirector(Director, MovieName, Price, Date, Time, CinemaName) :- 
    movieSession(cinema(_, CinemaName, _, _, _), movie(_, MovieName, _, Director, _), Date, Time, Price).


/* 6. Сеанси на фільми заданого року
    Приклад: z06_MoviesByYear(1967, MovieName, Date, Time, Cinema). */
z06_MoviesByYear(Year, MovieName, Date, Time, CinemaName) :- 
    movieSession(cinema(_, CinemaName, _, _, _), movie(_, MovieName, Year, _, _), Date, Time, _).



/* 7. Сеанси на задану дату у заданий кінотеатр
    Приклад: z07_SessionsByCinemaAndDate('North', date(18, 3, 2020), Movie, Time, Adress). */
z07_SessionsByCinemaAndDate(CinemaName, Date, Movie, Time, Adress) :-
    movieSession(cinema(_, CinemaName, Adress, _, _), movie(_, Movie, _, _, _), Date, Time, _).

    
    
    

