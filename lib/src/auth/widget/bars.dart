import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Bars
class AppTabs extends StatelessWidget {
  const AppTabs(
      {super.key,
      required this.height,
      required this.icon,
      this.size,
      required this.title});

  final double height;
  final String title;
  final double? size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20),
        SizedBox(
          height: height * 0.0075,
        ),
        Text(title)
      ],
    );
  }
}

class BasicAppBar extends StatelessWidget {
  const BasicAppBar(
      {super.key,
      required this.height,
      this.title,
      this.icon,
      this.onTap,
      required this.width,
      this.iconSize,
      this.Iconcolor});

  final double height;
  final String? title;
  final IconData? icon;
  final void Function()? onTap;
  final double? width;
  final double? iconSize;
  final Color? Iconcolor;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: black,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: width * 0.59,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 15),
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      title ?? "",
                      style: textBlackMediumBold,
                    ),
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: onTap,
              icon: Icon(
                icon,
                color: Iconcolor,
                size: iconSize,
              ),
            )
          ],
        ),
      ),
    );
  }
}
