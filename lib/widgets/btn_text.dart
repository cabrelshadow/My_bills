import 'package:flutter/material.dart';

import '../constants/Appcolor.dart';

class ButtonText extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  ButtonText({

    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 350,
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(15),

        ),
        child: Center(child: Text(title,style: TextStyle(
          fontFamily: "popins",
          color: Colors.white,

        ),),),
      ),
    );
  }
}
