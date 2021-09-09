import 'package:flutter/material.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */
class ColorSys {
  static Color primary = Color.fromRGBO(52, 43, 37, 1);
  static Color gray = Color.fromRGBO(137, 137, 137, 1);
  static Color secoundry = Color.fromRGBO(198, 116, 27, 1);
  static Color secoundryLight = Color.fromRGBO(226, 185, 141, 1);
}

const int dark = 0xFF1f1e2e;
const int white = 0xFFc6c5cb;
const int white2 = 0xFFFFFFFF;
const int grey = 0xFF676573;
const int blue = 0xFF6f6cc8;
const int dark2 = 0xFF69687c;


const Map<int, Color> kLabelToColor = {
  0: Colors.lightBlueAccent,
  1: Colors.redAccent,
  2: Colors.purpleAccent,
  3: Colors.greenAccent,
  4: Colors.yellowAccent,
  5: Colors.blueAccent,
  6: Colors.orangeAccent,
  7: Colors.pinkAccent,
  8: Colors.tealAccent
};


class Strings {
  static var stepOneTitle = "Farm Driving";
  static var stepOneContent = "There are all kinds of equipment to build your farm better harvest";
  static var stepTwoTitle = "Plant Growing";
  static var stepTwoContent = "Be part of the agriculture and gives your team the  power you need to do your best";
  static var stepThreeTitle = "Fast Harvesting";
  static var stepThreeContent = "Your will be proud to be part of agriculture and it’s harvest";
}