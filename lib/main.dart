import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mechanic_koi_admin/pages/Login/login_screen.dart';
import 'package:mechanic_koi_admin/pages/Signup/signup_screen.dart';
import 'package:mechanic_koi_admin/pages/Welcome/welcome_screen.dart';
import 'package:mechanic_koi_admin/pages/Admin/add_employee_page.dart';
import 'package:mechanic_koi_admin/pages/Admin/add_offer_page.dart';
import 'package:mechanic_koi_admin/pages/Admin/all_servicing_page.dart';
import 'package:mechanic_koi_admin/pages/Employee/all_servicing_page_by_employee.dart';
import 'package:mechanic_koi_admin/pages/bottom_nav_bar_wrapper_page.dart';
import 'package:mechanic_koi_admin/pages/Admin/category_page.dart';
import 'package:mechanic_koi_admin/pages/Employee/employee_details_page.dart';
import 'package:mechanic_koi_admin/pages/Employee/employee_home_page.dart';
import 'package:mechanic_koi_admin/pages/Employee/employee_list_page.dart';
import 'package:mechanic_koi_admin/pages/Employee/employee_service_details_page.dart';
import 'package:mechanic_koi_admin/pages/Admin/home_page.dart';
import 'package:mechanic_koi_admin/pages/contact_us.dart';
import 'package:mechanic_koi_admin/pages/how_it_work.dart';
import 'package:mechanic_koi_admin/pages/launcher_page.dart';
import 'package:mechanic_koi_admin/pages/Admin/offer_details_page.dart';
import 'package:mechanic_koi_admin/pages/Admin/offer_list_page.dart';
import 'package:mechanic_koi_admin/pages/privacy_policy.dart';
import 'package:mechanic_koi_admin/pages/profile_page.dart';
import 'package:mechanic_koi_admin/pages/Admin/service_details_page.dart';
import 'package:mechanic_koi_admin/pages/settings.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';
import 'package:mechanic_koi_admin/providers/service_provider.dart';
import 'package:provider/provider.dart';

import 'utils/constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => EmployeeProvider()),
      ChangeNotifierProvider(create: (_) => ServiceProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mechanic Koi',
      theme: ThemeData(
          iconTheme: const IconThemeData(
            color: kPrimaryColor,
          ),
          primaryColor: kPrimaryColor,
          appBarTheme: const AppBarTheme(
            color: kPrimaryColor,
          ),
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LoginScreen.routeName : (context) => const LoginScreen(),
        LauncherPage.routeName : (context) => const LauncherPage(),
        ProfilePage.routeName : (context) => const ProfilePage(),
        HomePage.routeName : (context) => const HomePage(),
        EmployeeHomePage.routeName : (context) => const EmployeeHomePage(),
        SettingsPage.routeName : (context) => const SettingsPage(),
        BottomNavBarPageWrapper.routeName : (context) =>  BottomNavBarPageWrapper(),
        OfferListPage.routeName : (context) => const OfferListPage(),
        EmployeeListPage.routeName : (context) => const EmployeeListPage(),
        AddOfferPage.routeName : (context) =>  const AddOfferPage(),
        AddEmployeePage.routeName : (context) =>  const AddEmployeePage(),
        WelcomeScreen.routeName : (context) => const WelcomeScreen(),
        SignUpScreen.routeName : (context) => const SignUpScreen(),
        CategoryPage.routeName : (context) => const CategoryPage(),
        AllServicingPage.routeName : (context) => const AllServicingPage(),
        ServiceDetailsPage.routeName : (context) => const ServiceDetailsPage(),
        OfferDetailsPage.routeName : (context) => const OfferDetailsPage(),
        EmployeeDetailsPage.routeName : (context) => const EmployeeDetailsPage(),
        AllServicingPageByEmployee.routeName : (context) => const AllServicingPageByEmployee(),
        EmployeeServiceDetailsPage.routeName : (context) => const EmployeeServiceDetailsPage(),
        ContactUsPage.routeName : (context) => const ContactUsPage(),
        PrivacyPolicyPage.routeName : (context) => const PrivacyPolicyPage(),
        HowItWorkPage.routeName : (context) => const HowItWorkPage(),
      },
    );
  }
}
