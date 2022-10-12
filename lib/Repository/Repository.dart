import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deeplink/Referral/Refer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {
  static String? referCode;
  final _auth = FirebaseAuth.instance;
  Refer refer = Refer();

  Future login(String email, String password) async {
    UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (authResult.user != null) {
      DocumentSnapshot userSnapShot = await FirebaseFirestore.instance
          .collection("users")
          .doc(authResult.user?.uid)
          .get();
      refer.getRefererCode(authResult.user?.uid);
      if (userSnapShot.exists) {
        print(userSnapShot.data());
      }
    }
  }

  Future registerUser(
      String name, String email, String password, String referralCode) async {
    final uid = await signup(email, password);
    final referCode = refer.generateCode("refer");
    final referLink = await refer.generateLink(referCode);
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'uid': uid,
      'refer_link': referLink,
      'refer_code': referCode,
      'reward': 0
    });
    if (referralCode.isNotEmpty) {
      await refer.rewardUser(uid, referralCode);
    }
  }

  Future<String?> signup(String email, String password) async {
    final currentUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final uid = currentUser.user?.uid;
    return uid;
  }
}
