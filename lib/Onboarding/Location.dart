import 'package:deeplink/Custom/CustomField.dart';
import 'package:deeplink/Routes/Routes.dart';
import 'package:deeplink/Utilities/Color.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

void getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    LocationPermission asked = await Geolocator.requestPermission();
  } else {
    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: primaryColor,
        ),
        body: Column(
          children: [
            Container(height: 4.0, color: const Color(0xff01877F2)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/images/location.png",
                      height: 100,
                      width: 70,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Discover traveller\nrecommended spots near you, whenever you are. ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xff0343739),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Open Sans',
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                      onButtonClicked: () {
                        getCurrentLocation();
                        Routes.navigateToPage(context, Routes.EMAIL_LOGIN);
                      },
                      backgroundColor: const Color(0xff0312A91),
                      textColor: whiteColor,
                      title: 'Allow location data',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Not Now',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.transparent,
                            decorationColor: Colors.black,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -5))
                            ],
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dashed,
                            decorationThickness: 2)),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
