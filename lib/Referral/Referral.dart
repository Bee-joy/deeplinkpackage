import 'package:deeplink/Referral/Refer.dart';
import 'package:deeplink/WebView/WebViewUi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class Referralpage extends StatefulWidget {
  const Referralpage({Key? key}) : super(key: key);
  @override
  State<Referralpage> createState() => _ReferralpageState();
}

class _ReferralpageState extends State<Referralpage> {
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
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          FlatButton(
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
                  'Share',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            onPressed: () {
              _share(invitationUrl, "test", "lets play use my referrer link");
            },
          ),
          FlatButton(
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
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WebViewUI()));
            },
          ),
        ],
      )),
    );
  }
}
