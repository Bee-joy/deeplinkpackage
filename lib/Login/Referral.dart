import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deeplink/Login/LoginBloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class Referralpage extends StatefulWidget {
  const Referralpage({Key? key}) : super(key: key);

  @override
  State<Referralpage> createState() => _ReferralpageState();
}

class _ReferralpageState extends State<Referralpage> {
  LoginBloc bloc = LoginBloc();
  String generateCode(String prefix) {
    Random random = Random();
    var id = random.nextInt(92143543) + 0945123456;
    return '$prefix-${(id.toString().substring(0, 8))}';
  }

  String invitationUrl = '';
  void generateLink(String? referCode) async {
    var invitationLink = 'https://rayydeeplink.page.link/refer?code=$referCode';
    final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse(invitationLink),
        uriPrefix: 'https://rayydeeplink.page.link',
        androidParameters: const AndroidParameters(
            packageName: "com.beejoy.app", minimumVersion: 20),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: "REFER A FRIEND AND EARN",
            description: "EARN RS 1000",
            imageUrl: Uri.parse(
                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")));
    var dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    setState(() {
      invitationUrl = dynamicLink.shortUrl.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      generateLink(LoginBloc.referCode);
    });
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
              _share(invitationUrl, "test",
                  "lets play use my rederrer link :$invitationUrl");
            },
          ),
          FlatButton(
            child: Row(
              children: const [
                Icon(
                  Icons.logout,
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
            onPressed: () {
              bloc.logout();
            },
          ),
        ],
      )),
    );
  }
}
