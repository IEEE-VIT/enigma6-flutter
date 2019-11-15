// To parse this JSON data, do
//
//     final hintResponse = hintResponseFromJson(jsonString);

import 'dart:convert';

HintResponse hintResponseFromJson(String str) => HintResponse.fromJson(json.decode(str));

String hintResponseToJson(HintResponse data) => json.encode(data.toJson());

class HintResponse {
    int statusCode;
    Payload payload;
    bool wasHintUsed;

    HintResponse({
        this.statusCode,
        this.payload,
        this.wasHintUsed,
    });

    factory HintResponse.fromJson(Map<String, dynamic> json) => HintResponse(
        statusCode: json["statusCode"],
        payload: Payload.fromJson(json["payload"]),
        wasHintUsed: json["wasHintUsed"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "payload": payload.toJson(),
        "wasHintUsed": wasHintUsed,
    };
}

class Payload {
    String hint;

    Payload({
        this.hint,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        hint: json["hint"],
    );

    Map<String, dynamic> toJson() => {
        "hint": hint,
    };
}
