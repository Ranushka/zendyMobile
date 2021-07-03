import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedCitationsService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchdata(String userId) {
    return _firestore
        .collection("users")
        .doc(userId.toString())
        .collection('savedCitations')
        .snapshots();
  }

  Future<dynamic> create(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('savedCitations')
        .doc();

    await docRef.set({
      "id": contact.id,
      "title": contact.title,
      'sourceUrl': contact.sourceUrl,
    });

    return contact;
  }

  Future<dynamic> update(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('savedCitations')
        .doc(contact.id);

    await docRef.update({"query": contact.query});
    return contact;
  }

  Future<dynamic> delete(dynamic contact) async {
    await _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('savedCitations')
        .doc(contact.id)
        .delete();
    return contact;
  }
}
