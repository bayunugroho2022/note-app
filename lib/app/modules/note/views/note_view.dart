import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/helpers/size_config.dart';
import 'package:noteapp/app/modules/add_note/views/add_note_view.dart';
import 'package:noteapp/app/routes/app_pages.dart';

import '../controllers/note_controller.dart';

class NoteView extends GetView<NoteController> {
  final controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNoteView(docsId: controller.docsId.value,));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(blue),
      ),
      backgroundColor: Color(dark),
      appBar: AppBar(
        title: Text('$controller.collectionName.value'),
        backgroundColor: Color(dark),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Obx(() => StaggeredGridView.countBuilder(
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          itemCount: controller.collections.length,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          crossAxisCount: 4,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Get.to(AddNoteView(
                docsId: controller.docsId.value,
                note:controller.collections[index],
                docNote:controller.collections[index].docId!
              ));
            },
            child: Container(
              padding: EdgeInsets.all(7),
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                gradient: new LinearGradient(
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
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: kLabelToColor[controller.collections[index].label_color],
                              size: 14,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Text(controller.collections[index].title!,
                                    maxLines: 1,
                                    style: TextStyle(color: Color(white2)),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color:  Colors.white,
                        thickness: 0.5,
                      ),
                    ],
                  ),
                  Text(
                    controller.collections[index].note!,
                    style: TextStyle(height: 1.2,color: Color(white)),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    maxLines: 8,
                  )
                ],
              ),
            ),
          ),
          staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        )),
      )
    );
  }
}
