import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/app/data/secure_storage.dart';
import 'package:noteapp/app/models/model.dart';
import 'package:noteapp/app/modules/login/views/login_view.dart';
import 'package:noteapp/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late TextEditingController nameController;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  final secureStorage = SecureStorage();
  final name = ''.obs;
  final uid = ''.obs;
  RxList<CollectionModel> collections = RxList<CollectionModel>([]);

  final count = 0.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    getImage();
    collectionReference = firebaseFirestore.collection("collections");

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
      collectionReference.add({
        "name" : name,
        "uid" : uid.value
      }).whenComplete((){
        nameController.text = "";
        Get.back();
      });
    }else{
      print('data tidak boleh kosong');
    }
  }

  void deleteCollection(String docId){
    collectionReference.doc(docId).delete().whenComplete(() {
      Get.back();
    }).catchError((onError){
      print(onError);
    });
  }

  void updateCollection(String docId,String name){
    collectionReference.doc(docId).update({
      "name" : name,
    }).whenComplete(() {
      Get.back();
    }).catchError((onError){
      print(onError);
    });
  }

  void getImage() async{
    name.value = (await secureStorage.getName())!;
    uid.value = (await secureStorage.getUid())!;
    update();
    collections.bindStream(getAllCollections(uid.value));
  }

}
