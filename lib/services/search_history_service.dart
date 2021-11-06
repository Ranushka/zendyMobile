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

  Future<dynamic> create(dynamic contact) async {
    String query = contact.query;
    CollectionReference collection =
        FirestoreService().getCollection('searchHistory');

    var queryData =
        await collection.where('query', isEqualTo: query).limit(1).get();

    if (queryData.size == 0) {
      await collection.add({
        'query': contact.query,
        'createdAt': Timestamp.now(),
      });
    }

    return contact;
  }

  Future<dynamic> update(dynamic contact) async {
    DocumentReference docRef =
        FirestoreService().getCollection('searchHistory').doc(contact.id);

    await docRef.update({"query": contact.query});
    return contact;
  }

  Future<dynamic> delete(dynamic contact) async {
    await FirestoreService()
        .getCollection('searchHistory')
        .doc(contact.id)
        .delete();

    return contact;
  }
}
