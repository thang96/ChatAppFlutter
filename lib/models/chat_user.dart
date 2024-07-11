class ChatUser {
  late String createdAt;
  late String id;
  late String avatar;
  late bool isOnline;
  late String lastActive;
  late String message;
  late String email;
  late String username;
  late String pushToken;

  ChatUser({
    required this.createdAt,
    required this.id,
    required this.avatar,
    required this.isOnline,
    required this.lastActive,
    required this.message,
    required this.email,
    required this.username,
    required this.pushToken,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      createdAt: json['created_at'] ?? '',
      id: json['id'] ?? '',
      avatar: json['avatar'] ?? '',
      isOnline: json['is_online'] ?? false,
      lastActive: json['last_active'] ?? '',
      message: json['message'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      pushToken: json['push_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt,
      'id': id,
      'avatar': avatar,
      'is_online': isOnline,
      'last_active': lastActive,
      'message': message,
      'email': email,
      'username': username,
      'push_token': pushToken,
    };
  }
}
