import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/app/helpers/date_formatter.dart';
import 'package:noteapp/app/widgets/widget_color_star.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/helpers/size_config.dart';
import 'package:noteapp/app/models/model.dart';

import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  String? docsId;
  NoteModel? note;
  String? docNote;

  AddNoteView({this.docNote, this.docsId, this.note});

  final controller = Get.put(AddNoteController());

  @override
  Widget build(BuildContext context) {
    controller.checkUpdateOrNot(note, docNote);

    return Scaffold(
      floatingActionButton: FabCircularMenu(
          fabColor: Color(blue),
          fabCloseColor: Color(blue),
          fabOpenColor: Color(blue),
          ringColor: Color(blue),
          children: <Widget>[
            Visibility(
              visible: docNote == null ? false : true,
              child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    controller.deleteNote(docsId!, docNote);
                  }),
            ),
            IconButton(
                icon: Obx(() =>Icon(Icons.star,color: kLabelToColor[controller.labelColor],)),
                onPressed: () {
                  Get.defaultDialog(
                      title: "",
                      content: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ColorStar(onTap: (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(0);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[0]),
                                ColorStar(onTap:  (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(1);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[1]),
                                ColorStar(onTap:  (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(2);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[2]),
                                ColorStar(onTap:  (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(3);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[3]),
                                ColorStar(onTap:  (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(4);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[4]),

                              ],
                            ),
                            Row(
                              children: [
                                ColorStar(onTap:  (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(5);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[5]),
                                ColorStar(onTap:  (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(6);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[6]),
                                ColorStar(onTap:  (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(7);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[7]),
                                ColorStar(onTap:  (){
                                  controller.labelColor.value = kLabelToColor.keys.elementAt(8);
                                  controller.update();
                                  Get.back();
                                }, labelColor: kLabelToColor[8]),
                              ],
                            ),

                          ],
                        ),
                      ));
                }),
          ]),
      backgroundColor: Color(dark),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(docNote == null
            ? ""
            : "Edited " + TimeAgo.timeAgoSinceDate(note!.last_edited!)),
        backgroundColor: Color(dark),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => Visibility(
                  visible: controller.isDone.value,
                  child: IconButton(
                      onPressed: () {
                        controller.saveOrUpdateNote(
                            controller.titleController.text,
                            controller.noteController.text,
                            docsId!,
                            docNote);
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
        child: Material(
          color: Color(dark),
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
      ),
    );
  }
}
