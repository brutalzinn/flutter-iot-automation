import 'dart:convert';

MessagePayload messagePayloadFromJson(String str) => MessagePayload.fromJson(json.decode(str));

String messagePayloadToJson(MessagePayload data) => json.encode(data.toJson());

String messagePayloadListToJson(List<MessagePayload> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));



class MessagePayload {
    dynamic message;
    int event;
    String? lastMessage = DateTime.now().toString();
    String? sender = "iot-manager";

    MessagePayload({
        required this.message,
        required this.event,
        lastMessage,
        sender
    });


    factory MessagePayload.fromJson(Map<String, dynamic> json) => MessagePayload(
        message: json["message"],
        lastMessage: json["lastMessage"],
        sender: json["sender"],
        event: json["event"]
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "lastMessage": lastMessage,
        "sender": sender,
        "event": event
    };
}
