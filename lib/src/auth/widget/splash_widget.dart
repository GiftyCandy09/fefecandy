import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';

//Slides a4t the start of the app

class Slide extends StatelessWidget {
  const Slide(
      {super.key,
      required this.height,
      required this.width,
      this.onNextPage,
      required this.subTitle,
      required this.title,
      required this.image,
      required this.btnTitle});

  final double height;
  final double width;
  final void Function()? onNextPage;
  final String title;
  final String subTitle, btnTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 1,
      color: white,
      child: SingleChildScrollView(
          child: Column(children: [
        SizedBox(
          height: height * 0.1,
        ),
        Image.asset(
          image,
          height: height * 0.55,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.01, vertical: height * 0.01),
          child: Text(
            title,
            style: textBlackLargeBold,
          ),
        ),
        SizedBox(
          height: height * 0.025,
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Text(
            subTitle,
            style: textBlackMedium,
          ),
        ),
        SizedBox(
          height: height * 0.06,
        ),
        SizedBox(
          width: width * 0.9,
          height: height * 0.07,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                  backgroundColor: primaryColor),
              onPressed: onNextPage,
              child: Text(
                btnTitle,
                style: textWhiteMedium,
              )),
        ),
      ])),
    );
  }
}
