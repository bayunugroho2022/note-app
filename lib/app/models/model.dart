import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

class CollectionModel {
  String? name;
  String? uid;
  String? docId;
  CollectionModel({ this.docId,this.name,this.uid});

  CollectionModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"];
    uid = data["uid"];
  }
}

class NoteModel {
  String? title;
  String? note;
  String? last_edited;
  String? docId;
  int? label_color;
  Timestamp? createdAt;
  NoteModel({ this.docId,this.label_color,this.createdAt,this.title,this.note,this.last_edited});

  NoteModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    title = data["title"];
    note = data["note"];
    last_edited = data["last_edited"];
    label_color = data["label_color"];
    createdAt = data["createdAt"];
  }
}