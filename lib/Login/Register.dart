import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Bloc/LoginBloc.dart';
import 'package:deeplink/Helper/Helper.dart';
import 'package:deeplink/Login/Login.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:deeplink/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => Repository(),
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();

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
                Helper.alertDialogWithCloseBtn(context, "Error!",
                    "Email already exists or password must be more then 6 character");
              });
            } else if (state is LoadedState) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Helper.alertDialogWithCloseBtn(
                    context, "Error!", "User successfully registered");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
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
                    padding: const EdgeInsets.only(top: 8, right: 15, left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: TextFormField(
                            controller: _username,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Username',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: TextFormField(
                            controller: _email,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: TextFormField(
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
                                        if (_formKey.currentState!.validate()) {
                                          BlocProvider.of<LoginBloc>(context)
                                              .add(RegisterEvent(
                                                  _username.text,
                                                  _email.text,
                                                  _password.text,
                                                  MyApp.referralCode ?? ''));
                                        }
                                      },
                                      child: state is LoadingState
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Text('Register'),
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
                                                const Login()),
                                      );
                                    },
                                    child: const Text('Login'),
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
        ),
      ),
    );
  }
}
