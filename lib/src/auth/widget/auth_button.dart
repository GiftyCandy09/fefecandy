import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Buttons
class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.height,
    required this.width,
    required this.ontap,
    required this.btnColor,
    required this.btnstyle,
    required this.btnTitle,
  });

  final double height;
  final double width;
  final String btnTitle;
  final Color btnColor;
  final void Function()? ontap;
  final TextStyle btnstyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: SizedBox(
            height: height,
            width: width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: btnColor,
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: ontap,
                child: Text(
                  btnTitle,
                  style: btnstyle,
                ))),
      ),
    );
  }
}

class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({
    super.key,
    required this.ontap,
    required this.btnstyle,
    required this.btnTitle,
    required this.alignment,
  });

  final String btnTitle;

  final void Function()? ontap;
  final TextStyle btnstyle;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
          onPressed: ontap,
          child: Text(
            btnTitle,
            style: btnstyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )),
    );
  }
}
