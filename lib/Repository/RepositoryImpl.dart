import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deeplink/Repository/Repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositoryImpl extends Repository {
  static String? referCode;
  final _auth = FirebaseAuth.instance;
  @override
  Future login(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        DocumentSnapshot userSnapShot = await FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user?.uid)
            .get();

        getRefererCode(authResult.user?.uid);
        if (userSnapShot.exists) {
          print(userSnapShot.data());
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
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
}
