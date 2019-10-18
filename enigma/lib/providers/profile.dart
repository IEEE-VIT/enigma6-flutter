// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    int statusCode;
    Payload payload;

    Profile({
        this.statusCode,
        this.payload,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        statusCode: json["statusCode"],
        payload: Payload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "payload": payload.toJson(),
    };
}

class Payload {
    User user;
    dynamic errorMsg;

    Payload({
        this.user,
        this.errorMsg,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        user: User.fromJson(json["user"]),
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "errorMsg": errorMsg,
    };
}

class User {
    String name;
    String email;
    int points;
    int level;
    List<bool> usedHint;
    int rank;

    User({
        this.name,
        this.email,
        this.points,
        this.level,
        this.usedHint,
        this.rank,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        points: json["points"],
        level: json["level"],
        usedHint: List<bool>.from(json["usedHint"].map((x) => x)),
        rank: json["rank"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "points": points,
        "level": level,
        "usedHint": List<dynamic>.from(usedHint.map((x) => x)),
        "rank": rank,
    };
}
