import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/app/data/secure_storage.dart';
import 'package:noteapp/app/models/model.dart';
import 'package:noteapp/app/routes/app_pages.dart';

import '../../../widgets/widget_add_or_update.dart';

class HomeController extends GetxController {
  final nameController = TextEditingController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final secureStorage = SecureStorage();

  final name = ''.obs;
  final uid = ''.obs;
  DateTime? currentBackPressTime;
  RxList<CollectionModel> collections = RxList<CollectionModel>([]);

  @override
  void onInit() {
    getUserLogin();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Stream<List<CollectionModel>> getAllCollections(String uid) {
      return firebaseFirestore.collection("collections").where("uid",isEqualTo: uid).snapshots().map((query) =>
          query.docs.map((item) => CollectionModel.fromMap(item)).toList());
  }

  Future<void> logoutGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    secureStorage.deleteAll();
    Get.offAllNamed(Routes.LOGIN);
  }

  void saveCollection(String name) {
    if(name.isNotEmpty){
      firebaseFirestore.collection("collections").add({
        "name" : name,
        "uid" : uid.value
      }).whenComplete((){
        nameController.text = "";
        Get.back();
      });
    }else{
      Get.snackbar("Ops ... ", "Data tidak boleh kosong");
    }
  }

  void deleteCollection(String docId){
    firebaseFirestore.collection("collections").doc(docId).delete().whenComplete(() {
      Get.back();
    }).catchError((onError){
      print(onError);
    });
  }

  void updateCollection(String docId,String name){
    firebaseFirestore.collection("collections").doc(docId).update({
      "name" : name,
    }).whenComplete(() {
      Get.back();
    }).catchError((onError){
      print(onError);
    });
  }

  void onLongPress(int index){
    nameController.text = collections[index].name!;
    buildAddEditCollectionView(
        text: 'UPDATE',
        controller: nameController,
        doc: collections[index].docId!,
        onPressDelete: () {
          deleteCollection(collections[index].docId!);
        },
        onPressUpdate: () {
          updateCollection(collections[index].docId!, nameController.text);
        });
  }

  void getUserLogin() async{
    name.value = (await secureStorage.getName())!;
    uid.value = (await secureStorage.getUid())!;
    collections.bindStream(getAllCollections(uid.value));

  }

  Future<bool> onWillPop() async{
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      currentBackPressTime = now;
      return false;
    }
    return true;
  }
}
