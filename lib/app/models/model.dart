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