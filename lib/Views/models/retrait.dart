import 'package:cloud_firestore/cloud_firestore.dart';

class Retrait {
  String? idRetrait;
  DateTime dateHeureRetrait;
  String numeroTelephone;
  String typeRetrait;
  String montant;

  Retrait({
    this.idRetrait,
    required this.dateHeureRetrait,
    required this.numeroTelephone,
    required this.typeRetrait,
    required this.montant,
  });

  // Méthode pour convertir un document Firebase en objet  retait
  factory Retrait.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Retrait(
      idRetrait: doc.id,
      dateHeureRetrait: (data['dateHeureRetrait'] as Timestamp).toDate(),
      numeroTelephone: data['numeroTelephone'] ?? '',
      typeRetrait: data['typeRetrait'] ?? '',
      montant: data['montant'] ??'',
    );
  }

  // Méthode pour convertir un objet Retrait en map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'dateHeureRetrait': dateHeureRetrait,
      'numeroTelephone': numeroTelephone,
      'typeRetrait': typeRetrait,
      'montant': montant,
    };
  }
}
Future<void> addRetrait(Retrait retrait) async {
  final collectionRef = FirebaseFirestore.instance.collection('Retrait');
  final docRef = await collectionRef.add(retrait.toMap());
  retrait.idRetrait = docRef.id;
}

Stream<List<Retrait>> getRetraitsMtnStream() {
  return FirebaseFirestore.instance
      .collection('Retrait')
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => Retrait.fromDocument(doc))
      .toList());
}
// Méthode pour calculer la somme totale des montants de retraits dans Firestore
