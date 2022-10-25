import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Bloc/LoginBloc.dart';
import 'package:deeplink/Helper/Helper.dart';
import 'package:deeplink/Custom/CustomField.dart';
import 'package:deeplink/Referral/Referral.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:deeplink/Routes/Routes.dart';
import 'package:deeplink/Utilities/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginOtp extends StatefulWidget {
  String contactNumber;
  LoginOtp(this.contactNumber, {Key? key}) : super(key: key);
  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => Repository(),
        child: LoginOtpPage(widget.contactNumber),
      ),
    );
  }
}

class LoginOtpPage extends StatefulWidget {
  String contactNumber;
  LoginOtpPage(this.contactNumber, {Key? key}) : super(key: key);

  @override
  State<LoginOtpPage> createState() => _LoginOtpPageState();
}

class _LoginOtpPageState extends State<LoginOtpPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode textFieldOne = FocusNode();
  FocusNode textFieldTwo = FocusNode();
  FocusNode textFieldThree = FocusNode();
  FocusNode textFieldFour = FocusNode();
  FocusNode textFieldFive = FocusNode();
  void otp(value) {
    setState(() {
      if (value.isNotEmpty) {
        otpList.add(value);
      } else {
        otpList.removeAt(0);
      }
    });
    if (otpList.length >= 5) {
      validationTextVisibility(false);
    }
  }

  void validationTextVisibility(value) {
    setState(() {
      validationTextVisible = value;
    });
  }

  bool validationTextVisible = false;
  List otpList = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        context.read<Repository>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
        body: BlocListener<LoginBloc, AppState>(
          listener: (context, state) {
            if (state is ErrorState) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Helper.alertDialogWithCloseBtn(
                    context, "Error!", "Invalid Credential");
              });
            } else if (state is LoadedState) {
              if (state.login) {
                const GoogleLogin();
              }
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Referralpage()));
              });
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(height: 4.0, color: const Color(0xff01877F2)),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Please enter the verification code ",
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              color: Color(0xff08C8E8F),
                              fontFamily: 'Open Sans',
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(widget.contactNumber,
                                style: const TextStyle(
                                    fontFamily: "Open Sans",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: Color(0xff0343739),
                                    decorationStyle:
                                        TextDecorationStyle.solid)),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/edit.png",
                                  height: 22,
                                ),
                                const SizedBox(width: 8),
                                const Text("Edit",
                                    style: TextStyle(color: Color(0xff26458C)))
                              ],
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "OTP",
                            style: TextStyle(color: Color(0xff8A8A8A)),
                          )),
                      Row(
                        children: [
                          Expanded(
                              child: CustomFormField(
                            autoFocus: true,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            onChanged: (value) {
                              otp(value);
                              textFieldTwo.requestFocus();
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                              LengthLimitingTextInputFormatter(1)
                            ],
                            focusNode: textFieldOne,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomFormField(
                            autoFocus: true,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            onChanged: (value) {
                              otp(value);
                              textFieldThree.requestFocus();
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                              LengthLimitingTextInputFormatter(1)
                            ],
                            focusNode: textFieldTwo,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomFormField(
                            autoFocus: true,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            onChanged: (value) {
                              otp(value);
                              textFieldFour.requestFocus();
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                              LengthLimitingTextInputFormatter(1)
                            ],
                            focusNode: textFieldThree,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomFormField(
                            autoFocus: true,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            onChanged: (value) {
                              otp(value);
                              textFieldFive.requestFocus();
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                              LengthLimitingTextInputFormatter(1)
                            ],
                            focusNode: textFieldFour,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: CustomFormField(
                            autoFocus: true,
                            keyboardType: TextInputType.phone,
                            obscureText: false,
                            onChanged: (value) {
                              otp(value);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9]')),
                              LengthLimitingTextInputFormatter(1)
                            ],
                            focusNode: textFieldFive,
                          )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      validationTextVisible
                          ? const Text("Please enter the OTP",
                              style: TextStyle(
                                color: Colors.red,
                              ))
                          : const SizedBox()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Use Password",
                        style: TextStyle(color: Color(0xff26458C)),
                      ),
                      Text(
                        "Resend Code",
                        style: TextStyle(color: Color(0xff26458C)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomElevatedButton(
                      onButtonClicked: () {
                        if (otpList.length >= 5) {
                          Routes.navigateToPage(
                            context,
                            Routes.LOCATION,
                          );
                        } else {
                          validationTextVisibility(true);
                        }
                      },
                      backgroundColor: const Color(0xff0312A91),
                      textColor: whiteColor,
                      title: 'Verify',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
