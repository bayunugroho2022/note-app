import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/models/model.dart';

class AddNoteController extends GetxController {
  TextEditingController noteController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();
  final isDone = false.obs;
  final labelColor = 0.obs;
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

  void checkUpdateOrNot(NoteModel? note, String? tag){
      if(tag != null){
        noteController.text = note!.note!;
        titleController.text = note.title!;
        isDone.value =true;
      }else{
        noteController.text = "";
        titleController.text = "";
      }
      update();
  }

  void deleteNote(String docsId,String? docNote){
    collectionReference.doc(docsId).collection("notes").doc(docNote).delete().whenComplete(() => Get.back());
    }

  void saveOrUpdateNote(String title,String note,String docsId, String? docNote) {
    DateTime now = DateTime.now();
    String last_edited = DateFormat('dd-MM-yyyy h:mma').format(now);

    if(docNote == null){
      collectionReference.doc(docsId).collection("notes").add({
        "title" : title,
        "note" : note,
        'last_edited' :last_edited,
        'label_color': kLabelToColor.keys.elementAt(labelColor.value),
        'createdAt' :FieldValue.serverTimestamp()
      }).whenComplete((){
        Get.back();
      });
    }else{
      collectionReference.doc(docsId).collection("notes").doc(docNote).update({
        "title" : title,
        "note" : note,
        'last_edited' :last_edited,
        'label_color': kLabelToColor.keys.elementAt(labelColor.value),
        'createdAt' :FieldValue.serverTimestamp()
      }).whenComplete((){
        Get.back();
      });
    }

  }

}
