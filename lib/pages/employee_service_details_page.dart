import 'package:flutter/material.dart';

import 'package:mechanic_koi_admin/models/book_service_model.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';

import 'package:provider/provider.dart';

import '../utils/constants.dart';

class EmployeeServiceDetailsPage extends StatefulWidget {
  static const String routeName = '/employee_service_details';

  const EmployeeServiceDetailsPage({Key? key}) : super(key: key);

  @override
  State<EmployeeServiceDetailsPage> createState() => _EmployeeServiceDetailsPageState();
}

class _EmployeeServiceDetailsPageState extends State<EmployeeServiceDetailsPage> {
  late BookServiceModel bookServiceModel;
  late EmployeeProvider employeeProvider;
  late String orderId;
  String errMsg = '';

  @override
  void didChangeDependencies() {
    employeeProvider = Provider.of<EmployeeProvider>(context);
    orderId = ModalRoute.of(context)!.settings.arguments as String;
    bookServiceModel = employeeProvider.getOrderById(orderId);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(orderId),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          buildHeader('Type of Category'),
          const Divider(
            thickness: 2,
          ),
          buildCategoryInfoSection(bookServiceModel),
          buildHeader('Service Details'),
          const Divider(
            thickness: 2,
          ),
          buildSubCategoryInfoSection(bookServiceModel),
          buildHeader('Payment Status'),
          const Divider(
            thickness: 2,
          ),
          buildPaymentStatusSection(bookServiceModel),
        ],
      ),
    );
  }

  Padding buildHeader(String header) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        header,
        style: TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.7)),
      ),
    );
  }

  Widget buildCategoryInfoSection(BookServiceModel bookServiceModel) {
    return Card(
      color: kPrimaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Category Name : ${bookServiceModel.categoryModel.categoryName}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            subtitle: Text(
              'Category Id : ${bookServiceModel.categoryModel.categoryId!}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget buildSubCategoryInfoSection(BookServiceModel bookServiceModel) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Service Name : ${bookServiceModel.subcategoryModel.serviceName}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: const Text(
                  'Service Cost : ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      '$currencySymbol${bookServiceModel.subcategoryModel.servicePrice.toString()}',
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
  Widget buildPaymentStatusSection(BookServiceModel bookServiceModel) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
                title: const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Payment status  ',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                trailing:Text(
                  '${bookServiceModel.paymentStatus}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ), ),
          ],
        ),
      ),
    );
  }


}
