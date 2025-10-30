import 'dart:convert';

Watchlist watchlistFromJson(String str) => Watchlist.fromJson(json.decode(str));

String watchlistToJson(Watchlist data) => json.encode(data.toJson());

class Watchlist {
    int? id;
    String userId;
    String movieId;
    DateTime createdAt;

    Watchlist({
        this.id,
        required this.userId,
        required this.movieId,
        required this.createdAt,
    });

    factory Watchlist.fromJson(Map<String, dynamic> json) => Watchlist(
        id: json["id"],
        userId: json["user_id"],
        movieId: json["movie_id"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "movie_id": movieId,
        "created_at": createdAt.toIso8601String(),
    };
}
