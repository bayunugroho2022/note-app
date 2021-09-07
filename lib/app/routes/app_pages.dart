import 'package:get/get.dart';

import 'package:noteapp/app/modules/home/bindings/home_binding.dart';
import 'package:noteapp/app/modules/home/views/home_view.dart';
import 'package:noteapp/app/modules/intro/bindings/intro_binding.dart';
import 'package:noteapp/app/modules/intro/views/intro_view.dart';
import 'package:noteapp/app/modules/login/bindings/login_binding.dart';
import 'package:noteapp/app/modules/login/views/login_view.dart';
import 'package:noteapp/app/modules/note/bindings/note_binding.dart';
import 'package:noteapp/app/modules/note/views/note_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INTRO;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NOTE,
      page: () => NoteView(),
      binding: NoteBinding(),
    ),
  ];
}
