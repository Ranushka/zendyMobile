import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoryService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchdata(String userId) {
    return _firestore
        .collection("users")
        .doc(userId.toString())
        .collection('searchHistory')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<dynamic> create(dynamic contact) async {
    String userId = contact.userId.toString();
    String query = contact.query;
    DocumentReference docRefUsers = _firestore.collection("users").doc(userId);
    CollectionReference colRefSearch = docRefUsers.collection('searchHistory');

    var queryData =
        await colRefSearch.where('query', isEqualTo: query).limit(1).get();

    if (queryData.size == 0) {
      await colRefSearch.add({
        'query': contact.query,
        'createdAt': Timestamp.now(),
      });
    }

    return contact;
  }

  Future<dynamic> update(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('searchHistory')
        .doc(contact.id);

    await docRef.update({"query": contact.query});
    return contact;
  }

  Future<dynamic> delete(dynamic contact) async {
    await _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('searchHistory')
        .doc(contact.id)
        .delete();
    return contact;
  }
}
