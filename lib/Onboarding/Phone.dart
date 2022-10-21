import 'package:deeplink/Onboarding/CustomField.dart';
import 'package:deeplink/Utilities/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  final _formKey = GlobalKey<FormState>();
  late String contactNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(
            Icons.close,
            size: 20,
          ),
        ),
        title: const Text("Rayy"),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container(height: 4.0, color: const Color(0xff01877F2)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Log in for the best experience",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff0343739),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Open Sans',
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text("Enter your phone number to continue ",
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xff08C8E8F),
                          fontFamily: 'Open Sans',
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Phone Number",
                        style: TextStyle(color: Color(0xff8A8A8A)),
                      )),
                  SizedBox(
                    height: 70,
                    child: IntlPhoneField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        LengthLimitingTextInputFormatter(10)
                      ],
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '00000 00000',
                          hintStyle: TextStyle(color: Color(0xff0EFEFEF))),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        contactNumber = phone.countryCode + " " + phone.number;
                      },
                    ),
                  ),
                  const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Use Email-ID",
                        style: TextStyle(color: Color(0xff26458C)),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: SizedBox(
                width: 320,
                height: 20,
                child: Align(
                  child: RichText(
                      text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "By continuing you agree to our ",
                        style: TextStyle(
                          color: Color(0xff08C8E8F),
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                          text: "T&C",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontSize: 13,
                              decorationThickness: 1,
                              decorationStyle: TextDecorationStyle.solid)),
                      TextSpan(
                        children: [
                          WidgetSpan(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 2),
                                  child: Text("and")),
                              style: TextStyle(
                                  color: Color(0xff08C8E8F),
                                  fontSize: 13,
                                  height: 1.5))
                        ],
                      ),
                      TextSpan(
                          text: " Privacy",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontSize: 13,
                              decorationThickness: 1,
                              decorationStyle: TextDecorationStyle.solid)),
                    ],
                  )),
                )),
          ),
          CustomElevatedButton(
            onButtonClicked: () {},
            backgroundColor: Color(0xff0312A91),
            textColor: whiteColor,
            title: 'Continue',
          ),
        ],
      ),
    );
  }
}
