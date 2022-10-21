import 'package:deeplink/Login/Register.dart';
import 'package:deeplink/Login/SplashScreen/SplashScreen.dart';
import 'package:deeplink/Onboarding/LoginOption.dart';
import 'package:deeplink/Onboarding/OnboardingScreen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String SPLASHSCREEN = "splashscreen";
  static const String ONBOARDING_SCREEN = "onboardingscreen";
  static const String LOGIN_OPTION = "loginoption";

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
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
