import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Bloc/LoginBloc.dart';
import 'package:deeplink/Helper/Helper.dart';
import 'package:deeplink/Custom/CustomField.dart';
import 'package:deeplink/Referral/Referral.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:deeplink/Routes/Routes.dart';
import 'package:deeplink/Utilities/Color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => Repository(),
        child: const LoginOption(),
      ),
    );
  }
}

class LoginOption extends StatefulWidget {
  const LoginOption({Key? key}) : super(key: key);

  @override
  State<LoginOption> createState() => _LoginOptionState();
}

class _LoginOptionState extends State<LoginOption> {
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
          actions: const [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 15, top: 14),
                child: Text('Skip',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.transparent,
                        decorationColor: Colors.white,
                        shadows: [
                          Shadow(color: Colors.white, offset: Offset(0, -5))
                        ],
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                        decorationThickness: 2)),
              ),
            )
          ],
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
                final user = FirebaseAuth.instance.currentUser!;
                if (user.uid != null) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Referralpage()));
                  });
                }
              }
            }
          },
          child: Column(
            children: [
              Container(height: 4.0, color: const Color(0xff01877F2)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text("Let’s get started ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff0343739),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Open Sans',
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                          "Sign in to see deals up to 50%, easily manage your current bookings, and so much more... ",
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Color(0xff08C8E8F),
                            fontFamily: 'Open Sans',
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<LoginBloc, AppState>(
                          builder: (context, state) {
                        return CustomElevatedButton(
                          onButtonClicked: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(const GoogleLogin());
                          },
                          title: 'Sign Up with Google',
                          image: "assets/images/_Google.png",
                          backgroundColor: whiteColor,
                        );
                      }),
                      const CustomElevatedButton(
                        title: 'Sign in with Facebook',
                        image: "assets/images/_Facebook.png",
                        backgroundColor: cyanBlue,
                        textColor: whiteColor,
                      ),
                      BlocBuilder<LoginBloc, AppState>(
                          builder: (context, state) {
                        return CustomElevatedButton(
                          onButtonClicked: () {
                            Routes.navigateToPage(
                                context, Routes.LOGIN_WITH_PHONE);
                          },
                          backgroundColor: whiteColor,
                          title: 'Sign in with phone number',
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              '________',
                            ),
                            Text(
                              ' Or ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Open Sans",
                                  fontStyle: FontStyle.normal),
                            ),
                            Text(
                              '________',
                            )
                          ],
                        ),
                      ),
                      BlocBuilder<LoginBloc, AppState>(
                          builder: (context, snapshot) {
                        return CustomElevatedButton(
                          onButtonClicked: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(const GoogleLogin());
                          },
                          backgroundColor: whiteColor,
                          title: 'Create your account',
                          textColor: primaryColor,
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                        width: 320,
                        height: 70,
                        child: Align(
                          child: RichText(
                              text: const TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "By signing in or creating on account,you agree with our ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    height: 1.5),
                              ),
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text("Terms & conditions",
                                          style: TextStyle(
                                              color: cyanBlue,
                                              fontSize: 13,
                                              decorationThickness: 1,
                                              decorationStyle:
                                                  TextDecorationStyle.solid)),
                                    ),
                                  )
                                ],
                              ),
                              TextSpan(
                                children: [
                                  WidgetSpan(
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 2),
                                          child: Text("and")),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          height: 1.5))
                                ],
                              ),
                              TextSpan(
                                  text: " Privacy Statement",
                                  style: TextStyle(
                                      color: cyanBlue,
                                      fontSize: 13,
                                      decorationThickness: 1,
                                      decorationStyle:
                                          TextDecorationStyle.solid)),
                            ],
                          )),
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
