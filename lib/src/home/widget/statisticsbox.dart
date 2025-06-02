import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';

//Statistics Page
class StatisticBox extends StatelessWidget {
  const StatisticBox(
      {super.key,
      required this.width,
      required this.height,
      required this.itemWidth,
      required this.title,
      required this.color,
      required this.icon,
      required this.amountColor,
      required this.amount});

  final double width;
  final double itemWidth;
  final double height;
  final String title;
  final Color color, amountColor;
  final IconData icon;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: width * 0.45,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: width * 0.02,
                      backgroundColor: color,
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Text(
                      title,
                      style: textBlackMediumBold,
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      icon,
                      color: amountColor,
                      size: 15,
                    ),
                    Text(
                      amount,
                      style: textBlackMini.copyWith(
                          fontSize: 13.5,
                          color: amountColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              child: Stack(children: [
                Container(
                    width: itemWidth,
                    height: height * 0.02,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: color))
              ]),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: lightWhite),
              width: width * 0.97,
              height: height * 0.02,
            ),
          ),
        ],
      ),
    );
  }
}
