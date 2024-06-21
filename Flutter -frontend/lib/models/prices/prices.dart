


import 'dart:convert';

Prices pricesFromJson(String str) => Prices.fromJson(json.decode(str));

//String pricesToJson(Prices data) => json.encode(data.toJson());


class Prices {
  Prices({
     this.id,
     this.firstOptionDays,
     this.firstOptionPrice,
     this.firstOptionDuration,
     this.secondOptionDays,
     this.secondOptionPrice,
     this.secondOptionDuration,
     this.thirdOptionDays,
     this.thirdOptionPrice,
     this.thirdOptionDuration
  });

 int? id;
 int? firstOptionDays;
 int? firstOptionPrice;
 int? firstOptionDuration;
 int? secondOptionDays;
 int? secondOptionPrice;
 int? secondOptionDuration;
 int? thirdOptionDays;
 int? thirdOptionPrice;
 int? thirdOptionDuration;

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        id: json["id"],
        firstOptionDays: json["firstOptionDays"],
        firstOptionPrice: json["firstOptionPrice"],
        firstOptionDuration: json["firstOptionDuration"],
        secondOptionDays: json["secondOptionDays"],
        secondOptionPrice: json["secondOptionPrice"],
        secondOptionDuration: json["secondOptionDuration"],
        thirdOptionDays: json["thirdOptionDays"],
        thirdOptionPrice: json["thirdOptionPrice"],
        thirdOptionDuration: json["thirdOptionDuration"],
      );

  static List<Prices> fromListJson(List<dynamic> listPost) {
    List<Prices> prices = [];
    for (var item in listPost) {
      prices.add(Prices.fromJson(item));
    }
    return prices;
  }
}