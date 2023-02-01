import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mechanic_koi_admin/auth/auth_service.dart';
import 'package:mechanic_koi_admin/pages/employee_list_page.dart';

import '../pages/all_servicing_page.dart';
import '../pages/category_page.dart';
import '../pages/launcher_page.dart';
import '../pages/offer_list_page.dart';
import '../providers/employee_provider.dart';
import '../providers/service_provider.dart';

class MainDrawer extends StatefulWidget {
  final bool isAdminMainDrawer;
  final EmployeeProvider? employeeProvider;
  final ServiceProvider? serviceProvider;

  const MainDrawer({Key? key, required this.isAdminMainDrawer, this.employeeProvider,this.serviceProvider})
      : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 150,
            color: const Color(0xFF2B2B2B).withOpacity(0.75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  shadowColor: const Color(0xFF2B2B2B),
                  child: (widget.isAdminMainDrawer)
                      ? Image.asset(
                          'assets/images/profile.png',
                          height: 80,
                          width: 80,
                        )
                      : CircleAvatar(
                    radius: 40,
                        backgroundImage: NetworkImage(
                    widget.employeeProvider!.employeeModel?.employeeImageModel?.imageDownloadUrl ?? 'https://avatars.githubusercontent.com/u/74205867?v=4',
                          ),
                      ),
                ),
                /*CircleAvatar(
                  child: Image.asset(
                    'assets/images/profile.png',
                  ),
                  radius: 30,
                ),*/
                Text(
                  (widget.isAdminMainDrawer)
                      ? 'Admin Name'
                      : widget.employeeProvider!.employeeModel?.displayName ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  (widget.isAdminMainDrawer)
                      ? 'admin@gmail.com'
                      : widget.employeeProvider!.employeeModel?.email ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          (widget.isAdminMainDrawer)
              ? const Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 8),
                  child: Text(
                    'Menu',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ))
              : ListTile(
                  onTap: () {},
                  leading: const CircleAvatar(child: Icon(Icons.notifications)),
                  title: const Text('Notification'),
                  trailing: Container(
                    height: 100,
                    width: 100,
                    child: FlutterSwitch(
                      width: 60.0,
                      height: 35.0,
                      toggleSize: 30.0,
                      value: status,
                      borderRadius: 30.0,
                      toggleColor: Colors.white,
                      toggleBorder: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      activeColor: Colors.green,
                      inactiveColor: Colors.black38,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                        });
                      },
                    ),
                  ),
                ),
          const Divider(
            height: 5,
            thickness: 2,
          ),
          (widget.isAdminMainDrawer)
              ? ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, EmployeeListPage.routeName);
                  },
                  leading: const CircleAvatar(child: Icon(Icons.group)),
                  title: const Text('Employee'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                )
              : ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'assets/icons/service.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: const Text('Today My Service'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),

          (widget.isAdminMainDrawer)
              ? ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, CategoryPage.routeName);
            },
            leading: const CircleAvatar(child: Icon(Icons.category)),
            title: const Text('Add Category'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          )
              : const Text(''),
          (widget.isAdminMainDrawer)
              ? ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                        context, OfferListPage.routeName);
                  },
                  leading: const CircleAvatar(child: Icon(Icons.card_giftcard)),
                  title: const Text('Offer/Coupons'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                )
              : ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'assets/icons/service.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: const Text('Total My Service'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                ),
          (widget.isAdminMainDrawer)
              ? ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AllServicingPage.routeName, arguments: widget.serviceProvider?.bookServiceListToday.length);
                  },
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'assets/icons/booking.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: const Text('Today Booking'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                )
              : const Text(''),
          (widget.isAdminMainDrawer)
              ? ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AllServicingPage.routeName);
                  },
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Image.asset(
                        'assets/icons/service.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: const Text('All Servicing'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                )
              : const Text(''),
          const Padding(
            padding: EdgeInsets.only(left: 18.0, top: 8),
            child: Text(
              'Others',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          ),
          const Divider(
            height: 5,
            thickness: 2,
          ),
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              child: Image.asset(
                'assets/icons/fork.png',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
            title: const Text('How it work'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading: const CircleAvatar(child: Icon(Icons.location_on)),
            title: const Text('Contact Us'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading: const CircleAvatar(child: Icon(Icons.privacy_tip)),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading: const CircleAvatar(child: Icon(Icons.settings)),
            title: const Text('Settings'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading: const CircleAvatar(child: Icon(Icons.support)),
            title: const Text('Support'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {
              AuthService.logOut().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName));
            },
            leading: const CircleAvatar(child: Icon(Icons.logout)),
            title: const Text('Logout'),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
