import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';


import '../constants/Appcolor.dart';

class textField extends StatefulWidget {
   textField({
    super.key,
    required TextEditingController textEditingController,
    required this.title, required this.prefixIcon,

  }) : _textEditingController = textEditingController;

  final TextEditingController _textEditingController;
  final String title;
    final IconData prefixIcon;

  @override
  State<textField> createState() => _textField();
}

class _textField extends State<textField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._textEditingController,
      keyboardType: TextInputType.emailAddress,

      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(borderSide:BorderSide(
            width: 1,
            color: Colors.grey
        )),
        hintText: widget.title,
        filled: true,
        fillColor:  Colors.transparent,

        prefixIcon:Icon(widget.prefixIcon,color: Colors.grey,)


      ),

    );
  }
}
