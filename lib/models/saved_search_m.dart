import 'package:cloud_firestore/cloud_firestore.dart';

class SavedSearchModelData {
  List<SavedSearchModel> searchHistory;

  SavedSearchModelData({this.searchHistory});

  SavedSearchModelData.fromJson(Map<String, dynamic> json) {
    if (json['searchHistory'] != null) {
      searchHistory = new List<SavedSearchModel>.empty(growable: true);

      json['searchHistory'].forEach((v) {
        searchHistory.add(new SavedSearchModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchHistory != null) {
      data['searchHistory'] =
          this.searchHistory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SavedSearchModel {
  String userId;
  String id;
  String filters;
  String keyword;
  String sort;

  SavedSearchModel({
    this.userId,
    this.id,
    this.filters,
    this.keyword,
    this.sort,
  });

  SavedSearchModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot["id"] ?? '';
    keyword = documentSnapshot["keyword"] ?? '';
    filters = documentSnapshot["filters"] ?? '';
    sort = documentSnapshot["sort"] ?? '';
  }

  SavedSearchModel.fromQueryDocumentSnapshot(
      {QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot;

    id = data["id"] ?? '';
    filters = data["filters"] ?? '';
    keyword = data["keyword"] ?? '';
    sort = data["sort"] ?? '';
  }

  SavedSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyword'] = this.keyword;
    return data;
  }
}
