import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'dart:async';  // Importez la bibliothèque pour utiliser Completer

import '../../constants/Appcolor.dart';
import '../../constants/image_string.dart';
import '../../widgets/btn_text.dart';
import '../models/depot.dart';
import '../models/retrait.dart';

class RetraitOrange extends StatefulWidget {
  const RetraitOrange({super.key});

  @override
  State<RetraitOrange> createState() => _RetraitOrangeState();
}

class _RetraitOrangeState extends State<RetraitOrange> with WidgetsBindingObserver {
  TextEditingController phone=TextEditingController();
  TextEditingController montant=TextEditingController();
  bool hasWindowFocus = false;
  Completer<void> callCompleter = Completer<void>();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (WidgetsBinding.instance.window.viewInsets.bottom == 0.0) {
      hasWindowFocus = true;
    } else {
      hasWindowFocus = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {
        hasWindowFocus = true;
        if (callCompleter.isCompleted) {
          print("completed ussd");
          toastification.show(
            context: context,
            title: Text('success' ,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "popins"
            )),
            type: ToastificationType.success,
            description: Text("Depot au numero:${phone.text.toString()},\n a été effectuer avec succes",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "popins"
            ),),
            // .... Other parameters
            animationDuration: const Duration(milliseconds: 300),
            animationBuilder: (context, animation, alignment, child) {
              return RotationTransition(
                turns: animation,
                child: child,
              );
            },
          );

        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Retrait',
                style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'popins', fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' Orange',
                style: TextStyle(color: Colors.orange, fontSize: 24, fontFamily: 'popins', fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: [
              Center(
                child: Image.asset(om, fit: BoxFit.contain, width: 200, height: 200),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 360,
                      child: TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "numero de telephone",
                          hintStyle: TextStyle(fontSize: 14),
                          filled: true,
                          fillColor: AppColor.placeholder,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.orange,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.orange,
                            ),


                          ),
                          prefixIcon: Icon(Icons.phone, color: Colors.orange, size: 20),

                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "le numero ne peu pas etre vide";
                          }
                          return null;
                        },
                      ),


                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 50,
                      width: 360,
                      child: TextFormField(
                        controller: montant,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: "montant",
                          hintStyle: TextStyle(fontSize: 14),
                          filled: true,
                          fillColor: AppColor.placeholder,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.orange,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.orange,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.money, color: Colors.orange, size: 20),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "le montant ne peu pas etre vide";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonText(
                      title: 'Valider le retrait',
                      onPressed: () async {
                        callCompleter = Completer<void>(); // Réinitialiser le completer
                        DateTime now = DateTime.now();


                        // await FlutterPhoneDirectCaller.callNumber("#150*6*2*1998#");
                     await FlutterPhoneDirectCaller.callNumber("#997#");
                        if(_formKey.currentState!.validate()){

                          Retrait retait = Retrait(
                            dateHeureRetrait: DateTime.now(),
                            numeroTelephone:phone.text.toString() ,
                            typeRetrait: "orange",
                            montant:montant.text.toString()
                            ,
                            idRetrait: '',
                          );
                          await addRetrait(retait);

                          phone.clear();
                          montant.clear();

                        }

                        callCompleter.complete(); // Marquer l'appel comme terminé


                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }


}

