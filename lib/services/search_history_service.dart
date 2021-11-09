import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/services/services.dart';

class SearchHistoryService {
  Stream<QuerySnapshot> fetchdata(String userId) {
    return FirestoreService()
        .getCollection('searchHistory')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<dynamic> create(dynamic data) async {
    String query = data['query'];
    CollectionReference collection =
        FirestoreService().getCollection('searchHistory');

    var queryData =
        await collection.where('query', isEqualTo: query).limit(1).get();

    if (queryData.size == 0) {
      await collection.add({
        'query': query,
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

  Future<dynamic> delete(dynamic data) async {
    await FirestoreService()
        .getCollection('searchHistory')
        .doc(data.id)
        .delete();

    return data;
  }
}
