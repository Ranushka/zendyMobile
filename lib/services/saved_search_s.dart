import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/controllers/controllers.dart';

class SavedSearcherService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController authCtrl = Get.find();

  Stream<QuerySnapshot> fetch(String userId) {
    return _firestore
        .collection("users")
        .doc(authCtrl.currentUser.value.id)
        .collection('savedSearchers')
        .snapshots();
  }

  Future<dynamic> create(dynamic contact) async {
    DocumentReference docRef = _firestore
        .collection("users")
        .doc(authCtrl.currentUser.value.id)
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
        .doc(authCtrl.currentUser.value.id)
        .collection('savedSearchers')
        .doc(contact.id);

    await docRef.update({
      "name": contact.name,
      "email": contact.email,
    });
    return contact;
  }

  Future<dynamic> delete(String id) async {
    await _firestore
        .collection("users")
        .doc(authCtrl.currentUser.value.id)
        .collection('savedSearchers')
        .doc(id)
        .delete();
  }
}
