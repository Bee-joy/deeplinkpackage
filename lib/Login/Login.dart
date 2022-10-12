import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Bloc/LoginBloc.dart';
import 'package:deeplink/Helper/Helper.dart';
import 'package:deeplink/Login/Register.dart';
import 'package:deeplink/Referral/Referral.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void initFirebaseNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Helper.dialog(
          message.notification!.title, message.notification!.body, context);
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        //when user tap on the notification
      });
    });
  }

  @override
  void initState() {
    setState(() {
      initFirebaseNotificationListener();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => Repository(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        context.read<Repository>(),
      ),
      child: Scaffold(
          backgroundColor: const Color(0xFFd1c9f3),
          body: BlocListener<LoginBloc, AppState>(
            listener: (context, state) {
              if (state is ErrorState) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  Helper.alertDialogWithCloseBtn(
                      context, "Error!", "Invalid Credential");
                });
              } else if (state is LoadedState) {
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
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 14, right: 14, bottom: 100),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .5,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 8, right: 15, left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: TextFormField(
                              controller: _email,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: TextFormField(
                              obscureText: true,
                              controller: _password,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: BlocBuilder<LoginBloc, AppState>(
                                        builder: (context, state) {
                                      return ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<LoginBloc>(context)
                                                .add(LoginEvent(_email.text,
                                                    _password.text));
                                          }
                                        },
                                        child: state is LoadingState
                                            ? const SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : const Text('Login'),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(100, 40),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                12), // <-- Radius
                                          ),
                                        ),
                                      );
                                    })),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Register()),
                                        );
                                      },
                                      child: const Text('Register'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(100, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12), // <-- Radius
                                        ),
                                      ),
                                    )),
                              ])
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
