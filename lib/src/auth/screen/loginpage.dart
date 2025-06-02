import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/authcontroller.dart';
import 'package:candy_app/src/auth/screen/forgotpassword.dart';
import 'package:candy_app/src/auth/screen/signuppage.dart';
import 'package:candy_app/src/auth/widget/auth_button.dart';
import 'package:candy_app/src/auth/widget/bars.dart';
import 'package:candy_app/src/auth/widget/fields.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

//Login Page
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.5),
        child: SafeArea(
          child: BasicAppBar(
            title: "Sign in",
            width: width,
            height: height,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.015,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Sign in to access your personal account",
                    style: textBlackLargeBold,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(slide1),
                radius: width * 0.23,
              ),
              SizedBox(
                height: height * 0.015,
              ),
              const Field_Title(
                Title: "Email",
              ),
              AppTextField(
                  hint: "Enter your email address",
                  icon: FontAwesomeIcons.solidEnvelope,
                  controller: authController.loginEmailController),
              SizedBox(
                height: height * 0.005,
              ),
              const Field_Title(
                Title: "Password",
              ),
              PasswordField(
                  controller: authController.loginPasswordController,
                  hint: "Enter your password"),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: CustomTextBtn(
                  alignment: Alignment.centerRight,
                  ontap: () {
                    Get.to(PasswordPage());
                  },
                  btnTitle: "Forgot Password ?",
                  btnstyle: textprimaryMedium,
                ),
              ),
              CustomBtn(
                height: height * 0.07,
                width: width * 0.9,
                ontap: () {
                  authController.checkLogin();
                },
                btnTitle: "Login",
                btnColor: primaryColor,
                btnstyle: textWhiteMedium,
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.15,
                      ),
                      Text(
                        "Do you have an account ?",
                        style: textBlackMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: CustomTextBtn(
                          alignment: Alignment.centerRight,
                          ontap: () {
                            Get.to(() => SignUpPage());
                          },
                          btnTitle: "Sign Up",
                          btnstyle: textprimaryMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
