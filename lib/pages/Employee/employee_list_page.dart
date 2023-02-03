import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/pages/Admin/add_employee_page.dart';
import 'package:mechanic_koi_admin/pages/Employee/employee_details_page.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../utils/helper_functions.dart';

enum _MenuValues {
  edit,
  delete,
}

class EmployeeListPage extends StatefulWidget {
  static const String routeName = '/employee_list';

  const EmployeeListPage({Key? key}) : super(key: key);

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee list Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Garage Employee',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton.icon(
              onPressed: () async {
                Navigator.pushNamed(context, AddEmployeePage.routeName);
              },
              icon: const Icon(Icons.card_giftcard),
              label: const Text(
                'New Employee',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepPurple,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          (employeeProvider.employeeModelList.isEmpty)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Employee not available.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              : Consumer<EmployeeProvider>(
                  builder: (context, provider, child) => Expanded(
                    child: ListView.builder(
                      itemCount: provider.employeeModelList.length,
                      itemBuilder: (context, index) {
                        final employeeModel = provider.employeeModelList[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, EmployeeDetailsPage.routeName,arguments: employeeModel.employeeId!),
                            child: Card(
                              child: ListTile(
                                leading: (employeeModel.employeeImageModel == null)
                                        ? const CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.red,
                                          )
                                        : Image.network(
                                            employeeModel.employeeImageModel!
                                                .imageDownloadUrl,
                                            height: 100,
                                            width: 50,
                                            fit: BoxFit.cover,
                                          ),
                                tileColor: Colors.tealAccent.shade100,
                                title: Text(
                                  employeeModel.displayName!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  getFormattedDate(employeeModel
                                      .employeeCreationTimeDateModel!.timestamp
                                      .toDate()),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                    trailing: buildPopupMenuButton(context, employeeModel.employeeId!,provider),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
 PopupMenuButton<_MenuValues> buildPopupMenuButton(
      BuildContext context, String employeeId, EmployeeProvider provider) {
    return PopupMenuButton<_MenuValues>(
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: _MenuValues.edit,
          child: Card(
              color: kPrimaryColor,
              child: ListTile(
                title: Text('Edit',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.edit,color: Colors.white,),
              )),
        ),
        const PopupMenuItem(
            value: _MenuValues.delete,
            child: Card(
              color: kPrimaryColor,
              child: ListTile(
                title: Text('Delete',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.delete,color: Colors.white,),
              ),
            )),
      ],
      onSelected: (value) {
        switch (value) {
          case _MenuValues.edit:
            Navigator.pushNamed(context, EmployeeDetailsPage.routeName,arguments: employeeId);
            break;
          case _MenuValues.delete:
            provider.deleteEmployee(employeeId);
            break;
        }
      },
      iconSize: 35,
    );
  }
}
