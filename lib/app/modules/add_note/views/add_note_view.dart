import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/helpers/size_config.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  String? docsId;
  AddNoteView({this.docsId});
  final controller = Get.put(AddNoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(dark),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(dark),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() =>Visibility(
              visible: controller.isDone.value,
              child: IconButton(
                  onPressed: (){
                    controller.saveNote(controller.titleController.text,controller.noteController.text,docsId!);
                  },
                  icon: Icon(
                    Icons.check,
                    color: Color(white),
                  )),
            )),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onChanged: (val) {
                if (val.isNotEmpty &&
                    controller.noteController.text.isNotEmpty) {
                  controller.isDone.value = true;
                  controller.update();
                } else {
                  controller.isDone.value = false;
                  controller.update();
                }
              },
              controller: controller.titleController,
              style: TextStyle(
                  color: Color(white),
                  fontSize: SizeConfig.blockVertical! * 4,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "Title",
                fillColor: Color(white),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(white),
                  fontSize: SizeConfig.blockVertical! * 3,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  if (val.isNotEmpty &&
                      controller.titleController.text.isNotEmpty) {
                    controller.isDone.value = true;
                    controller.update();

                  } else {
                    controller.isDone.value = false;
                    controller.update();

                  }
                },
                controller: controller.noteController,
                maxLines: 20,
                style: TextStyle(
                  color: Color(white),
                  fontSize: SizeConfig.blockVertical! * 3,
                ),
                decoration: InputDecoration(
                  hintText: "Note",
                  fillColor: Color(white),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color(white),
                    fontSize: SizeConfig.blockVertical! * 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
