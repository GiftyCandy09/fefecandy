import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/mailcontroller.dart';
import 'package:candy_app/src/controller/authcontroller.dart';

import 'package:candy_app/src/auth/widget/bars.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailPage extends StatelessWidget {
  VerifyEmailPage({super.key, required this.email});

  final String email;

  final MailController mailController = Get.put(MailController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.5),
        child: SafeArea(
          child: BasicAppBar(
            title: "Verify Email",
            width: width,
            height: height,
          ),
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  slide1, // Make sure 'slide1' is correctly defined in your constants
                  height: height * 0.5, // Adjusted height for better layout
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: RichText(
                    textAlign:
                        TextAlign.center, // Center text for better readability
                    text: TextSpan(
                      text: "A verification link has been sent to ",
                      style:
                          textBlackMedium, // Make sure 'textBlackMedium' is defined
                      children: <TextSpan>[
                        TextSpan(
                          text: email,
                          style:
                              textprimaryMedium, // Make sure 'textprimaryMedium' is defined
                        ),
                        TextSpan(
                          text:
                              ". Please verify your email to complete account creation.",
                          style: textBlackMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Obx(() => TextButton(
                      onPressed: mailController.canResendMail.value
                          ? () => mailController.resendVerificationEmail()
                          : null, // Disable button if timer is active

                      child: mailController.canResendMail.value
                          ? Text("Resend Verification Email",
                              style:
                                  TextStyle(color: primaryColor, fontSize: 16))
                          : Text(
                              "Resend in ${mailController.resendMailTimer.value}s",
                              style: TextStyle(
                                  color: primaryColor.withOpacity(0.7),
                                  fontSize: 16)),
                    )),
              ),
              SizedBox(
                height: height * 0.075,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    mailController.navigateToSignupForEmailChange();
                  },
                  child: Text(
                    "Change Email Address",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
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


// class VerifyEmailPage extends StatelessWidget {
//   VerifyEmailPage({super.key, required this.email});

//   final String email;

//   final MailController mailController = Get.put(MailController());

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

    
  
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(height * 0.5),
//         child: SafeArea(
//           child: BasicAppBar(
//             title: "Verify Email",
//             width: width,
//             height: height,
//           ),
//         ),
//       ),
//       backgroundColor: white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: Image.asset(
//                   slide1,
//                   height: height * 0.5,
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                   child: RichText(
//                     text: TextSpan(
//                       text: "Your verification link has been sent to ",
//                       style: textBlackMedium,
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: email,
//                           style: textprimaryMedium,
//                         ),
//                         TextSpan(
//                           text: " , verify it to complete account creation",
//                           style: textBlackMedium,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
