import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_bills/constants/Appcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Statistic(),
    );
  }
}

class Statistic extends StatefulWidget {
  const Statistic({Key? key}) : super(key: key);

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  int touchedIndex = 0;
  bool _isTextVisible = false; // Initial state of text visibility

  void _toggleVisibility() {
    setState(() {
      _isTextVisible = !_isTextVisible; // Toggle the visibility state
    });
  }
  final List<ChartData> chartData=[
     ChartData('depots', 200, 20, 90, 50),
     ChartData('retrait', 500, 20, 90, 90),
     ChartData('transfert', 700, 1677, 90, 50),
     ChartData('credit', 200, 20, 90, 50),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                  Text(
                    "Statistics",
                    style: TextStyle(
                      fontFamily: 'popins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications_sharp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Solde actuel",
                style: TextStyle(
                  fontFamily: 'popins',
                  color: Colors.grey,
                  fontSize: 22,
                  letterSpacing: 1,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _toggleVisibility,
                    icon: Icon(Icons.remove_red_eye_sharp),
                  ),
                  _isTextVisible ?Text(
                      "89087080 XAF",
                      style: TextStyle(
                        fontFamily: 'popins',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ):Text("Afficher le solde"),

                ],
              ),
              SizedBox(height: 30),
             Container(
               width: 330,
               height: 210,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: AppColor.white,
                 boxShadow: [
                   BoxShadow(
                     color:Colors.black.withOpacity(0.1),
                     spreadRadius: 2,
                     blurRadius: 3,
                     offset: Offset(0, 7), // changes position of shadow
                   ),
                 ],
               ),
               child:SfCartesianChart(
                 primaryXAxis: CategoryAxis(),
                 series: [
                   StackedColumnSeries(
                  color:Colors.blue,
                     dataSource:chartData,
                       xValueMapper: (dynamic ch,_) => ch.x,
                       yValueMapper:(dynamic ch, _)=>ch.y1
                   )
                 ],
               ),
             ),
              SizedBox(height: 40,),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 130,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                    ),
                               child: Stack(
                  children: [
                  ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Ajustez le rayon selon vos besoins
                            child: WaveWidget(
                              config: CustomConfig(
                  gradients: [
                    [Colors.white, Colors.blueAccent],
                    [Colors.blue, Colors.blueAccent],
                    [Colors.blue, Colors.blueAccent],
                    [Colors.blue, Colors.blueAccent],
                  ],
                  durations: [3500, 19000, 6000],
                  heightPercentages: [0.20, 0.23, 0.30],
                              ),
                              size: Size(200, 200),
                            ),
                          ),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'MTN',  // Remplacez ce chiffre par celui que vous souhaitez afficher
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.yellow.withOpacity(1),  // Ajustez la couleur selon vos besoins
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 50,),
                          Text(
                            '23907 XAF',  // Remplacez ce chiffre par celui que vous souhaitez afficher
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,  // Ajustez la couleur selon vos besoins
                                fontFamily: 'popins'
                            ),
                          ),
                        ],
                      ),
                    ),
                          ],
                        ),

                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50)
                    ),
                               child: Stack(
                  children: [
                  ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Ajustez le rayon selon vos besoins
                            child: WaveWidget(
                              config: CustomConfig(
                  gradients: [
                    [Colors.white, Colors.blueAccent],
                    [Colors.blue, Colors.blueAccent],
                    [Colors.blue, Colors.blueAccent],
                    [Colors.blue, Colors.blueAccent],
                  ],
                  durations: [3500, 19000, 6000],
                  heightPercentages: [0.20, 0.23, 0.30],
                              ),
                              size: Size(200, 200),
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'Orange',  // Remplacez ce chiffre par celui que vous souhaitez afficher
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.orange,  // Ajustez la couleur selon vos besoins
                                      fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 50,),
                                Text(
                                  '23900987 XAF',  // Remplacez ce chiffre par celui que vous souhaitez afficher
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,  // Ajustez la couleur selon vos besoins
                                  fontFamily: 'popins'
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ],
                        ),

                  ),
                ],
              ),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    );
  }


}


class ChartData{
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
  ChartData(
        this.x,
        this.y1,
      this.y2,
      this.y3,
      this.y4
      );
}