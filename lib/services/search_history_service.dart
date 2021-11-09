import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/services/services.dart';

class SearchHistoryService {
  Stream<QuerySnapshot> fetchdata() {
    return FirestoreService()
        .getCollection('searchHistory')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<dynamic> create(dynamic data) async {
    CollectionReference collection =
        FirestoreService().getCollection('searchHistory');

    var queryData =
        await collection.where('query', isEqualTo: data).limit(1).get();

    if (queryData.size == 0) {
      await collection.add({
        'query': data,
        'createdAt': Timestamp.now(),
      });
    }

    return data;
  }

  Future<dynamic> update(dynamic data) async {
    DocumentReference docRef =
        FirestoreService().getCollection('searchHistory').doc(data.id);

    await docRef.update({"query": data.query});
    return data;
  }

  Future<dynamic> delete(id) async {
    await FirestoreService().getCollection('searchHistory').doc(id).delete();
  }
}
