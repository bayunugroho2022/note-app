import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/helpers/size_config.dart';
import 'package:noteapp/app/routes/app_pages.dart';
import 'package:noteapp/app/widgets/widget_add_or_update.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              buildAddEditCollectionView(
                  text: 'ADD',
                  onPressSave: () {
                    controller.saveCollection(controller.nameController.text);
                  },
                  controller: controller.nameController);
            },
            child: Icon(Icons.add),
            backgroundColor: Color(blue),
          ),
          backgroundColor: Color(dark),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(dark),
            title: Obx(() => Text(
                  'Hello ${controller.name.value} ... ',
                  style: TextStyle(color: Color(white)),
                )),
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
                        onTap: () {
                          Get.toNamed(Routes.NOTE, arguments: {
                            "docsId": controller.collections[index].docId,
                            "collectionName": controller.collections[index].name
                          });
                        },
                        onLongPress: () {
                          controller.onLongPress(index);
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
                              Image.asset("assets/img/folder.png",
                                  height: 70.0),
                              SizedBox(
                                height: 10,
                              ),
                              Text("${controller.collections[index].name}",
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
          )),
    );
  }
}
