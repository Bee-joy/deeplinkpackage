import 'package:deeplink/Utilities/Color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    this.hintText,
    this.errorText,
    this.onChanged,
    this.keyboardType,
    this.autoFocus = true,
    this.obscureText = false,
    this.OnFieldSubmitted,
    this.initalValue,
    this.validator,
    this.inputFormatters,
    this.focusNode,
  }) : super(key: key);
  final bool autoFocus;
  final String? hintText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final Function(String)? onChanged;
  final Function(String)? OnFieldSubmitted;
  final String Function(String?)? validator;
  final String? initalValue;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textAlign: TextAlign.center,
      focusNode: focusNode,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onFieldSubmitted: OnFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return "Please enter blank field";
            }
            return null;
          },
      initialValue: initalValue,
      inputFormatters: inputFormatters,
      style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: primaryColor),
      decoration: InputDecoration(
          border: const UnderlineInputBorder(), labelText: hintText),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.title,
    this.image = '',
    this.backgroundColor = whiteColor,
    this.onButtonClicked,
    this.textColor = Colors.black,
  }) : super(key: key);
  final String? title;
  final String? image;
  final Function()? onButtonClicked;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Container(
        color: backgroundColor,
        width: MediaQuery.of(context).size.width * 0.9,
        height: 55,
        child: ElevatedButton(
          onPressed: onButtonClicked,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image!.isNotEmpty
                  ? Image.asset(
                      image!,
                      height: 20,
                      width: 20,
                    )
                  : const SizedBox(),
              const SizedBox(width: 10),
              Text(
                title!,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                    color: textColor!),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(1), // <-- Radius
            ),
          ),
        ),
      ),
    );
  }
}
