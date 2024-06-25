import 'package:flutter/material.dart';
import 'package:my_bills/Views/login_signup/login.dart';
import 'package:my_bills/constants/Appcolor.dart';
import 'package:my_bills/constants/image_string.dart';

import '../../widgets/btn_text.dart';
import 'decide_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                 Center(child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Image.asset(w2,fit: BoxFit.fill,width: 300,height: 300,),
                 )),
              const  SizedBox(height: 20,),

             const   Text("save time by using all our\n features",textAlign: TextAlign.justify,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: "popins"

                ),),
               const SizedBox(height: 23,),
               const Text("Integrate multiple payment methoods\n to help you up the process quickly",textAlign: TextAlign.justify,style: TextStyle(

                  fontSize: 15,
                    fontFamily: "popins",
                 color: Colors.grey

                ),),
                const SizedBox(height: 35,),
                ButtonText(title: 'l\'et go', onPressed: () {  Navigator.push(context, MaterialPageRoute(builder: (context)=>DecideScreen()));},)
              ],

            ),
          ),
        ),
    );
  }
}

