import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/app/data/secure_storage.dart';
import 'package:noteapp/app/modules/home/views/home_view.dart';
import 'package:noteapp/app/routes/app_pages.dart';

class LoginController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final secureStorage = SecureStorage();
  final count = 0.obs;

  
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
      saveToLocal(_auth.currentUser!);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  void saveToLocal(User user) {
    secureStorage.persistNameAndUid(user.displayName!,user.uid);
    Get.offAndToNamed(Routes.HOME);
  }



}
