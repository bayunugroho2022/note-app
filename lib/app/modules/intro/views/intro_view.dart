import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/modules/login/views/login_view.dart';
import 'package:noteapp/app/widgets/widget_intro.dart';

import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(dark),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(dark),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: (){
                Get.to(LoginView());
              },
              child: Text('Skip', style: TextStyle(
                  color: Color(white),
                  fontSize: 18,
                  fontWeight: FontWeight.w400
              ),),
            ),
          )
        ],
      ),

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
                controller.currentIndex.value = page;
            },
            controller: controller.pageController,
            children: <Widget>[
              makePage(
                  image: 'assets/img/1.png',
                  title: "Daily Notes",
                  content: "buat catatan, pengingat, tetapkan target, kumpulkan sumber daya, dan privasi keamanan"
              ),
              makePage(
                  reverse: true,
                  image: 'assets/img/1.png',
                  title: Strings.stepTwoTitle,
                  content: Strings.stepTwoContent
              ),
              makePage(
                  image: 'assets/img/1.png',
                  title: Strings.stepThreeTitle,
                  content: Strings.stepThreeContent
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Obx(()=>Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.buildIndicator(),
            )),
          )
        ],
      ),
    );
  }
}
