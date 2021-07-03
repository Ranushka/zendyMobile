import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedSearcherService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> fetchContacts(String userId) {
    return _firestore
        .collection("users")
        .doc(userId.toString())
        .collection('contacts')
        .snapshots();
  }

  Future<dynamic> createNewContact(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('contacts')
        .doc();

    await docRef.set({
      "id": docRef.id,
      "name": contact.name,
      "email": contact.email,
    });
    return contact;
  }

  Future<dynamic> updateContact(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('contacts')
        .doc(contact.id);

    await docRef.update({
      "name": contact.name,
      "primaryPhone": contact.primaryPhone,
      "secondaryPhone": contact.secondaryPhone,
      "email": contact.email,
      // "photoUrl": contact?.photoUrl,
      "photoId": contact?.photoId,
    });
    return contact;
  }

  Future<dynamic> deleteContact(dynamic contact) async {
    await _firestore
        .collection("users")
        .doc(contact.userId.toString())
        .collection('contacts')
        .doc(contact.id)
        .delete();
    return contact;
  }
}
