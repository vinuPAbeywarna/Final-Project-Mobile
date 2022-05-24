import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroDuctionPage extends StatefulWidget {
  final Widget screen;

  const IntroDuctionPage({
    Key? key,
    required this.screen,
  }) : super(key: key);
  @override
  _IntroDuctionPageState createState() => _IntroDuctionPageState();
}

class _IntroDuctionPageState extends State<IntroDuctionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const bodyStyle = TextStyle(
        fontSize: 19.0, fontWeight: FontWeight.w400, color: Colors.black54);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w600),
      bodyTextStyle: bodyStyle,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 0),
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,

      key: introKey,
      pages: [
        PageViewModel(
          decoration: pageDecoration,
          title: "The biggest online Shop",
          body:
              "What was the last time you had an exciting and rewarding online shopping experience? Can't remember!.How about we make it even more convenient, fast and affordable to fulfill all your buying needs",
          image: Padding(
            padding: EdgeInsets.only(top: size.height * 0.01, bottom: 0),
            child: Align(
              child: Image.asset('assets/icons/onlineshopping.png',
                  width: size.width * 0.7),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
        PageViewModel(
          decoration: pageDecoration,
          title: "8 plus item categories",
          body: "Offers practical and effective pest control solutions.",
          image: Padding(
            padding: EdgeInsets.only(top: size.height * 0.01, bottom: 0),
            child: Align(
              child: Image.asset('assets/icons/categories.png',
                  width: size.width * 0.7),
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      onDone: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => widget.screen));
      },
      // onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,

      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w800)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
