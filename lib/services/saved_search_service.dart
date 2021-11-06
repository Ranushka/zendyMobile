import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy_app/controllers/controllers.dart';
import 'package:zendy_app/services/services.dart';

class SavedSearcherService {
  final AuthController authCtrl = Get.find();

  Stream<QuerySnapshot> fetch() {
    return FirestoreService().getCollection('savedSearchers').snapshots();
  }

  Future<dynamic> create(dynamic contact) async {
    DocumentReference docRef =
        FirestoreService().getCollection('savedSearchers').doc();

    await docRef.set({
      "id": docRef.id,
      "keyword": contact.keyword,
      "sort": contact.sort,
      "filters": contact.filters,
    });

    return contact;
  }

  Future<dynamic> delete(String id) async {
    await FirestoreService().getCollection('savedSearchers').doc(id).delete();
  }
}
