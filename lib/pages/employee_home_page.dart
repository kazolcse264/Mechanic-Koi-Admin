import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/models/book_service_model.dart';
import 'package:mechanic_koi_admin/pages/profile_page.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/main_drawer.dart';
import '../providers/service_provider.dart';
import 'all_servicing_page.dart';
import 'bottom_nav_bar_wrapper_page.dart';
import 'employee_list_page.dart';
import 'offer_list_page.dart';

class EmployeeHomePage extends StatefulWidget {
  static const String routeName = '/emp_home_page';
  const EmployeeHomePage({Key? key}) : super(key: key);

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  @override
  void didChangeDependencies() {
    Provider.of<EmployeeProvider>(context,listen: false).getUserInfo();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);
   if(employeeProvider.employeeModel != null){
     employeeProvider.getAllServicesByEmployee(employeeProvider.employeeModel!.employeeId!);
     employeeProvider.getAllServicesByEmployeeToday(employeeProvider.employeeModel!.employeeId!);
   }
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer:  MainDrawer(isAdminMainDrawer: false,employeeProvider : employeeProvider),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF2B2B2B),
        /*leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {

          },
        ),*/
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.miscellaneous_services_rounded),
            Text('SERVICE')
          ],
        ),
        actions: [
          InkWell(
            onTap: (){

              Navigator.pushReplacementNamed(context, BottomNavBarPageWrapper.routeName);
            },
            child: const Icon(Icons.notifications),
          ),
          InkWell(
            onTap: (){

              Navigator.pushNamed(context, ProfilePage.routeName, arguments: false);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 8.0),
              child:CircleAvatar(
                backgroundImage: NetworkImage(
                    employeeProvider.employeeModel?.employeeImageModel?.imageDownloadUrl ??
                        'https://avatars.githubusercontent.com/u/74205867?v=4'),
                radius: 25,
              ),


            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              // It will cover 20% of our total height
              height: size.height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 56,
                    ),
                    height: size.height * 0.2 - 75,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2B2B2B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 50,
                            color: const Color(0xFF2B2B2B).withOpacity(0.23),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            firstRowBodySection(context, size, serviceProvider,employeeProvider),
            secondRowBodySection(context, size, serviceProvider, employeeProvider),
          ],
        ),
      ),
    );
  }

  Padding secondRowBodySection(BuildContext context, Size size, ServiceProvider serviceProvider,EmployeeProvider employeeProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, EmployeeListPage.routeName),
            child: SizedBox(
              height: size.height / 4,
              width: size.width / 2 - 15,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                shadowColor: const Color(0xFF2B2B2B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Income',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        const Icon(
                          Icons.group,
                          color: Colors.lightBlue,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          employeeProvider.employeeModelList.length.toString(),
                          style: const TextStyle(
                              fontSize: 30, color: Colors.lightBlue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(
                context, OfferListPage.routeName),
            child: SizedBox(
              height: size.height / 4,
              width: size.width / 2 - 15,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                shadowColor: const Color(0xFF2B2B2B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Salary',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.card_giftcard,
                          color: Colors.lightBlue,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        (employeeProvider.employeeModel == null ) ? const Text('') : Text(
                          employeeProvider.employeeModel!.salary.toString() ,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.lightBlue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding firstRowBodySection(BuildContext context, Size size, ServiceProvider serviceProvider,EmployeeProvider employeeProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, AllServicingPage.routeName, arguments: serviceProvider.bookServiceListToday.length),
            child: SizedBox(
              height: size.height / 4,
              width: size.width / 2 - 15,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                shadowColor: const Color(0xFF2B2B2B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Today Services',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.lightBlue,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          employeeProvider.employeeServicesModelListToday.length.toString(),
                          style: const TextStyle(
                              fontSize: 30, color: Colors.lightBlue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, AllServicingPage.routeName),
            child: SizedBox(
              height: size.height / 4,
              width: size.width / 2 - 15,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                shadowColor: const Color(0xFF2B2B2B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total Services',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.lightBlue,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text( employeeProvider.employeeServicesModelList.length.toString(),
                          style: const TextStyle(
                              fontSize: 30, color: Colors.lightBlue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
