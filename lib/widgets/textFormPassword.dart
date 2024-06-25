import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';


import '../constants/Appcolor.dart';

class textFieldWith_icon_ObscureText extends StatefulWidget {
  const textFieldWith_icon_ObscureText({
    super.key,
    required TextEditingController textEditingController,
    required this.title,

  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String title;


  @override
  State<textFieldWith_icon_ObscureText> createState() => _textFieldWith_icon_ObscureTextState();
}

class _textFieldWith_icon_ObscureTextState extends State<textFieldWith_icon_ObscureText> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._textEditingController,
      keyboardType: TextInputType.emailAddress,
      obscureText: _obscureText,
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(borderSide:BorderSide(
            width: 1,
            color: Colors.grey
          )),
        hintText: widget.title,
        filled: true,
        fillColor:  Colors.transparent,

        prefixIcon: Icon(IconlyLight.lock, color: Colors.grey,size: 30, ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },

        ),

      ),

    );
  }
}
