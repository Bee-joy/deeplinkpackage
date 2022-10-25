import 'package:deeplink/Utilities/Color.dart';
import 'package:flutter/material.dart';

class FingerPrintLogin extends StatefulWidget {
  const FingerPrintLogin({Key? key}) : super(key: key);

  @override
  State<FingerPrintLogin> createState() => FingerPrintLoginState();
}

class FingerPrintLoginState extends State<FingerPrintLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rayy"),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () async {},
                      child: const Image(
                        height: 150,
                        image: AssetImage(
                          'assets/images/fingerprint.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Center(
                child: Text(
                  'TO USE FINGERPRINT LOGIN TAP HERE',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          )
        ],
      ),
    );
  }
}
