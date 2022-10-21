import 'package:country_codes/country_codes.dart';
import 'package:deeplink/Login/Login.dart';
import 'package:deeplink/Login/SplashScreen/SplashScreen.dart';
import 'package:deeplink/Onboarding/LoginOption.dart';
import 'package:deeplink/Onboarding/Phone.dart';
import 'package:deeplink/Routes/Routes.dart';
import 'package:deeplink/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static String? referralCode;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setState(() {
      getN();
      notificationSetting();
      initDynamicLinks();
    });
  }

  final FirebaseMessaging _notifications = FirebaseMessaging.instance;
  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    dynamicLinks.onLink.listen((dynamicLinkData) {
      handleDeepLink(dynamicLinkData);
      Get.toNamed(dynamicLinkData.link.queryParameters.values.first);
    }).onError((error) {
      print(error.message);
    });
  }

  Future<void> handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data.link;
    var isRefer = deepLink.pathSegments.contains('refer');
    if (isRefer) {
      var code = deepLink.queryParameters['code'];
      if (code != null) {
        MyApp.referralCode = code;
      }
    }
  }
  //  Future<void> handleDeepLink(PendingDynamicLinkData data) async {
  //   final Uri deepLink = data.link;
  //   var code = deepLink.queryParameters['refer'];
  //   print("code is $code");
  //   if (code != null) {
  //     MyApp.referralCode = code;
  //   }
  // }

  void notificationSetting() async {
    NotificationSettings settings = await _notifications.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> getN() async {
    print(await _notifications.getToken());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: Routes.all,
        debugShowCheckedModeBanner: false,
        title: 'Rayy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OnboardingScreen2());
  }
}
