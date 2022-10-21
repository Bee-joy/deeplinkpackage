import 'dart:ffi';

import 'package:deeplink/Model/CustomClassModel.dart';
import 'package:deeplink/Custom/CustomField.dart';
import 'package:deeplink/Utilities/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomClass extends StatelessWidget {
  final Function()? onContinuePressed;
  final Function()? onPressedUseButton;
  final Function()? editButton;
  final Function(dynamic)? onChanged;
  final CustomClassModel customClassModel;

  CustomClass(
      {Key? key,
      this.editButton,
      this.onChanged,
      required this.customClassModel,
      this.onContinuePressed,
      this.onPressedUseButton})
      : super(key: key);
  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(top: 5),
          child: Icon(
            Icons.close,
            size: 20,
          ),
        ),
        title: const Text("Rayy"),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container(height: 4.0, color: const Color(0xff01877F2)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(customClassModel!.title,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff0343739),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Open Sans',
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text(customClassModel!.description,
                            style: const TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: Color(0xff08C8E8F),
                              fontFamily: 'Open Sans',
                            )),
                        customClassModel.editOption == true
                            ? Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: InkWell(
                                  child: const Text("Edit",
                                      style:
                                          TextStyle(color: Color(0xff26458C))),
                                  onTap: editButton,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        customClassModel.fieldTitle,
                        style: const TextStyle(color: Color(0xff8A8A8A)),
                      )),
                  customClassModel.phoneTextfield == true
                      ? SizedBox(
                          height: 70,
                          child: IntlPhoneField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                                LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '00000 00000',
                                  hintStyle:
                                      TextStyle(color: Color(0xff0EFEFEF))),
                              initialCountryCode: 'IN',
                              onChanged: onChanged),
                        )
                      : TextFormField(
                          controller: textFieldController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: customClassModel!.hintText,
                              hintStyle:
                                  const TextStyle(color: Color(0xff0EFEFEF))),
                          onChanged: onChanged,
                        ),
                  InkWell(
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          customClassModel.nextFormTitle,
                          style: const TextStyle(color: Color(0xff26458C)),
                        )),
                    onTap: onPressedUseButton,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customClassModel.showPolicy == true
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                                width: 320,
                                height: 20,
                                child: Align(
                                  child: RichText(
                                      text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "By continuing you agree to our ",
                                        style: TextStyle(
                                          color: Color(0xff08C8E8F),
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                          text: "T&C",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black,
                                              fontSize: 13,
                                              decorationThickness: 1,
                                              decorationStyle:
                                                  TextDecorationStyle.solid)),
                                      TextSpan(
                                        children: [
                                          WidgetSpan(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 2),
                                                  child: Text("and")),
                                              style: TextStyle(
                                                  color: Color(0xff08C8E8F),
                                                  fontSize: 13,
                                                  height: 1.5))
                                        ],
                                      ),
                                      TextSpan(
                                          text: " Privacy",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black,
                                              fontSize: 13,
                                              decorationThickness: 1,
                                              decorationStyle:
                                                  TextDecorationStyle.solid)),
                                    ],
                                  )),
                                )),
                          )
                        : SizedBox(),
                    CustomElevatedButton(
                      onButtonClicked: onContinuePressed,
                      backgroundColor: Color(0xff0312A91),
                      textColor: whiteColor,
                      title: 'Continue',
                    ),
                    const SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
