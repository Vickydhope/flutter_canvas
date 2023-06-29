import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_canvas/paint/curve_painter.dart';
import 'package:flutter_canvas/view/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurvePainter(),
    ); /*Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.25),
        child: Center(
          child: Image.asset(appLogo),
        ),
      ),
    );*/
  }
}
