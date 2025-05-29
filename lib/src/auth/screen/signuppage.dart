import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/auth/screen/verifyemail.dart';
import 'package:candy_app/src/controller/authcontroller.dart';
import 'package:candy_app/src/auth/screen/loginpage.dart';
import 'package:candy_app/src/auth/widget/auth_button.dart';
import 'package:candy_app/src/auth/widget/fields.dart';
import 'package:candy_app/src/auth/widget/modalsheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:candy_app/src/auth/widget/bars.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final AuthController authController = Get.find<AuthController>();
  final ImageController imageController =
      Get.put(ImageController(), tag: 'userProfile');

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
            title: "Create Account",
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Create your new account to get started",
                    style: textBlackLargeBold,
                  ),
                ),
              ),
              const Field_Title(
                Title: "Email",
              ),
              AppTextField(
                  hint: "Enter your email address",
                  icon: FontAwesomeIcons.envelopeCircleCheck,
                  controller: authController.emailController),
              const Field_Title(
                Title: "Username",
              ),
              AppTextField(
                  hint: "Enter your username",
                  icon: FontAwesomeIcons.circleUser,
                  controller: authController.usernameController),
              const Field_Title(
                Title: "Phone Number",
              ),
              PhoneField(
                controller: authController.phoneNumberController,
                hint: "Enter your phonenumber",
              ),
              SizedBox(
                height: height * 0.005,
              ),
              const Field_Title(
                Title: "Password",
              ),
              PasswordField(
                controller: authController.passwordController,
                hint: "Enter your password",
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomBtn(
                height: height * 0.07,
                width: width * 0.9,
                ontap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15)),
                      ),
                      context: context,
                      builder: (context) {
                        return UpdateImageModalSheet(
                            imageController: imageController,
                            btnTitle: "Continue",
                            text: "Tap to select and add your user profile",
                            ontap: () {
                              authController.checkSignUp();
                            
                            },
                            height: height,
                            width: width);
                      });
                },
                btnTitle: "Sign Up",
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
                            Get.to(() => LoginPage());
                          },
                          btnTitle: "Login",
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
