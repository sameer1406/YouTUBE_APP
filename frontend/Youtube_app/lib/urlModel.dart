// To parse this JSON data, do
//
//     final urlModel = urlModelFromJson(jsonString);

import 'dart:convert';

UrlModel urlModelFromJson(String str) => UrlModel.fromJson(json.decode(str));

String urlModelToJson(UrlModel data) => json.encode(data.toJson());

class UrlModel {
  UrlModel({
    this.data,
    this.thumbnail,
    this.title,
    this.views,
  });

  String data;

  String thumbnail;
  String title;
  int views;

  factory UrlModel.fromJson(Map<String, dynamic> json) => UrlModel(
        data: json["Data"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        views: json["views"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data,
        "thumbnail": thumbnail,
        "title": title,
        "views": views,
      };
}
