import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:zendy/controllers/controllers.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController authCtrl = Get.find();

  CollectionReference getCollection(String collectionName) {
    var userId = authCtrl.currentUser.value.id;

    return _firestore
        .collection("users")
        .doc(userId)
        .collection(collectionName);
  }
}
