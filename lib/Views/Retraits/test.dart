import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/depot.dart';
import '../models/retrait.dart';

class TranscationHistory extends StatefulWidget {
  const TranscationHistory({super.key});

  @override
  State<TranscationHistory> createState() => _TranscationHistoryState();
}

class _TranscationHistoryState extends State<TranscationHistory> {
  late Stream<List<Retrait>> retraitsMtnStream;
  late Stream<List<Depot>> getDepoListStream;

  double totalMontantRetraits = 0.0; // Variable pour stocker la somme des montants de retraits

  @override
  void initState() {
    super.initState();
    retraitsMtnStream = getRetraitsMtnStream();
    getDepoListStream = getDepotStream();
    calculateTotalMontantRetraits();
  }

  // Méthode pour calculer la somme totale des montants de retraits dans Firestore
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



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Historique des transactions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height: 49,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueGrey, // Utilisation temporaire de la couleur blueGrey
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: 'Retrait'),
                      Tab(text: 'Depot'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // Onglet Retrait
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Somme totale des retraits:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$totalMontantRetraits FCFA',
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                ],
              ),

              // Onglet Depot
              Container(
                alignment: Alignment.center,
                child: Text('Contenu de l\'onglet Dépôt'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
