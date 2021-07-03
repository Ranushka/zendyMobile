import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedSearcherService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetch(String userId) {
    return _firestore
        .collection("users")
        .doc(userId.toString())
        .collection('savedSearchers')
        .snapshots();
  }

  Future<dynamic> create(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('savedSearchers')
        .doc();

    await docRef.set({
      "id": docRef.id,
      "keyword": contact.keyword,
      "sort": contact.sort,
      "filters": contact.filters,
    });
    return contact;
  }

  Future<dynamic> update(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('savedSearchers')
        .doc(contact.id);

    await docRef.update({
      "name": contact.name,
      "email": contact.email,
    });
    return contact;
  }

  Future<dynamic> delete(dynamic contact) async {
    await _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('savedSearchers')
        .doc(contact.id)
        .delete();
    return contact;
  }
}
