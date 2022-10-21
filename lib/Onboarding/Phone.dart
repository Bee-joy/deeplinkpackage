import 'package:deeplink/Custom/CustomClass.dart';
import 'package:deeplink/Model/CustomClassModel.dart';
import 'package:deeplink/Routes/Routes.dart';
import 'package:flutter/cupertino.dart';

class LoginWithPhone extends StatelessWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String contactNumber = "";
    return CustomClass(
      customClassModel: CustomClassModel(
          "Log in for the best experience",
          "Enter your phone number to continue",
          "00000 00000",
          "Phone Number ",
          "Use Email-ID",
          phoneTextfield: true,
          showPolicy: true),
      onChanged: (value) {
        contactNumber = value.countryCode + " " + value.number;
      },
      onContinuePressed: () {
        Routes.navigateToPage(context, Routes.LOGIN_OTP,
            arguments: contactNumber);
      },
      onPressedUseButton: () {
        Routes.navigateToPage(context, Routes.EMAIL_LOGIN);
      },
      editButton: () {
        Navigator.pop(context);
      },
    );
  }
}
