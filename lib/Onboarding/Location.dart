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
import 'package:flutter_bloc/flutter_bloc.dart';

class Location extends StatefulWidget {
  Location({Key? key}) : super(key: key);
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => Repository(),
        child: LocationPage(),
      ),
    );
  }
}

class LocationPage extends StatefulWidget {
  LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        context.read<Repository>(),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
          child: Column(
            children: [
              Container(height: 4.0, color: const Color(0xff01877F2)),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "assets/images/location.png",
                        height: 100,
                        width: 70,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Discover traveller\nrecommended spots near you, whenever you are. ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff0343739),
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Open Sans',
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomElevatedButton(
                        onButtonClicked: () {
                          Routes.navigateToPage(context, Routes.EMAIL_LOGIN);
                        },
                        backgroundColor: const Color(0xff0312A91),
                        textColor: whiteColor,
                        title: 'Allow location data',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Not Now',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.transparent,
                              decorationColor: Colors.black,
                              shadows: [
                                Shadow(
                                    color: Colors.black, offset: Offset(0, -5))
                              ],
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dashed,
                              decorationThickness: 2)),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
