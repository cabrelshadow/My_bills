import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_bills/Views/Depots/depot_mtn.dart';
import 'package:my_bills/constants/Appcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


import '../../constants/image_string.dart';
import '../Depots/depot_orange.dart';
import '../Retraits/retrait_mtn.dart';
import '../Retraits/retrait_orange.dart';
import '../models/depot.dart';
import '../models/retrait.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<List<Retrait>> retraitsMtnStream;
  late Stream<List<Depot>> getDepoListStream;
  Color _backgroundColor = Colors.transparent;
  double totalMontantRetraits = 0.0;
  double totalMontantDepot = 0.0;
  int totalDepotCount = 0;
  int totalRetraitCount = 0;
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateTotalMontantRetraits();
    calculateTotalMontantDepots();
    calculateTotalDepotCount();
    calculateTotalRetraitCount();
    retraitsMtnStream = getRetraitsMtnStream();
    getDepoListStream = getDepotStream();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      calculateTotalMontantRetraits();
      calculateTotalMontantDepots();
      calculateTotalDepotCount();
      calculateTotalRetraitCount();

    });

  }
  @override
  void dispose() {
    // TODO: implement dispose

    _timer?.cancel();
    super.dispose();

  }
  void _handleLongPress() {
    setState(() {
      _backgroundColor = Colors.blue.withOpacity(0.5); // Change the color and opacity as needed
    });
  }
  Future<void> calculateTotalMontantRetraits() async {
    try {
      // Accéder à la collection 'retrait' dans Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Retrait').get();

      // Initialiser la somme à zéro
      double total = 0.0;

      // Parcourir tous les documents récupérés
      querySnapshot.docs.forEach((doc) {
        // Vérifier si le document est valide
        if (doc.exists) {
          // Récupérer les données du document
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Vérifier si le champ 'montant' existe et n'est pas null
          if (data.containsKey('montant')) {
            // Récupérer le montant du retrait comme dynamic
            dynamic montant = data['montant'];

            // Vérifier le type et convertir en double si possible
            if (montant is int) {
              total += montant.toDouble(); // Convertir un int en double
            } else if (montant is double) {
              total += montant; // Utiliser directement si déjà en double
            } else if (montant is String) {
              // Gérer les conversions de chaînes si nécessaire
              try {
                total += double.parse(montant); // Convertir la chaîne en double
              } catch (e) {
                print('Erreur de conversion de chaîne en double: $e');
              }
            } else {
              // Gérer d'autres types si nécessaire
              print('Type de montant inattendu: ${montant.runtimeType}');
            }
          }
        } else {
          print('Document does not exist');
        }
      });

      // Mettre à jour l'état de la somme totale pour déclencher le build
      setState(() {
        totalMontantRetraits = total;
      });
    } catch (e) {
      // Gérer l'erreur ici
      print('Erreur lors du calcul de la somme des retraits : $e');
    }
  }
  Future<void> calculateTotalMontantDepots() async {
    try {
      // Accéder à la collection 'retrait' dans Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('depots').get();

      // Initialiser la somme à zéro
      double total = 0.0;

      // Parcourir tous les documents récupérés
      querySnapshot.docs.forEach((doc) {
        // Vérifier si le document est valide
        if (doc.exists) {
          // Récupérer les données du document
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Vérifier si le champ 'montant' existe et n'est pas null
          if (data.containsKey('montant')) {
            // Récupérer le montant du retrait comme dynamic
            dynamic montant = data['montant'];

            // Vérifier le type et convertir en double si possible
            if (montant is int) {
              total += montant.toDouble(); // Convertir un int en double
            } else if (montant is double) {
              total += montant; // Utiliser directement si déjà en double
            } else if (montant is String) {
              // Gérer les conversions de chaînes si nécessaire
              try {
                total += double.parse(montant); // Convertir la chaîne en double
              } catch (e) {
                print('Erreur de conversion de chaîne en double: $e');
              }
            } else {
              // Gérer d'autres types si nécessaire
              print('Type de montant inattendu: ${montant.runtimeType}');
            }
          }
        } else {
          print('Document does not exist');
        }
      });

      // Mettre à jour l'état de la somme totale pour déclencher le build
      setState(() {
        totalMontantDepot = total;

      });
    } catch (e) {
      // Gérer l'erreur ici
      print('Erreur lors du calcul de la somme des retraits : $e');
    }
  }
  Future<void> calculateTotalDepotCount() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('depots').get();

      int count = querySnapshot.docs.length;

      setState(() {
        totalDepotCount = count;
      });
    } catch (e) {
      print('Erreur lors du calcul du nombre total de dépôts : $e');
    }
  }
  Future<void> calculateTotalRetraitCount() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Retrait').get();

      int count = querySnapshot.docs.length;

      setState(() {
        totalRetraitCount = count;
      });
    } catch (e) {
      print('Erreur lors du calcul du nombre total de dépôts : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
            child: Column(
              children: [
                  Row(

                    children: [
                      Row(
                   
                      
                        children: [
                          const CircleAvatar(
                            radius: 27,
                      backgroundImage: AssetImage(pp,),
                          ),
                          const SizedBox(width: 10,),
                        const  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("welcome back",style: TextStyle(
                                  fontFamily: "popins",
                                  fontWeight: FontWeight.w400,
                                color: Colors.grey
                              ),),
                              Text ("Cabrel Sianou",style: TextStyle(
                                fontFamily: "popins",
                                fontWeight: FontWeight.w600,
                                fontSize: 17

                              ),),

                            ],
                          ),
                       const SizedBox(width: 130,),
                          Container(
                            width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300 ]
                              ),
                              child: Center(child: IconButton(onPressed: (){}, icon: const Icon(Icons.search,)))
                          )
                        ],
                      )
                    ],
                  ),
                const SizedBox(height: 20, ),
                Container(
                  width: 370,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:const Color(0xff34344b)
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15 ,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text("Orange Money",style: TextStyle(
                                fontFamily: "popins",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              fontSize: 15
                            ),),
                            Icon(Icons.compare_arrows,color: Colors.white,size: 30,),
                            Text("MTN Money",style: TextStyle(
                                fontFamily: "popins",
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15
                            ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [
                            CircularPercentIndicator(
                              backgroundColor: Colors.white,
                              radius: 40.0,
                              lineWidth: 4.0,
                              percent:  totalDepotCount/100, // Valeur de progression entre 0.0 et 1.0
                              center:  Text(
                                "${(totalDepotCount / 100 * 100).toStringAsFixed(1)}%",
                                style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                              progressColor: Colors.orange,
                            ),
                          Container(
                            width: 2,height: 50,
                            decoration: const BoxDecoration(color: Colors.white ),
                          ),
                        CircularPercentIndicator(
                          backgroundColor: Colors.white,
                          radius: 40.0,
                          lineWidth: 4.0,
                          percent: totalRetraitCount/100, // Valeur de progression entre 0.0 et 1.0
                          center:  Text(
                            "${(totalRetraitCount / 100 * 100).toStringAsFixed(1)}%",
                            style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold,color: Colors.white),
                          ),
                          progressColor: Colors.yellow,
                        ),

                          ],
                        ),
                      ),
                       const SizedBox(height: 10,),
                        Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [

                               RichText(
                               text:  TextSpan(
                               children: [
                               const TextSpan(
                               text: 'Total: ',
                               style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "popins"),
                             ),
                             TextSpan(
                               text: '${totalMontantDepot.toString()} XAF',
                               style: const TextStyle(color: Colors.white,fontSize: 16,fontFamily: "popins"),
                             ),
                           ],
                         ),
                        ),

                             const SizedBox(width: 40,),

                             Row(
                               children: [

                                 RichText(
                                   text:  TextSpan(
                                     children: [
                                       const TextSpan(
                                         text: 'Total: ',
                                         style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: "popins"),
                                       ),
                                       TextSpan(
                                         text: '${totalMontantRetraits.toString()} XAF',
                                         style: const TextStyle(color: Colors.white,fontSize: 15,fontFamily: "popins"),
                                       ),
                                     ],
                                   ),
                                 ),
                               ],

                             )
                           ],
                         ),
                       )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,

                              border: Border.all(width: 2,color: Colors.blueAccent)
                            ),
                            child: Center(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                Center(child: IconButton(onPressed: (){
                                  _displayBottomSheet(context,"Depot");
                                }, icon:  Icon(Icons.arrow_downward,size: 30,color: AppColor.primary,))),

                              ],
                            ))
                        ),const SizedBox(height: 6,),
                        const Text("depot",style:TextStyle(fontFamily: "popins",fontWeight: FontWeight.bold,),)

                      ],

                    ),
                    Column(
                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                border: Border.all(width: 2,color: Colors.blueAccent)
                            ),
                            child: Center(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton( onPressed: (){
                                  _displayBottomSheetRetrait(context ,"Retrait");
                                }, icon:  Icon(Icons.arrow_upward_rounded,size: 30,color: AppColor.primary,)),

                              ],
                            ))
                        ),const SizedBox(height: 6,),
                        const Text("retrait",style:TextStyle(fontFamily: "popins",fontWeight: FontWeight.bold,),)

                      ],

                    ),
                    Column(

                      children: [
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                border: Border.all(width: 2,color: Colors.blueAccent),
                            ),
                            child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,

                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(onPressed: (){}, icon: const Icon(Icons.credit_card,)),

                              ],
                            ))
                        ),const SizedBox(height: 6,),
                        const Text("credit",style:TextStyle(fontFamily: "popins",fontWeight: FontWeight.bold,),)

                      ],

                    ),


                    
                ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Transactions",style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'popins',fontSize: 20)),
                    TextButton(onPressed: (){}, child: Text("show all",style:TextStyle(color: AppColor.primary,fontSize: 16) ,))
                  ],
                ),
                SizedBox(height:300 ,
                   child:    StreamBuilder<List<Depot>>(
                     stream: getDepoListStream,
                     builder: (context, snapshot) {
                       if (snapshot.connectionState == ConnectionState.waiting) {
                         return const Center(child: CircularProgressIndicator());
                       } else if (snapshot.hasError) {
                         return Center(child: Text('Erreur : ${snapshot.error}'));
                       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                         return const Center(child: Text('Aucun dépôt trouvé.'));
                       }

                       List<Depot> depots = snapshot.data!;
                       return Padding(
                         padding: const EdgeInsets.symmetric(vertical: 20),
                         child: ListView.builder(
                           itemCount: depots.length,
                           itemBuilder: (context, index) {
                             Depot Depots = depots[index];
                             AssetImage imageAsset = const AssetImage(notfound);
                             if (Depots.typeDepot.toLowerCase() == 'mtn') {
                               imageAsset = const AssetImage(mtn,);
                             } else if (Depots.typeDepot.toLowerCase() == 'orange') {
                               imageAsset = const AssetImage(om);
                             }

                             Depot depot = depots[index];
                             // Ajoutez ici la logique pour l'affichage des dépôts
                             return Container(
                               margin: const EdgeInsets.all(8),
                               padding: const EdgeInsets.all(8),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.grey[200],
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(
                                         'Numéro de téléphone: ${depot.numeroTelephone}',
                                         style: const TextStyle(
                                           fontSize: 16,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                       Text(
                                         'Montant: ${depot.montant} FCFA',
                                         style: const TextStyle(
                                           fontSize: 14,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),
                                       Text(
                                         depot.dateHeureDepot.toString(),
                                         style: const TextStyle(
                                           fontSize: 12,
                                           fontStyle: FontStyle.italic,
                                         ),
                                       ),
                                     ],
                                   ),
                                   Container(
                                     height: 50,
                                     width: 50,
                                     decoration: BoxDecoration(
                                         image:DecorationImage(
                                             image:imageAsset,
                                             fit: BoxFit.cover
                                         ),
                                         shape: BoxShape.circle
                                     ),
                                   )

                                 ],
                               ),
                             );
                           },
                         ),
                       );
                     },
                   ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context, String title) {
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
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>const DepotOrange()));
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
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>const DepotMtn()));
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
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>const RetraitOrange()));
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
                       Navigator.push(context,MaterialPageRoute(builder: (context)=>const RetraitMtn()));
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


}


