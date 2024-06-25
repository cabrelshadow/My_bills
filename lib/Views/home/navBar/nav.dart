import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconly/iconly.dart';

import '../../../constants/Appcolor.dart';
import '../../statistics/statistic.dart';
import '../../transaction_history/transaction_history.dart';
import '../home_screen.dart';
import 'navController.dart';
class NavBar extends StatefulWidget {
  NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final controller= Get.put(NavbarController());

  @override

  Widget build(BuildContext context) {
    return GetBuilder<NavbarController>(builder: (context){
      return Scaffold(
        body:IndexedStack(
          index: controller.tabIndex,
          children:  const [
            HomeScreen(),
            TranscationHistory(),
            Statistic(),


          ],

        ) ,
//navabar working
        bottomNavigationBar:  BottomNavigationBar(
          currentIndex: controller.tabIndex,
          onTap: controller.changeTabIndex,
          selectedItemColor: AppColor.primary,
          unselectedItemColor: Colors.grey,

          items: [
            _bottombarItem(Icons.home_filled, "home"),
            _bottombarItem(Icons.compare_arrows_sharp, "transaction"),

            _bottombarItem(Icons.add_chart, "statistique"),
            _bottombarItem(Icons.settings_input_component_rounded, "setings"),



          ],
        ),
      );
    });
  }
}
_bottombarItem(IconData icon,String lable){
  return BottomNavigationBarItem(icon: Icon(icon),label: lable);
}