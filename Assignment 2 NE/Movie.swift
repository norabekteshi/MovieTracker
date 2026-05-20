//
//  Movie.swift
//  MovieTracker
//
//  Hardcoded sample data — no network / API key required.
//

import Foundation

struct Movie {
    let title: String
    let year: String
    let rating: String
}

struct MovieSection {
    let title: String
    let movies: [Movie]
}

/// Static catalogue used by HomeViewController's collection views.
enum MovieData {
    static let sections: [MovieSection] = [
        MovieSection(title: "Trending Now", movies: [
            Movie(title: "Oppenheimer",      year: "2023", rating: "8.4"),
            Movie(title: "Dune: Part Two",   year: "2024", rating: "8.6"),
            Movie(title: "Poor Things",      year: "2023", rating: "8.0"),
            Movie(title: "The Batman",       year: "2022", rating: "7.8"),
            Movie(title: "Barbie",           year: "2023", rating: "6.8")
        ]),
        MovieSection(title: "Action", movies: [
            Movie(title: "John Wick 4",       year: "2023", rating: "7.7"),
            Movie(title: "Mad Max: Fury Road",year: "2015", rating: "8.1"),
            Movie(title: "Top Gun: Maverick", year: "2022", rating: "8.2"),
            Movie(title: "Mission: Impossible",year: "2023", rating: "7.7"),
            Movie(title: "Gladiator",         year: "2000", rating: "8.5")
        ]),
        MovieSection(title: "Sci-Fi", movies: [
            Movie(title: "Interstellar",       year: "2014", rating: "8.7"),
            Movie(title: "Inception",          year: "2010", rating: "8.8"),
            Movie(title: "Blade Runner 2049",  year: "2017", rating: "8.0"),
            Movie(title: "Arrival",            year: "2016", rating: "7.9"),
            Movie(title: "The Matrix",         year: "1999", rating: "8.7")
        ]),
        MovieSection(title: "Drama", movies: [
            Movie(title: "Parasite",     year: "2019", rating: "8.5"),
            Movie(title: "Whiplash",     year: "2014", rating: "8.5"),
            Movie(title: "Fight Club",   year: "1999", rating: "8.8"),
            Movie(title: "Forrest Gump", year: "1994", rating: "8.8"),
            Movie(title: "Joker",        year: "2019", rating: "8.4")
        ])
    ]
}
