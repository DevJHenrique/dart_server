import 'dart:convert';

class AuthRequest {
  final String username;
  final String password;

  AuthRequest({
    required this.username,
    required this.password,
  });

  AuthRequest copyWith({
    String? username,
    String? password,
  }) {
    return AuthRequest(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory AuthRequest.fromMap(Map<String, dynamic> map) {
    return AuthRequest(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequest.fromJson(String source) =>
      AuthRequest.fromMap(json.decode(source));

  @override
  String toString() => 'AuthRequest(username: $username, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthRequest &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
