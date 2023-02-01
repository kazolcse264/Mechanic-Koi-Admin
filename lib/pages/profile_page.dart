import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/models/employee_model.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';
import 'package:mechanic_koi_admin/utils/constants.dart';
import 'package:provider/provider.dart';

import '../utils/widget_functions.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  bool? isAdmin;

  ProfilePage({Key? key, this.isAdmin}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final isAdminProfile = ModalRoute.of(context)!.settings.arguments as bool?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                height: 150,
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: const Color(0xFF2B2B2B).withOpacity(0.5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60,
                        child: (isAdminProfile == null)
                            ? null
                            : (isAdminProfile)
                                ? Image.asset(
                                    'assets/images/profile.png',
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(employeeProvider
                                            .employeeModel
                                            ?.employeeImageModel
                                            ?.imageDownloadUrl ??
                                        'https://avatars.githubusercontent.com/u/74205867?v=4'),
                                    radius: 60,
                                  ),
                      ),
                      Positioned(
                        left: 100,
                        right: 0,
                        top: 80,
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Container(
                height: 100,
                width: double.infinity,
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.person),
                          label: const Text(
                            'Profile',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            (employeeProvider.employeeModel == null)
                ? Text('')
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('Full Name'),
                            trailing: Text(
                                employeeProvider.employeeModel!.displayName ??
                                    'Not Set Yet'),
                          ),
                          ListTile(
                            title: const Text('Phone'),
                            trailing: Text(
                                employeeProvider.employeeModel!.phone ??
                                    'Not Set Yet'),
                          ),
                          ListTile(
                            title: const Text('Email Address'),
                            trailing:
                                Text(employeeProvider.employeeModel!.email),
                          ),
                          ListTile(
                            title: const Text('Address'),
                            trailing: Text(
                                employeeProvider.employeeModel!.addressModel ==
                                        null
                                    ? 'Not Set Yet'
                                    : employeeProvider.employeeModel!
                                        .addressModel!.addressLine1),
                          ),
                        ],
                      ),
                    ),
                  ),
            ((isAdminProfile == null))
                ? ElevatedButton(onPressed: () {}, child: Text('Admin'))
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF2B2B2B).withOpacity(0.75),
                      ),
                      onPressed: () {
                        showMultipleTextFieldInputDialog(
                          context: context,
                          title: 'Edit Profile',
                          onSubmit: (value) {
                            // Here value is a list
                            for (var i = 0; i < value.length; i++) {
                              employeeProvider.updateUserProfileField(
                                  employeeProfileField[i], value[i]);
                            }
                          },
                        );
                      },
                      child: const Text('Edit Profile'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
