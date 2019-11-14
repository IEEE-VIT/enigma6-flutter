// To parse this JSON data, do
//
//     final answerResponse = answerResponseFromJson(jsonString);

import 'dart:convert';

AnswerResponse answerResponseFromJson(String str) => AnswerResponse.fromJson(json.decode(str));

String answerResponseToJson(AnswerResponse data) => json.encode(data.toJson());

class AnswerResponse {
    int statusCode;
    Payload payload;
    bool isAnswerCorrect;

    AnswerResponse({
        this.statusCode,
        this.payload,
        this.isAnswerCorrect,
    });

    factory AnswerResponse.fromJson(Map<String, dynamic> json) => AnswerResponse(
        statusCode: json["statusCode"],
        payload: Payload.fromJson(json["payload"]),
        isAnswerCorrect: json["isAnswerCorrect"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "payload": payload.toJson(),
        "isAnswerCorrect": isAnswerCorrect,
    };
}

class Payload {
    String msg;
    String howClose;

    Payload({
        this.msg,
        this.howClose,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        msg: json["msg"],
        howClose: json["howClose"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "howClose": howClose,
    };
}
