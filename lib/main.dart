import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: "roynh",
        primarySwatch: Colors.blue,
      ),
      title: "Easy Notes - No Ads, Notepad, Notebook, Free Notes App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
