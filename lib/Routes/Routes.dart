import 'package:deeplink/Login/Register.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> all = <String, WidgetBuilder>{
    '/test1': (BuildContext context) => const Register(),
  };
}
