import 'package:candy_app/decoration.dart';
import 'package:candy_app/src/controller/usercontroller.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FinancialMessage extends StatefulWidget {
  const FinancialMessage({
    super.key,
  });

  @override
  State<FinancialMessage> createState() => _FinancialMessageState();
}

class _FinancialMessageState extends State<FinancialMessage> {
  List<String> financialMessages = [
    "Ready to save smarter ?",
    "Taking control of your finances.",
    "Your journey to financial well-being.",
    "Let's grow your wealth together.",
    "Making your money work for you.",
  ];
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Set the initial index randomly
    _currentIndex =
        DateTime.now().millisecondsSinceEpoch % financialMessages.length;

    // Set up the timer to change the message periodically (e.g., every 12 hours)
    const Duration changeInterval =
        Duration(minutes:3 ); // You can adjust this
    _timer = Timer.periodic(changeInterval, (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % financialMessages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Text(financialMessages[_currentIndex],
          maxLines: 2,
          style: textprimaryMedium.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold) // Adjust alignment as needed
          ),
    );
  }
}

class CustomGreeting extends StatelessWidget {
  CustomGreeting({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 1,
      height: height * 0.175,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: lightBlack),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello there",
                        style: textWhiteMedium,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      FinancialMessage(),
                    ],
                  ),
                  Icon(
                    FontAwesomeIcons.piggyBank,
                    color: white,
                    size: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
