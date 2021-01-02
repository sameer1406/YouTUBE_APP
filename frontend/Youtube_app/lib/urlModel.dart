// To parse this JSON data, do
//
//     final urlModel = urlModelFromJson(jsonString);

import 'dart:convert';

UrlModel urlModelFromJson(String str) => UrlModel.fromJson(json.decode(str));

String urlModelToJson(UrlModel data) => json.encode(data.toJson());

class UrlModel {
  UrlModel({
    this.data,
    this.info,
    this.thumbnail,
    this.title,
    this.views,
  });

  String data;
  List<dynamic> info;
  String thumbnail;
  String title;
  int views;

  factory UrlModel.fromJson(Map<String, dynamic> json) => UrlModel(
        data: json["Data"],
        info: List<dynamic>.from(json["info"].map((x) => x)),
        thumbnail: json["thumbnail"],
        title: json["title"],
        views: json["views"],
      );

  Map<String, dynamic> toJson() => {
        "Data": data,
        "info": List<dynamic>.from(info.map((x) => x)),
        "thumbnail": thumbnail,
        "title": title,
        "views": views,
      };
}
