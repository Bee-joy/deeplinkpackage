import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Bloc/Bloc.dart';
import 'package:deeplink/Helper/Helper.dart';
import 'package:deeplink/Login/Event.dart';
import 'package:deeplink/Login/LoginBloc.dart';
import 'package:deeplink/Login/Referral.dart';
import 'package:deeplink/Login/Register.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:deeplink/Repository/RepositoryImpl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => RepositoryImpl(),
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
  final loginBloc = LoginBloc();
  bool isSuccess = false;

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBlocs(
        RepositoryProvider.of<Repository>(context),
      )..add(LoadEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFd1c9f3),
        body: BlocBuilder<LoginBlocs, LoginState>(
          builder: (context, state) {
            return Form(
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
                                    child: StreamBuilder<Map>(
                                        stream: loginBloc.loginStream,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData &&
                                              snapshot.data!['status'] ==
                                                  'processing') {
                                            isSuccess = true;
                                            status = false;
                                          } else if (snapshot.hasData &&
                                              snapshot.data!['status'] ==
                                                  'failed' &&
                                              !status) {
                                            isSuccess = false;
                                            WidgetsBinding.instance
                                                ?.addPostFrameCallback((_) {
                                              Helper.alertDialogWithCloseBtn(
                                                  context,
                                                  "Error!",
                                                  "Invalid Credential");
                                            });
                                            status = true;
                                          } else if (snapshot.hasData &&
                                              snapshot.data!['status'] ==
                                                  'success' &&
                                              !status) {
                                            WidgetsBinding.instance
                                                ?.addPostFrameCallback((_) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Referralpage()));
                                            });
                                            status = true;
                                          }

                                          return ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                loginBloc.eventSink.add(
                                                    LoginEvent(_email.text,
                                                        _password.text));
                                              }
                                            },
                                            child: isSuccess
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
                                                borderRadius:
                                                    BorderRadius.circular(
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
                                              builder: (context) => Register()),
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
            );
          },
        ),
      ),
    );
  }
}
