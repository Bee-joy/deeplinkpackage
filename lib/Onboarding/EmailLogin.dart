import 'package:deeplink/Custom/CustomClass.dart';
import 'package:deeplink/Custom/Validator.dart';
import 'package:deeplink/Model/CustomClassModel.dart';
import 'package:deeplink/Routes/Routes.dart';
import 'package:flutter/cupertino.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String email = 'bbijay020@gmail.com';
    return Form(
      key: _formKey,
      child: CustomClass(
        customClassModel: CustomClassModel(
            "Log in for the best experience",
            "Enter your Email ID to continue",
            "@mail.com",
            "Email ID",
            "Use Phone Number",
            showPolicy: true),
        onContinuePressed: () {
          if (_formKey.currentState!.validate()) {
            Routes.navigateToPage(context, Routes.EMAIL_PASSWORD,
                arguments: email);
          }
        },
        validator: (value) {
          if (Validator.isValidEmail(value!)) {
            return null;
          } else if (value.isEmpty) {
            return "Please enter the email Id";
          }
          return "Please enter valid email Id";
        },
        onChanged: (value) {
          email = value;
        },
        onPressedUseButton: () {
          Routes.navigateToPage(context, Routes.LOGIN_WITH_PHONE);
        },
      ),
    );
  }
}
