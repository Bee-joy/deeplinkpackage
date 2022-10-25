import 'package:deeplink/Custom/CustomClass.dart';
import 'package:deeplink/Model/CustomClassModel.dart';
import 'package:flutter/cupertino.dart';

class EmailpasswordPage extends StatefulWidget {
  String email;
  EmailpasswordPage(this.email, {Key? key}) : super(key: key);

  @override
  State<EmailpasswordPage> createState() => _EmailpasswordPageState();
}

class _EmailpasswordPageState extends State<EmailpasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: CustomClass(
        customClassModel: CustomClassModel("Please Enter password for",
            widget.email, "XXXXXXXXX", "Password", "Use Code",
            editOption: true, showPolicy: false),
        obsureText: true,
        onContinuePressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pop(context);
          }
        },
        onPressedUseButton: () {},
        editButton: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
