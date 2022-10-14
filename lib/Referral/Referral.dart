import 'package:deeplink/Bloc/App_Event.dart';
import 'package:deeplink/Bloc/App_State.dart';
import 'package:deeplink/Bloc/LoginBloc.dart';
import 'package:deeplink/Referral/Refer.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:deeplink/WebView/WebViewUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';

class Referralpage extends StatelessWidget {
  const Referralpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => Repository(),
        child: ReferralpageUI(),
      ),
    );
  }
}

class ReferralpageUI extends StatefulWidget {
  const ReferralpageUI({Key? key}) : super(key: key);
  @override
  State<ReferralpageUI> createState() => _ReferralpageUIState();
}

class _ReferralpageUIState extends State<ReferralpageUI> {
  Refer refer = Refer();
  String? invitationUrl;
  @override
  void initState() {
    super.initState();
    getReferralLink();
  }

  void getReferralLink() async {
    invitationUrl = await refer.generateLink(Refer.referCode);
  }

  Future<void> _share(invitationLink, titleText, desc) async {
    try {
      FlutterShare.share(
        text: desc,
        title: titleText,
        linkUrl: invitationLink,
      );
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        context.read<Repository>(),
      ),
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
                width: 250,
                child: ElevatedButton(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.share,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Invite your Friend and Earn',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    _share(invitationUrl, "test", "use my referrer link");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                width: 250,
                child: ElevatedButton(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.web,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'WebView',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    minimumSize: const Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WebViewUI()));
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<LoginBloc, AppState>(builder: (context, state) {
                return SizedBox(
                  height: 40,
                  width: 250,
                  child: ElevatedButton(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.web,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(GoogleLogOut(context));
                    },
                  ),
                );
              }),
            ],
          ),
        )),
      ),
    );
  }
}
