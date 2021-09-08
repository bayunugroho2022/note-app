import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/helpers/size_config.dart';
import 'package:noteapp/app/modules/add_note/views/add_note_view.dart';
import 'package:noteapp/app/routes/app_pages.dart';

import '../controllers/note_controller.dart';

class NoteView extends GetView<NoteController> {
  String? docsId;
  String? collectionName;
  NoteView({this.docsId,this.collectionName});
  final controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    controller.getNotes(docsId!);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNoteView(docsId: docsId,));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(blue),
      ),
      backgroundColor: Color(dark),
      appBar: AppBar(
        title: Text('$collectionName'),
        backgroundColor: Color(dark),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Obx(() => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                },
                onLongPress: () {
                },
                child: GlassmorphicContainer(
                  width: Get.width / 2,
                  height: Get.height / 4,
                  borderRadius: 15,
                  blur: 2,
                  alignment: Alignment.center,
                  border: 1,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.1),
                        Color(0xFFFFFFFF).withOpacity(0.05),
                      ],
                      stops: [
                        1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(dark).withOpacity(0.5),
                      Color((dark)).withOpacity(0.5),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${controller.collections[index].title}",
                        style: TextStyle(
                            color: Color(white),
                            fontSize: SizeConfig.blockVertical! * 3),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: controller.collections.length,
        )),
      )
    );
  }
}
