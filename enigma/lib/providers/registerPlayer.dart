// To parse this JSON data, do
//
//     final registerPlayer = registerPlayerFromJson(jsonString);

import 'dart:convert';

RegisterPlayer registerPlayerFromJson(String str) => RegisterPlayer.fromJson(json.decode(str));

String registerPlayerToJson(RegisterPlayer data) => json.encode(data.toJson());

class RegisterPlayer {
    int statusCode;
    Payload payload;
    bool wasUserRegistered;
    bool isRegSuccess;

    RegisterPlayer({
        this.statusCode,
        this.payload,
        this.wasUserRegistered,
        this.isRegSuccess,
    });

    factory RegisterPlayer.fromJson(Map<String, dynamic> json) => RegisterPlayer(
        statusCode: json["statusCode"],
        payload: Payload.fromJson(json["payload"]),
        wasUserRegistered: json["wasUserRegistered"],
        isRegSuccess: json["isRegSuccess"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "payload": payload.toJson(),
        "wasUserRegistered": wasUserRegistered,
        "isRegSuccess": isRegSuccess,
    };
}

class Payload {
    String msg;
    String errorMsg;

    Payload({
        this.msg,
        this.errorMsg,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        msg: json["msg"],
        errorMsg: json["errorMsg"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "errorMsg": errorMsg,
    };
}
