import 'dart:async';

import 'package:candy_app/src/auth/screen/signuppage.dart';
import 'package:candy_app/src/controller/authcontroller.dart';
import 'package:candy_app/src/auth/widget/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MailController extends GetxController {
  final authController = Get.find<AuthController>();
  late Timer _timer;
  RxInt resendMailTimer = 60.obs;
  RxBool canResendMail = false.obs;

 void onInit() {
    mailVerification();
    setTimerForAutoRedirect();
    startResendTimer(); // Start the resend timer when the controller initializes
    super.onInit();
  }

 

  Future<void> mailVerification() async {
    try {
      await authController.sendVerificationEmail();
    } catch (e) {
      CustomSnackBar("Error", "Some thing went wrong $e", "error");
    }
  }

  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        timer.cancel();
        authController.initialScreen(user);
        authController.addUserInfo();
        authController.clearSignupFields();
      }
    });
  }

  void startResendTimer() {
    canResendMail.value = false;
    resendMailTimer.value = 60; // Reset timer to 60 seconds
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendMailTimer.value > 0) {
        resendMailTimer.value--;
      } else {
        timer.cancel();
        canResendMail.value = true;
      }
    });
  }

  Future<void> resendVerificationEmail() async {
    if (canResendMail.value) {
      await mailVerification();
      startResendTimer(); // Restart the timer after resending
    } else {
      CustomSnackBar("Info", "Please wait before resending the email.", "info");
    }
  }

  void navigateToSignupForEmailChange() {
    authController.clearSignupFields(); // Clear fields to allow new input
    Get.offAll(() => SignUpPage()); // Navigate back to the signup route
  }
}
