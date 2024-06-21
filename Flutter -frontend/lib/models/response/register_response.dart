import 'dart:convert';

class RegisterResponse {
  RegisterResponse({
    required this.token,
  });

  String name = "";
  String email = "";
  String token;

  factory RegisterResponse.fromRawJson(String str) =>
      RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        token: json["jwt"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "token": token,
      };
}
