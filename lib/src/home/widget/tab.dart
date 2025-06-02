import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/home/screen/accountpage.dart';
import 'package:candy_app/src/home/screen/transactionpage.dart';
import 'package:candy_app/src/home/screen/homepage.dart';
import 'package:candy_app/src/home/screen/statisticspage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomPageTab extends StatelessWidget {
  const CustomPageTab(
      {super.key,
      required this.height,
      required this.width,
      required this.icon,
      required this.title,
      required this.ontap});

  final double height;
  final double width;
  final IconData icon;
  final String title;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Column(
          children: [
            Icon(
              icon,
              size: 25,
              color: primaryColor,
            ),
            Text(title, style: textPrimaryMini),
          ],
        ),
      ),
    );
  }
}

class CustomTabIcon extends StatelessWidget {
  const CustomTabIcon(
      {super.key,
      required this.height,
      required this.width,
      required this.icon,
      required this.title,
      required this.ontap});

  final double height;
  final double width;
  final IconData icon;
  final void Function()? ontap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(top: 1),
        child:  Column(
            children: [
              Icon(
                icon,
                size: 25,
                color: lightGrey,
              ),
              Text(title,
                  style: TextStyle(
                    color: lightGrey,
                    fontSize: 11.5,
                    fontFamily: "Montserrat",
                  )),
            ],
          ),
        ),
      
    );
  }
}

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: height * 0.09,
        elevation: 0,
        color: white,
        child: Container(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomPageTab(
                ontap: () {
                  Get.to(() => HomePage());
                },
                height: height,
                width: width,
                icon: FontAwesomeIcons.houseUser,
                title: "Home",
              ),
              SizedBox(
                width: width * 0.04,
              ),
              CustomTabIcon(
                  height: height,
                  width: width,
                  icon: FontAwesomeIcons.rightLeft,
                  title: "Transaction",
                  ontap: () {
                    Get.to(() => BudgetPage());
                  }),
              SizedBox(
                width: width * 0.04,
              ),
              CustomTabIcon(
                  height: height,
                  width: width,
                  icon: FontAwesomeIcons.chartPie,
                  title: "Statistics",
                  ontap: () {
                    Get.to(() => SearchPage());
                  }),
              SizedBox(
                width: width * 0.04,
              ),
              CustomTabIcon(
                  title: "Profile",
                  height: height,
                  width: width,
                  icon: FontAwesomeIcons.circleUser,
                  ontap: () {
                    Get.to(() => AccountPage());
                  })
            ],
          ),
        ));
  }
}

class BudgetNavBar extends StatelessWidget {
  const BudgetNavBar({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: height * 0.09,
        elevation: 0,
        color: white,
        child: Container(
            width: width * 1,
            child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTabIcon(
                    ontap: () {
                      Get.to(() => HomePage());
                    },
                    height: height,
                    width: width,
                    icon: FontAwesomeIcons.houseUser,
                    title: "Home",
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomPageTab(
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.rightLeft,
                      title: "Transaction",
                      ontap: () {
                        Get.to(() => BudgetPage());
                      }),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomTabIcon(
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.chartPie,
                      title: "Statistics",
                      ontap: () {
                        Get.to(() => SearchPage());
                      }),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomTabIcon(
                      title: "Profile",
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.circleUser,
                      ontap: () {
                        Get.to(() => AccountPage());
                      })
                ],
              ),
            ));
  }
}

class SearchNavBar extends StatelessWidget {
  const SearchNavBar({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: height * 0.09,
        elevation: 0,
        color: white,
        child: Container(
            width: width * 1,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTabIcon(
                    ontap: () {
                      Get.to(() => HomePage());
                    },
                    height: height,
                    width: width,
                    icon: FontAwesomeIcons.houseUser,
                    title: "Home",
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomTabIcon(
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.rightLeft,
                      title: "Transaction",
                      ontap: () {
                        Get.to(() => BudgetPage());
                      }),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomPageTab(
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.chartPie,
                      title: "Statistics",
                      ontap: () {
                        Get.to(() => SearchPage());
                      }),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomTabIcon(
                      title: "Profile",
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.circleUser,
                      ontap: () {
                        Get.to(() => AccountPage());
                      })
                ],
              ),
            ));
  }
}

class AccountNavBar extends StatelessWidget {
  const AccountNavBar({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: height * 0.09,
        elevation: 0,
        color: white,
        child: Container(
          color: white,
            width: width * 1,
            child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTabIcon(
                    ontap: () {
                      Get.to(() => HomePage());
                    },
                    height: height,
                    width: width,
                    icon: FontAwesomeIcons.houseUser,
                    title: "Home",
                  ),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomTabIcon(
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.rightLeft,
                      title: "Transaction",
                      ontap: () {
                        Get.to(() => BudgetPage());
                      }),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomTabIcon(
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.chartPie,
                      title: "Statistics",
                      ontap: () {
                        Get.to(() => SearchPage());
                      }),
                  SizedBox(
                    width: width * 0.04,
                  ),
                  CustomPageTab(
                      title: "Profile",
                      height: height,
                      width: width,
                      icon: FontAwesomeIcons.circleUser,
                      ontap: () {
                        Get.to(() => AccountPage());
                      })
                ],
              ),
            ));
  }
}


// class MapNavBar extends StatelessWidget {
//   const MapNavBar({
//     super.key,
//     required this.width,
//     required this.height,
//   });

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//         color: black,
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: primaryColor,
//                 ),
//                 height: height * 0.09,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: width * 0.03,
//                     ),
//                     CustomTabIcon(
//                       ontap: () {
//                         Get.to(() => HomePage());
//                       },
//                       height: height,
//                       width: width,
//                       icon: HugeIcons.strokeRoundedHome08,
//                     ),
//                     SizedBox(
//                       width: width * 0.04,
//                     ),
//                     CustomPageTab(
//                         title: "Map",
//                         height: height,
//                         width: width,
//                         icon: HugeIcons.strokeRoundedMaps,
//                         ontap: () {
//                           Get.to(() => MapPage());
//                         }),
//                     SizedBox(
//                       width: width * 0.04,
//                     ),
//                     CustomTabIcon(
//                         height: height,
//                         width: width,
//                         icon: HugeIcons.strokeRoundedBookmark01,
//                         ontap: () {
//                           Get.to(() => SavePage());
//                         }),
//                     SizedBox(
//                       width: width * 0.04,
//                     ),
//                     CustomTabIcon(
//                         height: height,
//                         width: width,
//                         icon: HugeIcons.strokeRoundedUserAccount,
//                         ontap: () {
//                           Get.to(() => AccountPage());
//                         })
//                   ],
//                 ))));
//   }
// }

// class SaveNavBar extends StatelessWidget {
//   const SaveNavBar({
//     super.key,
//     required this.width,
//     required this.height,
//   });

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//         color: black,
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: primaryColor,
//                 ),
//                 height: height * 0.09,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: width * 0.03,
//                     ),
//                     CustomTabIcon(
//                       ontap: () {
//                         Get.to(() => HomePage());
//                       },
//                       height: height,
//                       width: width,
//                       icon: HugeIcons.strokeRoundedHome08,
//                     ),
//                     SizedBox(
//                       width: width * 0.04,
//                     ),
//                     CustomTabIcon(
//                         height: height,
//                         width: width,
//                         icon: HugeIcons.strokeRoundedMaps,
//                         ontap: () {
//                           Get.to(() => MapPage());
//                         }),
//                     SizedBox(
//                       width: width * 0.04,
//                     ),
//                     CustomPageTab(
//                         title: "Wish List",
//                         height: height,
//                         width: width * 1.2,
//                         icon: HugeIcons.strokeRoundedBookmark01,
//                         ontap: () {
//                           Get.to(() => SavePage());
//                         }),
//                     SizedBox(
//                       width: width * 0.02,
//                     ),
//                     CustomTabIcon(
//                         height: height,
//                         width: width,
//                         icon: HugeIcons.strokeRoundedUserAccount,
//                         ontap: () {
//                           Get.to(() => AccountPage());
//                         })
//                   ],
//                 ))));
//   }
// }

// class AccountNavBar extends StatelessWidget {
//   const AccountNavBar({
//     super.key,
//     required this.width,
//     required this.height,
//   });

//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//         color: black,
//         child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: primaryColor,
//                 ),
//                 height: height * 0.09,
//                 child: Row(children: [
//                   SizedBox(
//                     width: width * 0.03,
//                   ),
//                   CustomTabIcon(
//                     ontap: () {
//                       Get.to(() => HomePage());
//                     },
//                     height: height,
//                     width: width,
//                     icon: HugeIcons.strokeRoundedHome08,
//                   ),
//                   SizedBox(
//                     width: width * 0.04,
//                   ),
//                   CustomTabIcon(
//                       height: height,
//                       width: width,
//                       icon: HugeIcons.strokeRoundedMaps,
//                       ontap: () {
//                         Get.to(() => MapPage());
//                       }),
//                   SizedBox(
//                     width: width * 0.04,
//                   ),
//                   CustomTabIcon(
//                       height: height,
//                       width: width,
//                       icon: HugeIcons.strokeRoundedBookmark01,
//                       ontap: () {
//                         Get.to(() => SavePage());
//                       }),
//                   SizedBox(
//                     width: width * 0.04,
//                   ),
//                   CustomPageTab(
//                       title: "Account",
//                       height: height,
//                       width: width * 1.1,
//                       icon: HugeIcons.strokeRoundedUserAccount,
//                       ontap: () {
//                         Get.to(() => AccountPage());
//                       })
//                 ]))));
//   }
// }
