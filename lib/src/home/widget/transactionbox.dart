import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';

//Transactions Box
class TransactionBox extends StatelessWidget {
  const TransactionBox({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.amount,
    required this.date,
    required this.description,
    required this.icon,
    required this.color,
  });

  final double height;
  final double width;
  final String title;
  final String description;
  final IconData icon;
  final String amount;
  final String date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 1),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.01, left: 10, right: 10, bottom: 8),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: width * 0.5,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textBlackMediumBold.copyWith(fontSize: 14),
                      ),
                    ),
                    Container(
                      width: width * 0.37,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            icon,
                            color: color,
                            size: 15,
                          ),
                          Text(
                            amount,
                            style: textBlackMini.copyWith(
                                fontSize: 13.5,
                                color: color,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: width * 0.5,
                      child: Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textBlackMini.copyWith(
                            color: lightGrey, fontSize: 11.5),
                      ),
                    ),
                    Container(
                        width: width * 0.37,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            date,
                            style: textBlackMini.copyWith(
                                color: lightGrey, fontSize: 9.5),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: lightWhite, borderRadius: BorderRadius.circular(10)),
        width: width * 1,
        height: height * 0.09,
      ),
    );
  }
}

class TransactionBox1 extends StatelessWidget {
  const TransactionBox1({
    super.key,
    required this.height,
    required this.width,
    required this.type,
    required this.amount,
    required this.date,
    required this.icon,
    required this.color,
  });

  final double height;
  final double width;
  final String type;

  final IconData icon;
  final String amount;
  final String date;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 1),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Icon(
                  icon,
                  color: white,
                ),
                width: width * 0.15,
                height: height * 0.05,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              Text(
                amount,
                style: textBlackMini.copyWith(
                    fontSize: 13.5, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                type,
                style: textBlackMini.copyWith(
                    fontSize: 13.5, color: black, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: lightWhite, borderRadius: BorderRadius.circular(10)),
        width: width * 1,
        height: height * 0.08,
      ),
    );
  }
}
