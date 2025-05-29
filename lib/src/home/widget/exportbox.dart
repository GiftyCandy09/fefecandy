import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';

class ExportBox extends StatelessWidget {
  const ExportBox(
      {super.key,
      required this.width,
      required this.height,
      required this.title,
      required this.subTitle,
      required this.color,
      required this.icon,
      required this.ontap});

  final double width;
  final double height;
  final String title, subTitle;
  final Color color;
  final IconData icon;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: height * 0.01, horizontal: width * 0.05),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          width: width * 1,
          height: height * 0.085,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: lightWhite),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: width * 0.15,
                    height: height * 0.05,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: color),
                    child: Icon(icon, color: white, size: 18.5)),
              ),
              SizedBox(
                width: width * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(title, style: textBlackMediumBold),
                  Text(
                    subTitle,
                    style: textBlackMini,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
