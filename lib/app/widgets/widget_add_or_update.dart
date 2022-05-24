import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:noteapp/app/helpers/colors.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

buildAddEditCollectionView(
    {String? text,
    Function()? onPressSave,
    Function()? onPressDelete,
    Function()? onPressUpdate,
    TextEditingController? controller,
    String doc = ""}) {
  Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
        color: Color(dark2),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Collection',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(white)),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 8,
                ),
                doc == ""
                    ? ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: Get.context!.width, height: 45),
                        child: ElevatedButton(
                          child: Text(
                            text!,
                            style: TextStyle(color: Color(white), fontSize: 16),
                          ),
                          onPressed: onPressSave,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: Get.context!.width / 3, height: 45),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(white),
                                      fontWeight: FontWeight.bold)),
                              child: Text(
                                "DELETE",
                              ),
                              onPressed: onPressDelete,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                width: Get.context!.width / 3, height: 45),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(blue),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(white),
                                      fontWeight: FontWeight.bold)),
                              child: Text(
                                "UPDATE",
                              ),
                              onPressed: onPressUpdate,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
