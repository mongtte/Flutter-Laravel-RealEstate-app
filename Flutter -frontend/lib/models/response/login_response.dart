import 'dart:convert';

class LoginResponse {

  LoginResponse({
    required this.token, this.name = '',
  });

  String name;
  String token;

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["jwt"],
        name: json ['user']['name'] 
      );

  Map<String, dynamic> toJson() => {
        "jwt": token,
      };
}
