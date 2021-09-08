import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:noteapp/app/models/model.dart';

class NoteController extends GetxController {
  //TODO: Implement NoteController
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  RxList<NoteModel> collections = RxList<NoteModel>([]);

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getNotes(String docsId){
    collections.bindStream(getAllNotesCollection(docsId));
  }

  Stream<List<NoteModel>> getAllNotesCollection(String docsId) {
    return firebaseFirestore.collection("collections").doc(docsId).collection("notes").snapshots().map((query) =>
        query.docs.map((item) => NoteModel.fromMap(item)).toList());
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
