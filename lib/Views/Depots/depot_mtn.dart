import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'dart:async';  // Importez la bibliothèque pour utiliser Completer

import '../../constants/Appcolor.dart';
import '../../constants/image_string.dart';
import '../../widgets/btn_text.dart';
import '../models/depot.dart';

class DepotMtn extends StatefulWidget {
  const DepotMtn({super.key});

  @override
  State<DepotMtn> createState() => _DepotMtnState();
}

class _DepotMtnState extends State<DepotMtn> with WidgetsBindingObserver {
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
            description: Text("retrait au numero:${phone.text.toString()},\n a été effectuer avec succes",style: TextStyle(
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

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tâche terminée avec succès')),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Depot',
                style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'popins', fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' MTN',
                style: TextStyle(color: Colors.yellow, fontSize: 24, fontFamily: 'popins', fontWeight: FontWeight.bold),
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
                child: Image.asset(mtn, fit: BoxFit.cover, width: 200, height: 200),
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "numero de telephone",
                          hintStyle: TextStyle(fontSize: 14),
                          filled: true,
                          fillColor: AppColor.placeholder,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.yellow,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              width: 1,
                              color:Colors.yellow,
                            ),


                          ),
                          prefixIcon: Icon(Icons.phone, color: Colors.yellow, size: 20),

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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "montant",
                          hintStyle: TextStyle(fontSize: 14),
                          filled: true,
                          fillColor: AppColor.placeholder,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.yellow,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color:Colors.yellow,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.money, color: Colors.yellow, size: 20),
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
                      title: 'Valider le depot',
                      onPressed: () async {
                        callCompleter = Completer<void>(); // Réinitialiser le completer
                       // await FlutterPhoneDirectCaller.callNumber("#150*6*2*1998#");
                        await FlutterPhoneDirectCaller.callNumber("#997#");
                        if(_formKey.currentState!.validate()){

                          Depot depot = Depot(
                            dateHeureDepot: DateTime.now(),
                            numeroTelephone:phone.text.toString() ,
                            typeDepot: "Mtn",
                            montant:montant.text.toString()
                            ,
                            idDepot: '',
                          );
                          await addDepot(depot);

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

