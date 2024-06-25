import 'package:cloud_firestore/cloud_firestore.dart';

class Depot {
  String? idDepot;
  DateTime dateHeureDepot;
  String numeroTelephone;
  String typeDepot;
 String montant;

  Depot({
    this.idDepot,
    required this.dateHeureDepot,
    required this.numeroTelephone,
    required this.typeDepot,
    required this.montant,
  });

  // Méthode pour convertir un document Firebase en objet Depot
  factory Depot.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Depot(
      idDepot: doc.id,
      dateHeureDepot: (data['dateHeureDepot'] as Timestamp).toDate(),
      numeroTelephone: data['numeroTelephone'] ?? '',
      typeDepot: data['typeDepot'] ?? '',
      montant: data['montant'] ??'',
    );
  }

  // Méthode pour convertir un objet Depot en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'dateHeureDepot': dateHeureDepot,
      'numeroTelephone': numeroTelephone,
      'typeDepot': typeDepot,
      'montant': montant,
    };
  }
}
Future<void> addDepot(Depot depot) async {
  final collectionRef = FirebaseFirestore.instance.collection('depots');
  final docRef = await collectionRef.add(depot.toMap());
  depot.idDepot = docRef.id;
}
Stream<List<Depot>> getDepotStream() {
  return FirebaseFirestore.instance
      .collection('depots')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Depot.fromDocument(doc))
      .toList());
}