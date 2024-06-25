import 'package:flutter/material.dart';
import 'package:my_bills/Views/login_signup/login.dart';
import 'package:my_bills/constants/Appcolor.dart';

import '../../constants/image_string.dart';
import '../login_signup/register.dart';

class DecideScreen extends StatelessWidget {
  const DecideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset(l1,fit: BoxFit.fill,width: 300, height: 300,)),
             const SizedBox(height: 70,),
              Text("Discover Your",style: TextStyle(
                fontSize: 24,
                color: AppColor.primary,
                fontFamily: 'popins',
                fontWeight: FontWeight.bold
              ),),
              Text(" Dream Job here",style: TextStyle(
                  fontSize: 24,
                  color: AppColor.primary,
                  fontFamily: 'popins',
                  fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 26,),
              const Text(" Explore all the existing job roles based on your interest and study major",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 14,
                  color:Colors.grey,
                  fontFamily: 'popins',

              ),),
             const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(child: Text("Login",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'popins',

                        ),
                        ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                      },
                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                        border: Border.all(width: 1,  color: AppColor.primary,),
                          borderRadius: BorderRadius.circular(14),
                        ),

                        child:  Center(child: Text("Register",style: TextStyle(
                          color: AppColor.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'popins',

                        ),
                        ),
                        ),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
