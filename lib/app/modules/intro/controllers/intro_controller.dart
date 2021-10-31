import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/app/data/dynamic_link.dart';
import 'package:noteapp/app/data/secure_storage.dart';
import 'package:noteapp/app/helpers/tes.dart';
import 'package:noteapp/app/routes/app_pages.dart';
import 'package:noteapp/app/widgets/widget_indicator.dart';
import 'package:share/share.dart';

class IntroController extends GetxController {
  PageController? pageController;
  final currentIndex = 0.obs;
  final secureStorage = SecureStorage();
  late DynamicLinkService dynamicLinkService;
  @override
  void onInit() {
    dynamicLinkService = DynamicLinkService();
    pageController = PageController(
        initialPage: 0
    );
    checkLogin();
    super.onInit();
  }

  @override
  void onReady() {
    FirebaseConfig.initialMessageHandler();
    FirebaseConfig.onMessageOpenApp();
    dynamicLinkService.initDynamicLinks();
    super.onReady();
  }

  @override
  void onClose() {
    pageController!.dispose();
  }

  List<Widget> buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<3; i++) {
      if (currentIndex.value == i) {
        indicators.add(indicator(true));
      } else {
        indicators.add(indicator(false));
      }
      update();
    }
    return indicators;
  }

  void checkLogin() async{
    bool isLogin = await secureStorage.hasUid();
    if(isLogin){
      Get.offAndToNamed(Routes.HOME);
    }
  }


  void createDynamicLink()async{
    await dynamicLinkService.createDynamicLink("testestes").then((value) {
      print('hasil $value');
      // Share.share(value.toString());
    }).catchError((onError){
      print('${onError}');
    });
  }
}
