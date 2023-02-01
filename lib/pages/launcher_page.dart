import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/auth/auth_service.dart';
import 'Welcome/welcome_screen.dart';
import 'bottom_nav_bar_wrapper_page.dart';

class LauncherPage extends StatelessWidget {
  static const String routeName = '/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, (){
      if(AuthService.currentUser != null){
        (AuthService.currentUser!.email == 'admin@gmail.com') ? Navigator.pushReplacementNamed(context, BottomNavBarPageWrapper.routeName,arguments:  true) : Navigator.pushReplacementNamed(context, BottomNavBarPageWrapper.routeName,arguments:  false) ;
      }else{
        Navigator.pushReplacementNamed(context, WelcomeScreen.routeName);
      }
    });
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
