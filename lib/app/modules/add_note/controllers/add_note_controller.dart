import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddNoteController extends GetxController {
  TextEditingController noteController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  final isDone = false.obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("collections");

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void saveNote(String title,String note,String docsId) {
    collectionReference.doc(docsId).collection("notes").add({
      "title" : title,
      "note" : note,
    }).whenComplete((){
      Get.back();
    });

  }}
