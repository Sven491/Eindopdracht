// ignore_for_file: file_names

import 'dart:convert';

TmdbDiscover tmdbDiscoverFromJson(String str) => TmdbDiscover.fromJson(json.decode(str));

String tmdbDiscoverToJson(TmdbDiscover data) => json.encode(data.toJson());

class TmdbDiscover {
    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    TmdbDiscover({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory TmdbDiscover.fromJson(Map<String, dynamic> json) => TmdbDiscover(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Result {
    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    String originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String? posterPath;
    DateTime releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    Result({
        required this.adult,
        required this.backdropPath,
        this.genreIds = const [],
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"] ?? []),
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: (json["release_date"] != null && json["release_date"] != "")? DateTime.parse(json["release_date"]): DateTime(1900),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
