import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile_Box extends StatelessWidget {
  const Profile_Box({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.icon,
    required this.color,
    this.ontap,
  });

  final double width;
  final double height;
  final IconData icon;
  final String title;
  final void Function()? ontap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: GestureDetector(
          onTap: ontap,
          child: Container(
            width: width * 1,
            height: height * 0.08,
            decoration: BoxDecoration(
                color: lightWhite, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          width: width * 0.15,
                          height: height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: color),
                          child: Icon(icon, color: white, size: 18.5)),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, left: 10),
                        child: SizedBox(
                          width: width * 0.45,
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: textBlackMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    FontAwesomeIcons.chevronRight,
                    color: black,
                    size: 17.5,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
