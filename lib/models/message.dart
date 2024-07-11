class Message {
  late String msg;
  late String toId;
  late String read;
  late Type type;
  late String send;
  late String fromId;

  Message(
      {required this.send,
      required this.read,
      required this.fromId,
      required this.msg,
      required this.toId,
      required this.type});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        send: json['send'] ?? '',
        read: json['read'] ?? '',
        fromId: json['fromId'] ?? '',
        msg: json['msg'] ?? '',
        toId: json['toId'] ?? '',
        type: json['type'].toString() == Type.image.name
            ? Type.image
            : Type.text);
  }

  Map<String, dynamic> toJson() {
    return {
      'send': send,
      'read': read,
      'fromId': fromId,
      'msg': msg,
      'toId': toId,
      'type': type.toString()
    };
  }
}

enum Type { text, image }
