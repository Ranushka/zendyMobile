// To parse this JSON data, do
//
//     final recentSearchModel = recentSearchModelFromJson(jsonString);

import 'dart:convert';

List<RecentSearchModel> recentSearchModelFromJson(String str) =>
    List<RecentSearchModel>.from(json.decode(str).map(
          (x) => RecentSearchModel.fromJson(x),
        ));

String recentSearchModelToJson(List<RecentSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentSearchModel {
  RecentSearchModel({
    this.type,
    this.id,
    this.title,
  });

  String type;
  int id;
  String title;

  factory RecentSearchModel.fromJson(Map<String, dynamic> json) =>
      RecentSearchModel(
        type: json["type"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "title": title,
      };
}
