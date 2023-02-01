import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/pages/employee_home_page.dart';
import 'package:mechanic_koi_admin/pages/home_page.dart';
import 'package:mechanic_koi_admin/pages/offer_list_page.dart';
import 'package:mechanic_koi_admin/pages/profile_page.dart';
import 'package:mechanic_koi_admin/pages/settings.dart';

class BottomNavBarPage extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onIndexChanged;
  const BottomNavBarPage({Key? key,required this.currentIndex, required this.onIndexChanged}) : super(key: key);

  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {

  final items = const [
    Icon(Icons.home, size: 30,color: Colors.white,),
    Icon(Icons.card_giftcard, size: 30,color: Colors.white,),
    Icon(Icons.person, size: 30,color: Colors.white,),
    Icon(Icons.settings, size: 30,color: Colors.white,)
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    bool isAdmin = ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      //backgroundColor: const Color(0xFF2B2B2B),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: widget.currentIndex,
        onTap: (selectedIndex){
          widget.onIndexChanged(selectedIndex);
        },
        height: 50,
        backgroundColor: Colors.white,
        color: const Color(0xFF2B2B2B),
        animationDuration: const Duration(milliseconds: 300),
        // animationCurve: ,
      ),
      body: Container(
          //color: const Color(0xFF2B2B2B),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: getSelectedWidget(index: widget.currentIndex, isAdmin : isAdmin)
      ),
    );
  }

  Widget getSelectedWidget({required int index, required bool isAdmin}){
    Widget widget;
    switch(index){
      case 0:
        widget = (isAdmin) ? const HomePage() : const EmployeeHomePage();
        break;
      case 1:
        widget = const OfferListPage();
        break;
      case 2:
        widget =  ProfilePage(isAdmin : isAdmin);
        break;
      case 3:
        widget = const SettingsPage();
        break;
      default:
        widget = (isAdmin) ? const HomePage() : const EmployeeHomePage();
        break;
    }
    return widget;
  }
}