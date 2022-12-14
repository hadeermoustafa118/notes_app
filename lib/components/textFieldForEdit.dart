import 'package:flutter/material.dart';
import 'package:notes_app/presentation/colorManager.dart';

import '../constant.dart';
class TextFieldForEdit extends StatelessWidget {
  const TextFieldForEdit({Key? key  ,this.hint='',
   // required this.controller,
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
required this.save,
    required this.init
  }) : super(key: key);
 // final TextEditingController controller;
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
//final VoidCallback save;
  final void Function(String?)? save;
final String init;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: margin),
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
       onChanged: save,
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
        cursorColor: isDark? ColorManager.dartColor:Colors.grey[200],
        initialValue: init,
        //controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: isDark? Colors.black: Colors.white70 ),
          hintText: hint,
          fillColor: isDark? ColorManager.lightColor:ColorManager.dartColor,
          prefixIcon: icon,
          prefixIconColor: isDark? ColorManager.dartColor: ColorManager.lightColor,
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide( color: isDark? ColorManager.dartColor: Colors.white70)),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide( color:isDark? ColorManager.dartColor: Colors.white70)),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        ),
        style: TextStyle(fontSize: 18.0, height: 2.0, color:isDark? ColorManager.dartColor: Colors.white70),
      ),
    );
  }
}
