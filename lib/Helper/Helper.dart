import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper {
  static void dialog(BuildContext context, String? title, String? description) {
    try {
      showGeneralDialog(
        barrierLabel: "Label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: const Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pop(context);
          });
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title!,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12.0,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      description!,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12.0,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
                Tween(begin: const Offset(0, 0), end: const Offset(0, 0.05))
                    .animate(anim1),
            child: child,
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static showToast(message, {color}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color ?? Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static alertDialogWithCloseBtn(BuildContext context, title, description) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24, color: Colors.black, fontFamily: 'intel'),
            ),
            contentPadding: const EdgeInsets.all(4),
            content: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16, color: Colors.blue, fontFamily: 'intel'),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }
}
