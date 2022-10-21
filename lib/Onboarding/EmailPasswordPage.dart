import 'package:deeplink/Custom/CustomClass.dart';
import 'package:deeplink/Model/CustomClassModel.dart';
import 'package:flutter/cupertino.dart';

class EmailpasswordPage extends StatelessWidget {
  String email;
  EmailpasswordPage(this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomClass(
      customClassModel: CustomClassModel("Please Enter password for", email,
          "XXXXXXXXX", "Password", "Use Code",
          editOption: true, showPolicy: false),
      onContinuePressed: () {},
      onPressedUseButton: () {},
      editButton: () {
        Navigator.pop(context);
      },
    );
  }
}
