import 'package:flutter/material.dart';

import '../constant.dart';
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String validatorText;
  final bool obsecure;
  final TextInputType keyboardType;
  final bool isMulti;
  final bool autofocus;
  final Icon icon;
  final String hint;
  final bool enabled;
  final Function onTap;
  final double padding;
  final double margin;

  const MyTextField({
    Key? key,
    this.hint='',
    required this.controller,
    required this.validatorText,
    this.keyboardType = TextInputType.text,
    this.obsecure = false,
    this.isMulti = false,
    this.autofocus = false,
    this.enabled = true,
    required this.icon,
    required this.onTap,
    this.padding = 30.0,
    this.margin = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        autofocus: autofocus,
        onTap: onTap as Function(),
        minLines: isMulti ? 4 : 1,
        maxLines: isMulti ? null : 1,
        enabled: enabled,
        obscureText: obsecure,
        keyboardType: keyboardType,

        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorText;
          }
          return null;
        },
        cursorColor: Colors.grey[200],
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(color:Colors.white70 ),
          hintText: hint,
          fillColor: Colors.black54,
          prefixIcon: icon,
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide( color: Colors.white70)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide( color:Colors.white70)),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        ),
        style: TextStyle(fontSize: 18.0, height: 2.0, color: Colors.white70),
      ),
    );
  }
}