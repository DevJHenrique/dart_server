import 'dart:convert';

class UserAuthModel {
  int? userId;
  String? username;
  String? role;
  String? token;
  String? error;
  UserAuthModel({
    this.userId,
    this.username,
    this.role,
    this.token,
    this.error,
  });

  UserAuthModel copyWith({
    int? userId,
    String? username,
    String? role,
    String? token,
    String? error,
  }) {
    return UserAuthModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      role: role ?? this.role,
      token: token ?? this.token,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'role': role,
      'token': token,
      'error': error,
    };
  }

  factory UserAuthModel.fromMap(Map<String, dynamic> map) {
    return UserAuthModel(
      userId: map['user_id'],
      username: map['user_name'],
      role: map['role'],
      token: map['token'],
      error: map['error'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuthModel.fromJson(String source) =>
      UserAuthModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserAuthModel(userId: $userId, username: $username, role: $role, token: $token, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAuthModel &&
        other.userId == userId &&
        other.username == username &&
        other.role == role &&
        other.token == token &&
        other.error == error;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        username.hashCode ^
        role.hashCode ^
        token.hashCode ^
        error.hashCode;
  }
}
