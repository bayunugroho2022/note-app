/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

import 'package:flutter/widgets.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHight;
  static double? blockHorizontal;
  static double? blockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHight = _mediaQueryData!.size.height;
    blockHorizontal = screenWidth! / 100;
    blockVertical = screenHight! / 100;
  }
}
