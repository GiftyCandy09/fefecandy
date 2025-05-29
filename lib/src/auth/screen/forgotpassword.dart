import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/authcontroller.dart';
import 'package:candy_app/src/auth/widget/auth_button.dart';
import 'package:candy_app/src/auth/widget/bars.dart';
import 'package:candy_app/src/auth/widget/fields.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.5),
          child: SafeArea(
              child: Row(children: [
            BasicAppBar(
              title: "Forgot Password",
              width: width,
              height: height,
            ),
          ]))),
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                slide1,
                height: height * 0.4,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "You can change your password for security reason or reset it if you forget",
                    style: textBlackMedium,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              const Field_Title(
                Title: "Email",
              ),
              AppTextField(
                  hint: "Enter your email address",
                  icon: FontAwesomeIcons.solidEnvelope,
                  controller: authController.resetEmailController),
              SizedBox(
                height: height * 0.075,
              ),
              CustomBtn(
                  height: height * 0.075,
                  width: width * 1,
                  ontap: () {
                    authController.ResetPasswordEmail();
                  },
                  btnColor: primaryColor,
                  btnstyle: textWhiteMedium,
                  btnTitle: "Send Email"),
            ],
          ),
        ),
      ),
    );
  }
}
