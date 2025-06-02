import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/auth/screen/splash.dart';
import 'package:candy_app/src/auth/widget/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Welcome Page
class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    slide1,
                    height: height * 0.6,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "The Car You Need Is Just A Tap Away",
                      style: textBlackBigBold,
                    )),
                SizedBox(
                  height: height * 0.1,
                ),
                CustomBtn(
                    height: height * 0.075,
                    width: width,
                    ontap: () {
                      Get.to(() => Splash());
                    },
                    btnColor: primaryColor,
                    btnstyle: textWhiteMediumBold,
                    btnTitle: "Get Started")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
