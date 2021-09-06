import 'package:flutter/material.dart';
import 'package:noteapp/app/helpers/colors.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

Widget indicator(bool isActive) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    height: 6,
    width: isActive ? 30 : 6,
    margin: EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
        color: Color(blue),
        borderRadius: BorderRadius.circular(5)
    ),
  );
}
