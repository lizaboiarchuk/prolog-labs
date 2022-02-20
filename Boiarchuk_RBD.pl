/* Факти про фільми */
movie(1001, 'The Graduate', 1967, 'Lawrence Turman', 1).
movie(1002, 'Some Like It Hot', 1967, 'Billy Wilder', 1).
movie(1003, 'Singin in the Rain', 1952, 'Arthur Freed', 2).
movie(1004, 'It is a Wonderful Life', 1946, 'Sam Spiegel', 1).
movie(1005, 'On the Waterfront', 1954, 'Sam Spiegel', 2).

/* Факти про кінотеатри */
cinema(201, 'South', '191 Portobello Road', '340576', 30).
cinema(202, 'North', '2 Television Centre', '340364', 20).
cinema(203, 'East', '101 Wood Lane', '340584', 50).
cinema(204, 'West', '29 Notting Hill', '340094', 15).

/* Факти про кіно-сеанси */
movieSession(201, 1001, '19.03.2020', '20:20', 150).
movieSession(201, 1002, '18.03.2020', '19:40', 120).
movieSession(201, 1003, '20.03.2020', '20:20', 180).
movieSession(202, 1001, '18.03.2020', '18:20', 90).
movieSession(202, 1002, '18.03.2020', '16:40', 100).
movieSession(202, 1004, '19.03.2020', '19:10', 190).
movieSession(202, 1005, '18.03.2020', '21:20', 135).
movieSession(203, 1001, '21.03.2020', '18:35', 90).
movieSession(203, 1003, '17.03.2020', '16:55', 100).
movieSession(203, 1004, '18.03.2020', '20:15', 190).
movieSession(204, 1002, '21.03.2020', '23:20', 55).
movieSession(204, 1004, '15.03.2020', '22:40', 210).
movieSession(204, 1005, '18.03.2020', '17:10', 140).



/* Правила-запити */

/* 1. Телефон кінотеатру, що показує потрібний фільм
    Приклад: z01_cinema_phone('Some Like It Hot', Phone). */
z01_CinemaPhone(Name, Phone) :- 
    movie(MovieCode, Name, _, _, _), 
    movieSession(CinemaId, MovieCode, _, _, _), 
    cinema(CinemaId, _, _, Phone, _).


/* 2. В яких кінотеатрах йдуть фільми заданого режисера
    Приклад: z02_CinemaWithDirector('Sam Spiegel', Name, Date). */
z02_CinemaWithDirector(Director, Name, Date) :- 
    movie(MovieCode, _, _, Director, _), 
    movieSession(CinemaId, MovieCode, Date, _, _), 
    cinema(CinemaId, Name, _, _, _).


/* 3. Дата та місце, коли можно подивитись заданий фільм 
    Приклад: z03_MovieTimes('Singin in the Rain', CinemaName, Date, Time). */
z03_MovieTimes(Name, CinemaName, Date, Time) :- 
    movie(MovieCode, Name, _, _, _), 
    movieSession(CinemaId, MovieCode, Date, Time, _),
    cinema(CinemaId, CinemaName, _, _, _).


/* 4. Фільми, які можна подивитись у кінотеатрах з заданою кількістю місць (місць не менше, ніж задана кількість) 
    Приклад: z04_MovieByPlaces(30, CinemaName, Date, MovieName). */
z04_MoviesByPlaces(SeatsNumber, CinemaName, Date, MovieName) :- 
    cinema(CinemaId, CinemaName, _, _, Seats),
    Seats >= SeatsNumber, 
    movieSession(CinemaId, MovieId, Date, _, _),
    movie(MovieId, MovieName, _, _, _).


/* 5. Ціни та час на сеанси заданого режисера 
    Приклад: z05_PricesByDirector('Lawrence Turman', MovieName, Price, Date, Time, CinemaName). */
z05_PricesByDirector(Director, MovieName, Price, Date, Time, CinemaName) :- 
    movie(MovieCode, MovieName, _, Director, _),
    movieSession(CinemaId, MovieCode, Date, Time, Price),
    cinema(CinemaId, CinemaName, _, _, _). 


/* 6. Сеанси на фільми заданого року
    Приклад: z06_MoviesByYear(1967, MovieName, Date, Time, Cinema). */
z06_MoviesByYear(Year, MovieName, Date, Time, CinemaName) :- 
    movie(MovieCode, MovieName, MovieYear, _, _),
    Year == MovieYear,
    movieSession(CinemaId, MovieCode, Date, Time, _),
    cinema(CinemaId, CinemaName, _, _, _).
    

/* 7. Сеанси на задану дату у заданий кінотеатр
    Приклад: z07_SessionsByCinemaAndDate('North', '18.03.2020', Movie, Time, Adress). */
z07_SessionsByCinemaAndDate(CinemaName, Date, Movie, Time, Adress) :- 
    movieSession(CinemaId, MovieId, Date, Time, _),
    cinema(CinemaId, CinemaName, Adress, _, _),
    movie(MovieId, Movie, _, _, _).




