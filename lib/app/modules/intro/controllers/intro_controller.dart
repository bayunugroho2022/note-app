import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/app/widgets/widget_indicator.dart';

class IntroController extends GetxController {
  PageController? pageController;
  final currentIndex = 0.obs;

  @override
  void onInit() {
    pageController = PageController(
        initialPage: 0
    );
    super.onInit();
  }

  @override
  void onReady() {
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
}
