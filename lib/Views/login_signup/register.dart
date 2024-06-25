import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../constants/Appcolor.dart';
import '../../widgets/btn_text.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text("Create account",textAlign: TextAlign.center,style: TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'popins',
                      fontSize: 27

                  ),

                  ),
                ),
                const SizedBox(height: 20,),
                const Center(
                  child: Text("Create an account so you can explore all the\n existing jobs",textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.black,

                      fontFamily: 'popins',
                      fontSize: 14

                  ),

                  ),
                ),
                Form(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(

                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(IconlyLight.message,color: AppColor.primary,),
                          hintText: "email",
                          filled: true,
                          fillColor:  AppColor.placeholder,
                          enabledBorder:OutlineInputBorder(

                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide(
                                width: 1,
                                color: AppColor.primary,


                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: AppColor.secondaryText
                              )
                          ),

                        ),

                      ),
                      SizedBox(height: 40,),
                      TextField(

                        keyboardType: TextInputType.text,
                        obscureText: _obscureText=true,
                        decoration: InputDecoration(

                          hintText:"password",
                          filled: true,
                          fillColor:  AppColor.placeholder,
                          enabledBorder:OutlineInputBorder(

                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 1,
                                color: AppColor.primary,


                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: AppColor.secondaryText
                              )
                          ),
                          prefixIcon: Icon(IconlyLight.lock, color: AppColor.primary, ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,color: AppColor.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },

                          ),

                        ),

                      ),
                      SizedBox(height: 40,),
                      TextField(

                        keyboardType: TextInputType.text,
                        obscureText: _obscureText=true,
                        decoration: InputDecoration(

                          hintText:"confirm password",
                          filled: true,
                          fillColor:  AppColor.placeholder,
                          enabledBorder:OutlineInputBorder(

                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                width: 1,
                                color: AppColor.primary,


                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1,
                                  color: AppColor.secondaryText
                              )
                          ),
                          prefixIcon: Icon(IconlyLight.lock, color: AppColor.primary, ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,color: AppColor.primary,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },

                          ),

                        ),

                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("forgot your password?",style: TextStyle(
                            color: AppColor.primary,

                          ),)
                        ],
                      ),
                      SizedBox(height: 20,),

                      ButtonText(title: 'Sign up', onPressed: () {  },),
                      SizedBox(height: 30,),
                      Text("create new account",style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'popins',

                      ),),
                      SizedBox(height: 70,),
                      Text("Or conwithtinue ",style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'popins',

                      ),),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 76),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 59,
                              height: 40,
                              decoration: BoxDecoration(
                                  color:Colors.grey[300],
                                  borderRadius: BorderRadius.circular(7)

                              ),
                              child: Center(
                                child: Icon(Icons.facebook_outlined,),
                              ),
                            ),
                            Container(
                              width: 59,
                              height: 40,
                              decoration: BoxDecoration(
                                  color:Colors.grey[300],
                                  borderRadius: BorderRadius.circular(7)

                              ),
                              child: Center(
                                child: Icon(Icons.apple,),
                              ),
                            ),
                            Container(
                              width: 59,
                              height: 40,
                              decoration: BoxDecoration(
                                  color:Colors.grey[300],
                                  borderRadius: BorderRadius.circular(7)

                              ),
                              child: Center(
                                child: Icon(Icons.telegram_outlined,),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],

                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
