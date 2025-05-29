import 'package:candy_app/decoration.dart';

import 'package:candy_app/src/auth/screen/loginpage.dart';
import 'package:candy_app/src/auth/widget/splash_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final LiquidController _liquidController = LiquidController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(children: [
      LiquidSwipe(
          waveType: WaveType.circularReveal,
          enableLoop: false,
          liquidController: _liquidController,
          onPageChangeCallback: (page) {
            setState(() {
              _currentPage = page;
            });
          },
          pages: [
            Slide(
              btnTitle: "Next",
              image: slide1,
              height: height,
              width: width,
              title: slide1MainText,
              subTitle: slide1SubText,
              onNextPage: () {
                _liquidController.animateToPage(page: 1);
              },
            ),
            Slide(
              btnTitle: "Next",
              image: slide2,
              height: height,
              width: width,
              title: slide2MainText,
              subTitle: slide2SubText,
              onNextPage: () {
                _liquidController.animateToPage(page: 2);
              },
            ),
            Slide(
              btnTitle: "Get Started",
              image: slide3,
              height: height,
              width: width,
              title: slide3MainText,
              subTitle: slide3SubText,
              onNextPage: () {
                Get.to(() => LoginPage());
              },
            )
          ]),
      Positioned(
        bottom: height * 0.015,
        left: width * 0.015,
        right: 0,
        child: SmoothPageIndicator(
          controller: PageController(
              keepPage: true, initialPage: _currentPage, viewportFraction: 1),
          count: 3,
          axisDirection: Axis.horizontal,
          effect: ExpandingDotsEffect(
              spacing: 8.0,
              radius: 20,
              dotWidth: width * 0.035,
              dotHeight: height * 0.01,
              paintStyle: PaintingStyle.fill,
              strokeWidth: 1.5,
              dotColor: lightBlack,
              activeDotColor: primaryColor),
        ),
      ),
    ]));
  }
}
