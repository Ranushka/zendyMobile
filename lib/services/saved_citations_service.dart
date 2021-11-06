import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zendy_app/services/services.dart';

class SavedCitationsService {
  Stream<QuerySnapshot> fetchdata(String userId) {
    return FirestoreService().getCollection('savedCitations').snapshots();
  }

  Future<dynamic> create(dynamic contact) async {
    DocumentReference docRef =
        FirestoreService().getCollection('savedCitations').doc();

    await docRef.set(contact);

    return contact;
  }

  Future<dynamic> update(dynamic contact) async {
    DocumentReference docRef =
        FirestoreService().getCollection('savedCitations').doc(contact.id);

    await docRef.update({"query": contact.query});
    return contact;
  }

  Future<dynamic> delete(dynamic contact) async {
    await FirestoreService()
        .getCollection('savedCitations')
        .doc(contact.id)
        .delete();
    return contact;
  }
}
