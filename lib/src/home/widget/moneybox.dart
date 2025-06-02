import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';


class MoneyBox extends StatelessWidget {
  const MoneyBox({
    super.key,
    required this.height,
    required this.width,
    required this.amount,
    required this.title,
    required this.color,
    required this.icon,
  });

  final double height;
  final double width;
  final String amount, title;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width * 0.45,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Icon(
                icon,
                color: color,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: white),
              height: height * 0.065,
              width: width * 0.15,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.0165,
              ),
              Text(
                title,
                style: textWhiteMedium,
              ),
              Text(
                amount,
                style: textWhiteMediumBold,
              )
            ],
          )
        ],
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
    );
  }
}
