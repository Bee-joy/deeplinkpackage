import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class Refer {
  static String referCode = '';
  Future<String> generateLink(String referCode) async {
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

    return dynamicLink.shortUrl.toString();
  }

  String generateCode(String prefix) {
    Random random = Random();
    var id = random.nextInt(92143543) + 0945123456;
    return '$prefix-${(id.toString().substring(0, 8))}';
  }

  Future<void> getRefererCode(String? uid) async {
    final docSnapshots = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();
    final user = docSnapshots.docs.first;
    if (user.exists) {
      referCode = user.data()['refer_code'];
    }
  }

  Future<void> rewardUser(String? currentUserId, String referrerCode) async {
    try {
      final referer = await getreferrerUser(referrerCode);
      final checkUserAlreadyExist = await FirebaseFirestore.instance
          .collection("users")
          .doc(referer['uid'])
          .collection('referrers')
          .doc(currentUserId)
          .get();
      if (!checkUserAlreadyExist.exists) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(referer['uid'])
            .collection("referrers")
            .doc(currentUserId)
            .set({
          "uid": currentUserId,
          "createdAt": DateTime.now().toUtc().microsecondsSinceEpoch,
        });
      }
      await FirebaseFirestore.instance
          .collection("users")
          .doc(referer['uid'])
          .update({"reward": FieldValue.increment(100)});
    } catch (e) {
      print(e);
    }
  }

  Future getreferrerUser(String referCode) async {
    final docSnapshots = await FirebaseFirestore.instance
        .collection("users")
        .where("refer_code", isEqualTo: referCode)
        .get();
    final user = docSnapshots.docs.first;
    if (user.exists) {
      return user.data();
    } else {
      return null;
    }
  }
}
