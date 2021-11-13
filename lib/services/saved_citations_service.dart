import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/services/services.dart';

final colName = 'savedPublications';

class SavedCitationsService {
  Stream<QuerySnapshot> fetchdata(String userId) {
    return FirestoreService().getCollection(colName).snapshots();
  }

  Future<dynamic> create(dynamic data) async {
    DocumentReference docRef = FirestoreService().getCollection(colName).doc();

    await docRef.set(data);

    return data;
  }

  Future<dynamic> update(dynamic data) async {
    DocumentReference docRef =
        FirestoreService().getCollection(colName).doc(data.id);

    await docRef.update({"query": data.query});
    return data;
  }

  Future<dynamic> delete(String id) async {
    await FirestoreService().getCollection(colName).doc(id).delete();
  }
}
