import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/services/services.dart';

class SavedCitationsService {
  Stream<QuerySnapshot> fetchdata(String userId) {
    return FirestoreService().getCollection('savedCitations').snapshots();
  }

  Future<dynamic> create(dynamic data) async {
    DocumentReference docRef =
        FirestoreService().getCollection('savedCitations').doc();

    await docRef.set(data);

    return data;
  }

  Future<dynamic> update(dynamic data) async {
    DocumentReference docRef =
        FirestoreService().getCollection('savedCitations').doc(data.id);

    await docRef.update({"query": data.query});
    return data;
  }

  Future<dynamic> delete(String id) async {
    await FirestoreService().getCollection('savedCitations').doc(id).delete();
  }
}
