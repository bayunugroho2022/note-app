import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:noteapp/app/helpers/colors.dart';
import 'package:noteapp/app/modules/login/views/login_view.dart';
import 'package:noteapp/app/routes/app_pages.dart';
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
                Get.toNamed(Routes.LOGIN);
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
              makePageIntro(
                  image: 'assets/img/intro1.png',
                  title: "Daily Notes",
                  content: "take notes, set targets, collect resources and security privacy"
              ),
              makePageIntro(
                  reverse: true,
                  image: 'assets/img/intro3.png',
                  title: "No Ads",
                  content: "Simple app without ads"
              ),
              makePageIntro(
                  image: 'assets/img/intro2.png',
                  title: "Easy to use",
                  content: "simple to write everyday. Just write and keep a journal notebook! Pre-written log reminder."
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
