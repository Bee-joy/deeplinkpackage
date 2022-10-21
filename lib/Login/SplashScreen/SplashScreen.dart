import 'package:deeplink/Routes/Routes.dart';
import 'package:deeplink/Utilities/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        systemNavigationBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light));
    super.initState();
    Future.delayed(const Duration(seconds: 2),
        () => Routes.navigateToPage(context, Routes.ONBOARDING_SCREEN));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/RayLogo.png",
                  height: 100,
                  width: 150,
                ))
          ],
        ),
      ),
    );
  }
}
