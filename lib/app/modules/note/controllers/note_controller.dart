import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:noteapp/app/models/model.dart';

class NoteController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  RxList<NoteModel> collections = RxList<NoteModel>([]);
  final docsId = ''.obs;
  final collectionName = ''.obs;

  @override
  void onInit() {
    docsId.value = Get.arguments['docsId'];
    collectionName.value = Get.arguments['collectionName'];
    getNotes(docsId.value);
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
    return firebaseFirestore.collection("collections").doc(docsId).collection("notes").orderBy("createdAt",descending: true).snapshots().map((query) =>
        query.docs.map((item) => NoteModel.fromMap(item)).toList());
  }

  @override
  void onClose() {}
}
