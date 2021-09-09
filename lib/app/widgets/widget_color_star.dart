import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

Widget ColorStar({Function()? onTap ,Color? labelColor}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: Get.width * 0.1,
        width: Get.width * 0.1,
        decoration: BoxDecoration(
            color: labelColor,
            borderRadius: BorderRadius.circular(Get.width),
            ),
      ),
    ),
  );
}