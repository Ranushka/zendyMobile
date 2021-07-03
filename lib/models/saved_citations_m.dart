import 'package:cloud_firestore/cloud_firestore.dart';

class SavedCitationsModelData {
  List<SavedCitationsModel> savedCitations;

  SavedCitationsModelData({this.savedCitations});

  SavedCitationsModelData.fromJson(Map<String, dynamic> json) {
    if (json['savedCitations'] != null) {
      savedCitations = new List<SavedCitationsModel>.empty(growable: true);

      json['savedCitations'].forEach((v) {
        savedCitations.add(new SavedCitationsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.savedCitations != null) {
      data['savedCitations'] =
          this.savedCitations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SavedCitationsModel {
  String id;
  String userId;
  String title;
  String sourceUrl;

  SavedCitationsModel({
    this.id,
    this.userId,
    this.title,
    this.sourceUrl,
  });

  SavedCitationsModel.fromDocumentSnapshot(
      {DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot["id"] ?? '';
    title = documentSnapshot["title"] ?? '';
    sourceUrl = documentSnapshot["sourceUrl"] ?? '';
  }

  SavedCitationsModel.fromQueryDocumentSnapshot(
      {QueryDocumentSnapshot queryDocSnapshot}) {
    var data = queryDocSnapshot;
    // print(data.data());
    id = data["id"] ?? '';
    title = data["title"] ?? '';
    sourceUrl = data["sourceUrl"] ?? '';
  }

  SavedCitationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    sourceUrl = json['sourceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sourceUrl'] = this.sourceUrl;
    return data;
  }
}
