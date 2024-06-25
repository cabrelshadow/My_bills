import 'package:flutter/material.dart';

import '../../constants/Appcolor.dart';
import '../../constants/image_string.dart';
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

  @override
  void initState() {
    super.initState();
    retraitsMtnStream = getRetraitsMtnStream();
    getDepoListStream = getDepotStream();
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
                    color: AppColor.primary2,
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColor.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black54,
                    tabs: [
                      TabItem(title: 'Retrait', count: 2),
                      TabItem(title: 'Depot', count: 2),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              // TabView pour les retraits
              StreamBuilder<List<Retrait>>(
                stream: retraitsMtnStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Aucun retrait trouvé.'));
                  }

                  List<Retrait> retraits = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                      itemCount: retraits.length,
                      itemBuilder: (context, index) {
                        Retrait retrait = retraits[index];
                        AssetImage imageAsset = AssetImage(notfound);
                        if (retrait.typeRetrait.toLowerCase() == 'mtn') {
                          imageAsset = AssetImage(mtn);
                        } else if (retrait.typeRetrait.toLowerCase() == 'orange') {
                          imageAsset = AssetImage(om);
                        }

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageAsset,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  '${retrait.numeroTelephone}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "popins",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${retrait.montant} FCFA ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "popins",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  retrait.dateHeureRetrait.toString(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "popins",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(height: 1, color: Colors.grey[300]),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              // TabView pour les dépôts
              StreamBuilder<List<Depot>>(
                stream: getDepoListStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Aucun dépôt trouvé.'));
                  }

                  List<Depot> depots = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                      itemCount: depots.length,
                      itemBuilder: (context, index) {
                        Depot Depots = depots[index];
                        AssetImage imageAsset = AssetImage(notfound);
                        if (Depots.typeDepot.toLowerCase() == 'mtn') {
                          imageAsset = AssetImage(mtn,);
                        } else if (Depots.typeDepot.toLowerCase() == 'orange') {
                          imageAsset = AssetImage(om);
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
                                   style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 Text(
                                   'Montant: ${depot.montant} FCFA',
                                   style: TextStyle(
                                     fontSize: 14,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 Text(
                                   depot.dateHeureDepot.toString(),
                                   style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
class TabItem extends StatelessWidget {
  final String title;
  final int count;

  const TabItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

