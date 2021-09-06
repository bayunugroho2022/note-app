import 'package:cloud_firestore/cloud_firestore.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

class CollectionModel {
  String? name;
  String? docId;
  CollectionModel({ this.docId,this.name});

  CollectionModel.fromMap(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"];
  }
}