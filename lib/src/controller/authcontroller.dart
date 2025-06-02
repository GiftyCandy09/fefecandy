import 'dart:async';
import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/auth/screen/loginpage.dart';
import 'package:candy_app/src/auth/screen/splash.dart';
import 'package:candy_app/src/auth/screen/verifyemail.dart';
import 'package:candy_app/src/auth/widget/modalsheet.dart';
import 'package:candy_app/src/auth/widget/snackbar.dart';
import 'package:candy_app/src/home/screen/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late TextEditingController phoneNumberController,
      //Sign Up
      usernameController,
      emailController,
      passwordController,
     
      loginEmailController,
      loginPasswordController,
      //Change Password

      resetEmailController;
  RxInt resendTimer = 60.obs;
  Timer? _timer;
  RxBool canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneNumberController = TextEditingController();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    resetEmailController = TextEditingController();
    loginEmailController = TextEditingController();
    loginPasswordController = TextEditingController();
  }

  void clearLoginFields() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }

  void clearSignupFields() {
    phoneNumberController.clear();
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  static AuthController instance = Get.find();
  late Rx<User?> user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final imageControllerUpdate = Get.put(ImageController(), tag: 'userProfile');
  final RxString _currentUserId = RxString(''); // Reactive user ID
  String get userId => _currentUserId.value;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    initialScreen(user.value);
  }

  initialScreen(User? user) {
    user == null
        ? Get.offAll(() => Splash())
        : user.emailVerified
            ? Get.offAll(() => HomePage())
            : Get.offAll(VerifyEmailPage(email: emailController.text));
  }

// Sinup Process =------- Start >

  checkSignUp() async {
    if (emailController.text.isEmpty) {
      // Simplified length check
      CustomSnackBar("Error", "Email address is required", "error");
    } else if (usernameController.text.isEmpty) {
      // Simplified length check
      CustomSnackBar("Error", "Username is required", "error");
    } else if (phoneNumberController.text.isEmpty) {
      CustomSnackBar("Error", "PhoneNumber is required", "error");
    } else if (phoneNumberController.text.length != 9) {
      // Simplified length check
      CustomSnackBar("Error", "Phone number must be 9 digits", "error");
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,}$')
        .hasMatch(passwordController.text)) {
      CustomSnackBar(
          "Error",
          "Password must be at least 8 characters and contain at least one capital letter, one number, and one special character.",
          "error");
    } else if (passwordController.text.isEmpty) {
      CustomSnackBar("Error", "Password is required", "error");
    } else if (imageControllerUpdate.imageUrl.value.isEmpty) {
      // Check if image is selected
      CustomSnackBar("Error", "Please select a profile image", "error");
    } else {
      Get.dialog(Center(
          child: CircularProgressIndicator(
        color: primaryColor,
      )));
      await initialScreen(auth.currentUser);
      try {
        await createAccount();
      } catch (e) {
        Get.back();
        CustomSnackBar("Error", "An error occurred: $e", "error");
        print("Error during login: $e");
      }
    }
  }

  Future<void> createAccount() async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      await initialScreen(auth.currentUser);
    } catch (e) {
      CustomSnackBar("Error", "Account creation failed$e", "error");
    }
  }

  Future<void> ResetPasswordEmail() async {
    try {
      await auth.sendPasswordResetEmail(
          email: resetEmailController.text.trim());
      CustomSnackBar(
          "Success",
          "Email sent use it to ${resetEmailController.text} reset password",
          'success');
      resetEmailController.clear();
      Get.to(() => LoginPage());
    } on FirebaseAuthException catch (e) {
      CustomSnackBar("Error", "$e", 'error');
    }
  }

  Future<void> sendVerificationEmail() async {
    await auth.currentUser?.sendEmailVerification();
  }
  // Sinup Process =------- End >

// Login Process =------- Start >

  checkLogin() async {
    if (loginEmailController.text.isEmpty) {
      // Simplified length check
      CustomSnackBar("Error", "Email address is required", "error");
    } else if (!RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*()_+{}\[\]:;<>,.?~\\/-]).{8,}$')
        .hasMatch(loginPasswordController.text)) {
      CustomSnackBar(
          "Error",
          "Password must be at least 8 characters and contain at least one capital letter, one number, and one special character.",
          "error");
    } else if (loginPasswordController.text.isEmpty) {
      CustomSnackBar("Error", "Password is required", "error");
    } else {
      Get.dialog(Center(
          child: CircularProgressIndicator(
        color: primaryColor,
      )));

      try {
        await signIn();
      } catch (e) {
        Get.back();
        CustomSnackBar("Error", "An error occurred: $e", "error");
        print("Error during login: $e");
      }
    }
  }

  Future<void> signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: loginEmailController.text,
          password: loginPasswordController.text);
      await initialScreen(auth.currentUser);
      clearLoginFields();

      CustomSnackBar("Success", "Welcome back !", "success");
    } catch (e) {
      CustomSnackBar("Error", "Login Failed $e", "error");
    }
  }

  Future<void> addUserInfo() async {
    try {
      if (auth.currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser!.uid)
            .collection('userData') // Sub-collection for user-specific data
            .doc('profile') // Use a fixed document ID like 'profile'
            .set({
          'id': auth.currentUser!.uid,
          'username': usernameController.text,
          'phoneNumber': "+237${phoneNumberController.text}",
          'email': emailController.text,
          'profileImageUrl': imageControllerUpdate.imageUrl.value,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      CustomSnackBar("Error", "Could not add user info$e", 'error');
      print("Error $e");
    }
  }

  String? getUserId() {
    return auth.currentUser?.uid;
  }
  // Log In Process =------- End >

  //Reset Password ----- Start>

  // Future<void> UPdatePassword() async {
  //   await auth.confirmPasswordReset(code: code, newPassword: updatePasswordController.text);
  // }

  void logOut() async {
    await auth.signOut();
    await initialScreen(auth.currentUser);
    Get.off(() => LoginPage());
    CustomSnackBar("Success", "Log you out ...", 'success');
  }
  // Log out Process =------- End >
}
