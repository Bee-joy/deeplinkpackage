import 'package:deeplink/Login/Register.dart';
import 'package:deeplink/Login/SplashScreen/SplashScreen.dart';
import 'package:deeplink/Onboarding/EmailLogin.dart';
import 'package:deeplink/Onboarding/EmailPasswordPage.dart';
import 'package:deeplink/Onboarding/Location.dart';
import 'package:deeplink/Onboarding/LoginOTP.dart';
import 'package:deeplink/Onboarding/LoginOption.dart';
import 'package:deeplink/Onboarding/OnboardingScreen.dart';
import 'package:deeplink/Onboarding/Phone.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String SPLASHSCREEN = "splashscreen";
  static const String ONBOARDING_SCREEN = "onboardingscreen";
  static const String LOGIN_OPTION = "loginoption";
  static const String LOGIN_OTP = "loginotp";
  static const String LOCATION = "location";
  static const String EMAIL_LOGIN = "emaillogin";
  static const String EMAIL_PASSWORD = "emailpassword";
  static const String LOGIN_WITH_PHONE = "loginwithphone";
  static Map<String, WidgetBuilder> all = <String, WidgetBuilder>{
    '/test1': (BuildContext context) => const Register(),
  };

  static navigateToPage(BuildContext context, String route,
      {dynamic? arguments}) {
    Navigator.push(context,
        generateRoute(RouteSettings(name: route, arguments: arguments)));
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.SPLASHSCREEN:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.ONBOARDING_SCREEN:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.LOGIN_OPTION:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.LOCATION:
        return MaterialPageRoute(builder: (_) => Location());
      case Routes.EMAIL_LOGIN:
        return MaterialPageRoute(builder: (_) => const EmailLogin());
      case Routes.EMAIL_PASSWORD:
        return MaterialPageRoute(
            builder: (_) => EmailpasswordPage(settings.arguments.toString()));
      case Routes.LOGIN_WITH_PHONE:
        return MaterialPageRoute(builder: (_) => LoginWithPhone());
      case Routes.LOGIN_OTP:
        return MaterialPageRoute(
            builder: (_) => LoginOtp(settings.arguments.toString()));
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
