import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:noteapp/app/helpers/colors.dart';

import '../controllers/note_controller.dart';

class NoteView extends GetView<NoteController> {
  String? docsId;
  String? collectionName;
  NoteView({this.docsId,this.collectionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(dark),
      appBar: AppBar(
        title: Text('$collectionName'),
        backgroundColor: Color(dark),
      ),
      body: Center(
        child: Text(
          'NoteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
