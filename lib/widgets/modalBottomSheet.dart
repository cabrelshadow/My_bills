import 'package:flutter/material.dart';

import '../Views/Retraits/retrait_orange.dart';
import '../constants/Appcolor.dart';
import '../constants/image_string.dart';

Future _displayBottomSheetRetrait(BuildContext context, String title) {
  return showModalBottomSheet(
    barrierColor: Colors.black54.withOpacity(0.7),
    context: context,
    builder: (context) => Container(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "popins",
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>RetraitOrange()));
                  },
                  onLongPress: () {
                    // Handle long press
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(om),
                        fit: BoxFit.contain,
                      ),
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Icon(Icons.compare_arrows,size: 30,color: AppColor.primary,),
                GestureDetector(
                  onTap: () {
                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>RetraitOrange()));
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(mtn),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.yellow),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}