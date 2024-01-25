import 'package:course_app/constants/db.dart';
import 'package:course_app/screens/authentication/root.dart';
import 'package:course_app/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class FirebaseAuthentication {
  String phoneNumber = '';

  // for web
  Future<ConfirmationResult> sendOtp(String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult confirmationResult =
        await auth.signInWithPhoneNumber(phoneNumber);
    printInfo(info: 'OTP Sent');
    return confirmationResult;
  }

  Future<void> authenticateMe(ConfirmationResult result, String otp) async {
    UserCredential userCredential = await result.confirm(otp);
    await saveUserData(userCredential);
    userCredential.additionalUserInfo!.isNewUser
        ? printInfo(info: 'Successful Authenticate new')
        : printInfo(info: 'Welcome Back');
    Get.offAll(() => const Home());
  }

  Future<void> saveUserData(UserCredential credential) async {
    Hive.box('cache').put('uid', credential.user?.uid);
    Hive.box('cache').put('isLogined', true);
    DatabaseClass.uid = credential.user?.uid;
    DatabaseClass.isLogined = true;
  }

  // fn for logout
  Future<void> signOutCurrentUser() async {
    await FirebaseAuth.instance.signOut();
    DatabaseClass.isLogined = false;
    DatabaseClass.uid = null;
    Hive.box('cache').put('isLogined', DatabaseClass.isLogined);
    Hive.box('cache').put('uid', DatabaseClass.uid);
    Get.offAll(() => const AuthenticationScreen());
  }
}
