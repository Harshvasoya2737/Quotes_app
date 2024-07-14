// To parse this JSON data, do
//
//     final quoteModel = quoteModelFromJson(jsonString);

import 'dart:convert';

List<QuoteModel> quoteModelFromJson(String str) => List<QuoteModel>.from(json.decode(str).map((x) => QuoteModel.fromJson(x)));

String quoteModelToJson(List<QuoteModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuoteModel {
  List<String>? categories;
  List<String>? images;
  List<String>? bgImages;
  List<String>? love;
  List<String>? calm;
  List<String>? sad;
  List<String>? time;
  List<String>? future;
  List<String>? relationship;

  QuoteModel({
    this.categories,
    this.images,
    this.bgImages,
    this.love,
    this.calm,
    this.sad,
    this.time,
    this.future,
    this.relationship,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
    categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    bgImages: json["bg_images"] == null ? [] : List<String>.from(json["bg_images"]!.map((x) => x)),
    love: json["Love"] == null ? [] : List<String>.from(json["Love"]!.map((x) => x)),
    calm: json["Calm"] == null ? [] : List<String>.from(json["Calm"]!.map((x) => x)),
    sad: json["Sad"] == null ? [] : List<String>.from(json["Sad"]!.map((x) => x)),
    time: json["Time"] == null ? [] : List<String>.from(json["Time"]!.map((x) => x)),
    future: json["Future"] == null ? [] : List<String>.from(json["Future"]!.map((x) => x)),
    relationship: json["Relationship"] == null ? [] : List<String>.from(json["Relationship"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "bg_images": bgImages == null ? [] : List<dynamic>.from(bgImages!.map((x) => x)),
    "Love": love == null ? [] : List<dynamic>.from(love!.map((x) => x)),
    "Calm": calm == null ? [] : List<dynamic>.from(calm!.map((x) => x)),
    "Sad": sad == null ? [] : List<dynamic>.from(sad!.map((x) => x)),
    "Time": time == null ? [] : List<dynamic>.from(time!.map((x) => x)),
    "Future": future == null ? [] : List<dynamic>.from(future!.map((x) => x)),
    "Relationship": relationship == null ? [] : List<dynamic>.from(relationship!.map((x) => x)),
  };
}