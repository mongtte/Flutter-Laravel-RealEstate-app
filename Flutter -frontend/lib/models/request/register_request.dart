import 'dart:convert';

class RegisterRequest {
  RegisterRequest({
    required this.nameLastname,
    required this.userName,
    required this.email,
    required this.password,
    required this.birthday,
    required this.gender,
    required this.address,
  });

  String nameLastname;
  String userName;
  String email;
  String password;
  String birthday;
  String gender;
  String address;

  factory RegisterRequest.fromRawJson(String str) =>
      RegisterRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      RegisterRequest(
        nameLastname: json['lastname'],
        userName: json['email'],
        email: json["email"],
        password: json["password"],
        birthday: json["birthday"],
        gender: json["gender"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "lastname": nameLastname,
        "username": email,
        "email": email,
        "password": password,
        "birthday": birthday,
        "gender": gender,
        "address": address,
      };
}
