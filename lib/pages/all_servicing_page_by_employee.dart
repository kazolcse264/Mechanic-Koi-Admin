import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';
import 'package:mechanic_koi_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';

class AllServicingPageByEmployee extends StatefulWidget {
  static const String routeName = '/all_service_by_employee';
  const AllServicingPageByEmployee({Key? key}) : super(key: key);

  @override
  State<AllServicingPageByEmployee> createState() => _AllServicingPageByEmployeeState();
}

class _AllServicingPageByEmployeeState extends State<AllServicingPageByEmployee> {
  @override
  Widget build(BuildContext context) {
    final count = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      appBar: AppBar(
        title:(count == null ) ? const Text('All Booking Services by Employee'): const Text('Today\'s Booking Services by Employee'),
      ),
      body: Consumer<EmployeeProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: (count == null ) ? provider.employeeServicesModelList.length :  provider.employeeServicesModelListToday.length,
          itemBuilder: (context, index) {
            final service = (count == null ) ? provider.employeeServicesModelList[index] : provider.employeeServicesModelListToday[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                onTap: () {
                 /* Navigator.pushNamed(context, ServiceDetailsPage.routeName, arguments: service.bookServiceId);*/
                },
                tileColor: service.paymentStatus ? null : Colors.grey.withOpacity(.5),
                title: const Text('New Booking Order'),
                subtitle: Text('Service Id: ${service.bookServiceId}'),
                trailing: Text(getFormattedDate(service.dateModel.timestamp.toDate())),
              ),
            );
          },
        ),
      ),
    );
  }
}
