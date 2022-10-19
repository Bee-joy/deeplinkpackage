import 'package:deeplink/WebView/WebView.dart';
import 'package:flutter/material.dart';

class WebViewUI extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //initFirebaseNotificationListener();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFd1c9f3),
        body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 14, right: 14, bottom: 100),
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width * .9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            child: const Icon(Icons.arrow_back,
                                color: Colors.black),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextFormField(
                          controller: _url,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.grey..withOpacity(0.8))),
                              labelText: "Enter the URL"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter URL';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WebViews(_url.text)));
                            }
                          },
                          child: const Text('Go'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        )
                      ])
                    ],
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
