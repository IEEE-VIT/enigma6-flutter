// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
    int statusCode;
    Payload payload;

    Question({
        this.statusCode,
        this.payload,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        statusCode: json["statusCode"],
        payload: Payload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "payload": payload.toJson(),
    };
}

class Payload {
    String question;
    String imgUrl;
    int level;

    Payload({
        this.question,
        this.imgUrl,
        this.level,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        question: json["question"],
        imgUrl: json["imgURL"],
        level: json["level"]
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "imgURL": imgUrl,
        "level": level
    };
}
