// To parse this JSON data, do
//
//     final leaderboard = leaderboardFromJson(jsonString);

import 'dart:convert';

Leaderboard leaderboardFromJson(String str) => Leaderboard.fromJson(json.decode(str));

String leaderboardToJson(Leaderboard data) => json.encode(data.toJson());

class Leaderboard {
    int statusCode;
    Payload payload;

    Leaderboard({
        this.statusCode,
        this.payload,
    });

    factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        statusCode: json["statusCode"],
        payload: Payload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "payload": payload.toJson(),
    };
}

class Payload {
    List<CurPlayer> leaderBoard;
    CurPlayer curPlayer;

    Payload({
        this.leaderBoard,
        this.curPlayer,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        leaderBoard: List<CurPlayer>.from(json["leaderBoard"].map((x) => CurPlayer.fromJson(x))),
        curPlayer: CurPlayer.fromJson(json["curPlayer"]),
    );

    Map<String, dynamic> toJson() => {
        "leaderBoard": List<dynamic>.from(leaderBoard.map((x) => x.toJson())),
        "curPlayer": curPlayer.toJson(),
    };
}

class CurPlayer {
    String name;
    int points;
    int rank;
    int level;

    CurPlayer({
        this.name,
        this.points,
        this.rank,
        this.level,
    });

    factory CurPlayer.fromJson(Map<String, dynamic> json) => CurPlayer(
        name: json["name"],
        points: json["points"],
        rank: json["rank"],
        level: json["level"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "points": points,
        "rank": rank,
        "level": level,
    };
}
