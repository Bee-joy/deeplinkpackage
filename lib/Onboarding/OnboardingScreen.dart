import 'package:deeplink/Routes/Routes.dart';
import 'package:deeplink/Utilities/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(height: 4.0, color: cyanBlue),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Onboarding screen 1",
                          style: TextStyle(
                              color: philippineGray,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Open Sans',
                              fontStyle: FontStyle.normal))),
                  const SizedBox(
                    height: 14,
                  ),
                  const Text(
                      "Discover traveller \nrecommended spots near you, whenever you are.",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff0343739),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Open Sans',
                          fontStyle: FontStyle.normal)),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: ElevatedButton(
                          child: IconButton(
                            onPressed: () {
                              Routes.navigateToPage(
                                  context, Routes.LOGIN_OPTION);
                            },
                            icon: const Icon(
                              CupertinoIcons.forward,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Routes.navigateToPage(context, Routes.LOGIN_OPTION);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Press back again to exit'",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
