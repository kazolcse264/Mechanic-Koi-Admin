import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/custom_widgets/main_drawer.dart';
import 'package:mechanic_koi_admin/pages/Admin/all_servicing_page.dart';
import 'package:mechanic_koi_admin/pages/Employee/employee_list_page.dart';
import 'package:mechanic_koi_admin/pages/profile_page.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';
import 'package:mechanic_koi_admin/providers/service_provider.dart';
import 'package:provider/provider.dart';
import '../../custom_widgets/badge_view.dart';
import 'offer_list_page.dart';


class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ServiceProvider>(context, listen: false).getAllCategories();
    Provider.of<ServiceProvider>(context, listen: false).getAllSubCategories();
    Provider.of<ServiceProvider>(context, listen: false).getAllBookingServices();
    Provider.of<ServiceProvider>(context, listen: false).getAllOffers();
    Provider.of<ServiceProvider>(context, listen: false).getAllBookingServicesToday();
    Provider.of<EmployeeProvider>(context, listen: false).getAllEmployees();
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final size = MediaQuery.of(context).size;
    final count = Provider.of<ServiceProvider>(context).totalUnreadMessage;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer:  MainDrawer(
        isAdminMainDrawer: true,
        serviceProvider:serviceProvider,
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF2B2B2B),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.miscellaneous_services_rounded),
            Text('SERVICE')
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AllServicingPage.routeName);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    const Icon(
                      Icons.notifications,
                      size: 50,
                      color: Colors.white,
                    ),
                    BadgeView(
                      count: count,
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ProfilePage.routeName, arguments: true);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, left: 8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/profile.png'),
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
            firstRowBodySection(context, size, serviceProvider),
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
                            'Total Employees',
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
                            'Total Offers',
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
                              Text(
                                serviceProvider.offerModelList.length.toString(),
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

  Padding firstRowBodySection(BuildContext context, Size size, ServiceProvider serviceProvider) {
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
                                serviceProvider.bookServiceListToday.length.toString(),
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
                            'All Services',
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
                              Text(
                                serviceProvider.bookServiceList.length
                                    .toString(),
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
