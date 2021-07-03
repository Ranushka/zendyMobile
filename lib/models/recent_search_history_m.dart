import 'package:cloud_firestore/cloud_firestore.dart';

class RecentSearchHistoryModelData {
  List<SearchHistoryModel> searchHistory;

  RecentSearchHistoryModelData({this.searchHistory});

  RecentSearchHistoryModelData.fromJson(Map<String, dynamic> json) {
    if (json['searchHistory'] != null) {
      // searchHistory = new List<SearchHistoryModel>();
      searchHistory = new List<SearchHistoryModel>.empty(growable: true);

      json['searchHistory'].forEach((v) {
        searchHistory.add(new SearchHistoryModel.fromJson(v));
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

class SearchHistoryModel {
  String id;
  String userId;
  String query;

  SearchHistoryModel({
    this.id,
    this.userId,
    this.query,
  });

  SearchHistoryModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot["id"] ?? '';
    query = documentSnapshot["query"] ?? '';
  }

  SearchHistoryModel.fromQueryDocumentSnapshot(
      {QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot;
    // print(data.data());
    // id = data["id"] ?? '';
    query = data["query"] ?? '';
  }

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    query = json['query'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['query'] = this.query;
    return data;
  }
}
