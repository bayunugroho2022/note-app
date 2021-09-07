import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/helpers/size_config.dart';
import 'package:noteapp/app/modules/note/views/note_view.dart';
import 'package:noteapp/app/widgets/widget_add_or_update.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  User? user = FirebaseAuth.instance.currentUser;
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.nameController.text = "";
            controller.update();
            buildAddEditCollectionView(text: 'ADD',onPressSave: (){ controller
                .saveCollection(controller.nameController.text);},controller: controller.nameController);
          },
          child: Icon(Icons.add),
          backgroundColor: Color(blue),
        ),
        backgroundColor: Color(dark),
        appBar: AppBar(
          backgroundColor: Color(dark),
          title: Text(
            'Hello ${controller.name.value} ... ',
            style: TextStyle(color: Color(white)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  controller.logoutGoogle();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Color(dark2),
                ))
          ],
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
                      onTap: (){
                        Get.to(NoteView(
                          docsId : controller.collections[index].docId,
                          collectionName: controller.collections[index].name,
                        ));
                      },
                      onLongPress: (){
                        controller.nameController.text = controller.collections[index].name!;
                        controller.update();
                        buildAddEditCollectionView(text: 'UPDATE',controller: controller.nameController,doc: controller.collections[index].docId!,
                            onPressDelete: (){
                            controller.deleteCollection(controller.collections[index].docId!);
                        },onPressUpdate: () => controller.updateCollection(controller.collections[index].docId!, controller.nameController.text));
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
                            Image.asset("assets/img/folder.png", height: 70.0),
                            SizedBox(height: 10,),
                            Text("${controller.collections[index].name}",style: TextStyle(color: Color(white),fontSize: SizeConfig.blockVertical! * 3),)
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.collections.length,
              )),
        ));
  }


}
