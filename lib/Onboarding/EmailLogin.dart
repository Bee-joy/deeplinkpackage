import 'package:deeplink/Custom/CustomClass.dart';
import 'package:deeplink/Model/CustomClassModel.dart';
import 'package:deeplink/Routes/Routes.dart';
import 'package:flutter/cupertino.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = 'bbijay020@gmail.com';
    return CustomClass(
      customClassModel: CustomClassModel(
          "Log in for the best experience",
          "Enter your Email ID to continue",
          "@mail.com",
          "Email ID",
          "Use Phone Number",
          showPolicy: true),
      onContinuePressed: () {
        Routes.navigateToPage(context, Routes.EMAIL_PASSWORD, arguments: email);
      },
      onChanged: (value) {
        email = value;
      },
      onPressedUseButton: () {
        Routes.navigateToPage(context, Routes.LOGIN_WITH_PHONE);
      },
    );
  }
}
