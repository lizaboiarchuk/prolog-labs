filmed( movie(name0, director0, 2000, summary0), actor("Name0 Surname0", rank0, 1960, workplace0), role0, description0).
filmed( movie(name1, director1, 2001, summary1), actor("Name1 Surname1", rank1, 1961, workplace1), role1, description1).
filmed( movie(name2, director2, 2002, summary2), actor("Name2 Surname2", rank2, 1962, workplace2), role2, description2).
filmed( movie(name3, director3, 2003, summary3), actor("Name3 Surname3", rank3, 1963, workplace3), role3, description3).
filmed( movie(name4, director4, 2004, summary4), actor("Name4 Surname4", rank4, 1964, workplace4), role4, description4).
filmed( movie(name5, director5, 2005, summary5), actor("Name5 Surname5", rank5, 1965, workplace5), role5, description5).
filmed( movie(name6, director6, 2006, summary6), actor("Name6 Surname6", rank6, 1966, workplace6), role6, description6).
filmed( movie(name7, director7, 2007, summary7), actor("Name7 Surname7", rank7, 1967, workplace7), role7, description7).
filmed( movie(name8, director8, 2008, summary8), actor("Name8 Surname8", rank8, 1968, workplace8), role8, description8).
filmed( movie(name9, director9, 2009, summary9), actor("Name9 Surname9", rank9, 1969, workplace9), role9, description9).
filmed( movie(name10, director10, 2010, summary10), actor("Name10 Surname10", rank10, 1970, workplace10), role10, description10).



z01_FilmName(Name, FilmName) :-
    filmed( movie(FilmName, _, _, _), actor(Name, _, _, _), _, _).

z02_ActorsAge(Film, ActorName, ActorAge) :-
    filmed( movie(Film, _, _, _), actor(ActorName, _, ActorAge, _), _, _).

z03_ActorFilmRole(Film, Role, Actor) :-
    filmed( movie(Film, _, _, _), actor(Actor, _, _, _), Role, _).

z04_DirectorActors(Director, ActorName) :-
    filmed( movie(_, Director, _, _), actor(ActorName, _, _, _), _, _).

z05_ActorFilmRank(Film, Rank) :-
    filmed( movie(Film, _, _, _), actor(_, Rank, _, _), _, _).

z06_FilmNameFromSummary(Summary, FilmName) :-
    filmed( movie(FilmName, _, _, Summary), actor(_, _, _, _), _, _).

z07_WorkPlaceOfActor(ActorName, Workplace) :-
    filmed( movie(_, _, _, _), actor(ActorName, _, _, Workplace), _, _).
















