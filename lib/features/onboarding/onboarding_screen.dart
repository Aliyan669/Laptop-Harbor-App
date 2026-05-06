import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:laptop_harbor_app/features/home/home_screen.dart';
// import 'package:miniproject/pages/home/home.dart';
// import 'package:miniproject/pages/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_cRlBsGB5xMFTG9Gin13tJPfDmudoG0xqqg&s',
            width: 250,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_cRlBsGB5xMFTG9Gin13tJPfDmudoG0xqqg&s',
            width: 250,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Fractional shares",
          body:
              "Instead of having to buy an entire share, invest any amount you want.",
          image: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_cRlBsGB5xMFTG9Gin13tJPfDmudoG0xqqg&s',
            width: 250,
          ),
          decoration: pageDecoration,
        ),
      ],

      onDone: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isfirst', true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      },
      onSkip: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isfirst', true);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }, // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,

      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Text('Next', style: TextStyle(fontWeight: FontWeight.w600)),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,

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


