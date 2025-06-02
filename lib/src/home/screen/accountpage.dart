import 'dart:convert';

import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/authcontroller.dart';
import 'package:candy_app/src/controller/exportcontroller.dart';
import 'package:candy_app/src/controller/usercontroller.dart';
import 'package:candy_app/src/home/screen/account.dart';
import 'package:candy_app/src/home/screen/homepage.dart';
import 'package:candy_app/src/home/widget/exportbox.dart';
import 'package:candy_app/src/home/widget/profilebox.dart';
import 'package:candy_app/src/home/widget/tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final UserController userController = Get.find<UserController>();
    final AuthController authController = Get.find<AuthController>();
    final ExportController exportController = Get.put(ExportController());
// Account Page
    return Scaffold(
        backgroundColor: white,
        bottomNavigationBar: AccountNavBar(
          height: height,
          width: width,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 8, bottom: 8, right: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Text(
                              "Profile",
                              style: textBlackLargeBold,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Center(
                                    // Centered the CircleAvatar for better presentation
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Obx(() {
                                          final profileImageUrl = userController
                                              .getUserField('profileImageUrl');
                                          if (profileImageUrl != null &&
                                              profileImageUrl.isNotEmpty) {
                                            return CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: width *
                                                  0.25, // Adjust radius as needed
                                              backgroundImage: MemoryImage(
                                                  base64Decode(
                                                      profileImageUrl)),
                                            );
                                          } else {
                                            // Placeholder if no image is available
                                            return CircleAvatar(
                                              radius: width *
                                                  0.25, // Adjust radius as needed
                                              backgroundColor: Colors.grey[
                                                  300], // Placeholder color
                                              child: Icon(
                                                Icons.person,
                                                size: width * 0.15,
                                                color: Colors.grey[600],
                                              ),
                                            );
                                          }
                                        })))
                              ])),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          Profile_Box(
                              ontap: () {
                                Get.to(() => AccountInfo());
                              },
                              color: primaryColor,
                              width: width,
                              height: height,
                              title: "Account",
                              icon: FontAwesomeIcons.wallet),
                          Profile_Box(
                              ontap: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                  ),
                                  context: context,
                                  builder: (BuildContext modalContext) {
                                    return Container(
                                      height: height * 0.45,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: width * 0.075,
                                                  ),
                                                  Icon(
                                                    FontAwesomeIcons.fileExport,
                                                    size: 20,
                                                    color: black,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.15,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.5,
                                                    child: Text(
                                                      "Export Data ",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style:
                                                          textBlackMediumBold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        color: black,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            ExportBox(
                                                width: width,
                                                height: height,
                                                title: "Export as Cvs",
                                                subTitle:
                                                    "This is best for calculation and analysis",
                                                color: green,
                                                icon: FontAwesomeIcons.file,
                                                ontap: () {
                                                  exportController
                                                      .exportTransactionsCsv();
                                                }),
                                            ExportBox(
                                                width: width,
                                                height: height,
                                                title: "Export as Pdf",
                                                subTitle:
                                                    "This is best for sharing and printing",
                                                color: red,
                                                icon: FontAwesomeIcons.folder,
                                                ontap: () {
                                                  exportController
                                                      .exportTransactionsPdf();
                                                }),
                                            ExportBox(
                                                width: width,
                                                height: height,
                                                title: "Export as Image",
                                                subTitle:
                                                    "This is best for sharing and not heavy",
                                                color: Colors.orange,
                                                icon: FontAwesomeIcons.image,
                                                ontap: () {
                                                  exportController.exportTransactionsImage();
                                                }),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              color: green,
                              width: width,
                              height: height,
                              title: "Export Data",
                              icon: FontAwesomeIcons.arrowUpFromBracket),
                          Profile_Box(
                              ontap: () {
                                authController.logOut();
                              },
                              color: red,
                              width: width,
                              height: height,
                              title: "Log Out",
                              icon: FontAwesomeIcons.rightFromBracket)
                        ])))));
  }
}


//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 5, vertical: 10),
//                             child: Text(
//                               "Profile",
//                               style: textBlackLargeBold,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(children: [
//                               Center(
//                                 // Centered the CircleAvatar for better presentation
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Obx(() {
//                                     final profileImageUrl = userController
//                                         .getUserField('profileImageUrl');
//                                     if (profileImageUrl != null &&
//                                         profileImageUrl.isNotEmpty) {
//                                       return CircleAvatar(
//                                         radius: width *
//                                             0.25, // Adjust radius as needed
//                                         backgroundImage: MemoryImage(
//                                             base64Decode(profileImageUrl)),
//                                       );
//                                     } else {
//                                       // Placeholder if no image is available
//                                       return CircleAvatar(
//                                         radius: width *
//                                             0.25, // Adjust radius as needed
//                                         backgroundColor: Colors
//                                             .grey[300], // Placeholder color
//                                         child: Icon(
//                                           Icons.person,
//                                           size: width * 0.15,
//                                           color: Colors.grey[600],
//                                         ),
//                                       );
//                                     }
//                                   }),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: height * 0.07,
//                               ),
//                               SizedBox(
//                                 height: height * 0.05,
//                               ),
//                               Profile_Box(
//                                   ontap: () {
//                                     Get.to(() => AccountInfo());
//                                   },
//                                   color: primaryColor,
//                                   width: width,
//                                   height: height,
//                                   title: "Account",
//                                   icon: FontAwesomeIcons.wallet),
//                               Profile_Box(
//                                   color: green,
//                                   width: width,
//                                   height: height,
//                                   title: "Export Data",
//                                   icon: FontAwesomeIcons.arrowUpFromBracket),
//                               Profile_Box(
//                                   ontap: () {
//                                     authController.logOut();
//                                   },
//                                   color: red,
//                                   width: width,
//                                   height: height,
//                                   title: "Log Out",
//                                   icon: FontAwesomeIcons.rightFromBracket)
//                             ]),
//                           )
//                         ])))));
//   }
// }
