import 'dart:convert';

import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/authcontroller.dart';
import 'package:candy_app/src/controller/exportcontroller.dart';
import 'package:candy_app/src/controller/usercontroller.dart';
import 'package:candy_app/src/auth/widget/bars.dart';
import 'package:candy_app/src/auth/widget/fields.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final UserController userController = Get.find<UserController>();




    return Scaffold(
        backgroundColor: white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.5),
          child: SafeArea(
            child: BasicAppBar(
              title: "Account",
              width: width,
              height: height,
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
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
                                          backgroundColor: Colors.transparent,
                                          radius: width *
                                              0.25, // Adjust radius as needed
                                          backgroundImage: MemoryImage(
                                              base64Decode(profileImageUrl)),
                                        );
                                      } else {
                                        // Placeholder if no image is available
                                        return CircleAvatar(
                                          radius: width *
                                              0.25, // Adjust radius as needed
                                          backgroundColor: Colors
                                              .grey[300], // Placeholder color
                                          child: Icon(
                                            Icons.person,
                                            size: width * 0.15,
                                            color: Colors.grey[600],
                                          ),
                                        );
                                      }
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                Info_Field(
                                    icon: FontAwesomeIcons.circleUser,
                                    width: width,
                                    Title: "Username",
                                    height: height,
                                    Info: userController
                                            .getUserField('username') ??
                                        "No Data"),
                                Info_Field(
                                    icon: FontAwesomeIcons.envelopeCircleCheck,
                                    width: width,
                                    Title: "Email",
                                    height: height,
                                    Info:
                                        userController.getUserField('email') ??
                                            "No Data"),
                                Info_Field(
                                    icon: FontAwesomeIcons.phone,
                                    width: width,
                                    Title: "Phone Number",
                                    height: height,
                                    Info: userController
                                            .getUserField('phoneNumber') ??
                                        "No Data"),
                                Info_Field(
                                    icon: FontAwesomeIcons.calendarDay,
                                    width: width,
                                    Title: "Date Joined",
                                    height: height,
                                    Info: userController
                                            .getUserField('createdAt') ??
                                        "No Data")
                              ],
                            ),
                          ),
                        ])))));
  }
}
