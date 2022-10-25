import 'package:deeplink/Custom/CustomClass.dart';
import 'package:deeplink/Model/CustomClassModel.dart';
import 'package:deeplink/Routes/Routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);
  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String contactNumber = "";
    return Form(
      key: _formKey,
      child: CustomClass(
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
          if (_formKey.currentState!.validate()) {
            Routes.navigateToPage(context, Routes.LOGIN_OTP,
                arguments: contactNumber);
          }
        },
        onPressedUseButton: () {
          Routes.navigateToPage(context, Routes.EMAIL_LOGIN);
        },
        editButton: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
