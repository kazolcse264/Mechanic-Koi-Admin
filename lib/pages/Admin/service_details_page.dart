import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:mechanic_koi_admin/models/book_service_model.dart';
import 'package:mechanic_koi_admin/providers/service_provider.dart';
import 'package:mechanic_koi_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class ServiceDetailsPage extends StatefulWidget {
  static const String routeName = '/service_details';

  const ServiceDetailsPage({Key? key}) : super(key: key);

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  late BookServiceModel bookServiceModel;
  late ServiceProvider serviceProvider;
  late String orderId;
  String errMsg = '';

  @override
  void didChangeDependencies() {
    serviceProvider = Provider.of<ServiceProvider>(context);
    orderId = ModalRoute.of(context)!.settings.arguments as String;
    bookServiceModel = serviceProvider.getOrderById(orderId);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(orderId),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          buildHeader('Type of Category'),
          const Divider(
            thickness: 2,
          ),
          buildProductInfoSection(bookServiceModel),
          buildHeader('Service Details'),
          const Divider(
            thickness: 2,
          ),
          buildOrderSummerySection(bookServiceModel),
          buildHeader('Payment Status'),
          const Divider(
            thickness: 2,
          ),
          buildPaymentSection(bookServiceModel),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Confirmed Order',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ))
          //buildOrderStatusSection(orderModel, orderProvider),
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

  Widget buildProductInfoSection(BookServiceModel bookServiceModel) {
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

  Widget buildOrderSummerySection(BookServiceModel bookServiceModel) {
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

  Widget buildPaymentSection(BookServiceModel bookServiceModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pending',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 100,
              width: 80,
              child: FlutterSwitch(
                width: 60.0,
                height: 35.0,
                toggleSize: 30.0,
                value: bookServiceModel.paymentStatus,
                borderRadius: 30.0,
                toggleColor: Colors.white,
                toggleBorder: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
                activeColor: Colors.green,
                inactiveColor: Colors.black38,
                onToggle: (val) async {
                  setState(() {
                    bookServiceModel.paymentStatus =
                        !bookServiceModel.paymentStatus;
                  });
                  try {
                    serviceProvider.updateBookingStatus(
                        bookServiceModel.bookServiceId!,
                        bookServiceFieldPaymentStatus,
                        bookServiceModel.paymentStatus);
                    EasyLoading.show(status: 'Please Wait...');
                    showMsg(context, 'Update Successfully');
                    EasyLoading.dismiss();
                  } catch (error) {
                    errMsg = error.toString();
                    showMsg(context, errMsg);
                  }
                },
              ),
            ),
            const Text(
              'Confirmed',
              style: TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
