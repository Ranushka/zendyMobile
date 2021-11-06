import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/controllers/controllers.dart';

class SavedSearcherService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController authCtrl = Get.find();

  CollectionReference getCollection(String collectionName) {
    var userId = authCtrl.currentUser.value.id;

    return _firestore
        .collection("users")
        .doc(userId)
        .collection(collectionName);
  }

  Stream<QuerySnapshot> fetch() {
    return getCollection('savedSearchers').snapshots();
  }

  Future<dynamic> create(dynamic contact) async {
    DocumentReference docRef = getCollection('savedSearchers').doc();

    await docRef.set({
      "id": docRef.id,
      "keyword": contact.keyword,
      "sort": contact.sort,
      "filters": contact.filters,
    });

    return contact;
  }

  Future<dynamic> delete(String id) async {
    await getCollection('savedSearchers').doc(id).delete();
  }
}
