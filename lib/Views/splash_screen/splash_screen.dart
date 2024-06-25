

import 'package:flutter/material.dart';
import 'package:my_bills/Views/login_signup/login.dart';
import 'package:my_bills/Views/splash_screen/welcome_screen.dart';
import 'package:my_bills/constants/Appcolor.dart';
import 'package:flutter/cupertino.dart';
import '../../constants/image_string.dart';
import '../home/navBar/nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void goWelcomePage()async{
    await Future.delayed(Duration(seconds: 5));
    welcompage();
  }
  void initState(){
    super.initState();
    goWelcomePage();

  }
  void welcompage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body:   SafeArea(
             child: Padding(
               padding: const EdgeInsets.only(top: 300),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Center(
                     child:  Image.asset(logo,fit: BoxFit.fill,width: 130,height: 130,),
                   ),
                   SizedBox(height: 20,),
                   Center(
                     child: Text("My Bills",style: TextStyle(
                       fontSize: 30,

                       fontWeight: FontWeight.w900,
                       color: AppColor.darkthemes
                     ),),
                   )
                 ],
               ),
             ),
           )
    );
  }
}
