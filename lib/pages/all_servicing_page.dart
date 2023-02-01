import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/pages/service_details_page.dart';
import 'package:mechanic_koi_admin/providers/service_provider.dart';
import 'package:provider/provider.dart';

class AllServicingPage extends StatefulWidget {
  static const String routeName = '/all_service';
  const AllServicingPage({Key? key}) : super(key: key);

  @override
  State<AllServicingPage> createState() => _AllServicingPageState();
}

class _AllServicingPageState extends State<AllServicingPage> {
  @override
  Widget build(BuildContext context) {
    final count = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Booking Services'),
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: (count == null ) ? provider.bookServiceList.length :  provider.bookServiceListToday.length,
          itemBuilder: (context, index) {
            final service = (count == null ) ? provider.bookServiceList[index] : provider.bookServiceListToday[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                onTap: () {
                 Navigator.pushNamed(context, ServiceDetailsPage.routeName, arguments: service.bookServiceId);
                },
                  tileColor: service.paymentStatus ? null : Colors.grey.withOpacity(.5),
                title: const Text('New Booking Order'),
                subtitle: Text('Service Id: ${service.bookServiceId}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
