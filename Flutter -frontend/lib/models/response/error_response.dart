import 'dart:convert';

class ErrorResponse {
  ErrorResponse({
    required this.error,
  });

  String error;

  factory ErrorResponse.fromRawJson(String str) =>
      ErrorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(error: getError(json));
  
  Map<String, dynamic> toJson() => {
        "error": error,
      };

  static String getError(Map<String, dynamic> json) {
    if(json["data"] != null && json["data"][0]["messages"] != null){
      return json["data"][0]["messages"][0]["message"];
    }else if(json["message"] != null && json["message"][0]["messages"] != null){
      return json["data"][0]["messages"][0]["message"];
    }else{
      return json["error"];
    }
  }
}
