import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/models/employee_model.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';
import 'package:provider/provider.dart';

import '../utils/helper_functions.dart';
import '../utils/widget_functions.dart';

class EmployeeDetailsPage extends StatefulWidget {
  static const String routeName = '/employee_details';
  const EmployeeDetailsPage({Key? key}) : super(key: key);

  @override
  State<EmployeeDetailsPage> createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final employeeProvider = Provider.of<EmployeeProvider>(context);
    final employeeId = ModalRoute.of(context)!.settings.arguments as String;
    final employeeModel = employeeProvider.getEmployeeById(employeeId);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(
          employeeModel.displayName ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person,color: Colors.black,),
            title: const Text('Employee Name',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: (employeeModel.displayName == null)?const Text(''):Text(employeeModel.displayName!),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Employee Name',
                  onSubmit: (value) {
                    employeeProvider.updateEmployeeField(
                        employeeId, employeeFieldDisplayName, value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.school,color: Colors.black,),
            title: const Text('Employee Designation',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: (employeeModel.designation == null)?const Text(''):Text(employeeModel.designation!),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Employee Designation',
                  onSubmit: (value) {
                    employeeProvider.updateEmployeeField(
                        employeeId, employeeFieldDesignation, value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person,color: Colors.black,),
            title: const Text('Employee ID',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: (employeeModel.employeeId == null)?const Text(''):Text(employeeModel.employeeId!),
          ),
          ListTile(
            leading: const Icon(Icons.email,color: Colors.black,),
            title: const Text('Email',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(employeeModel.email),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Email',
                  onSubmit: (value) {
                    employeeProvider.updateEmployeeField(
                        employeeId, employeeFieldEmail, value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.phone,color: Colors.black,),
            title: const Text('Phone Number',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: (employeeModel.phone == null)?const Text(''):Text(employeeModel.phone!),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Phone Number',
                  onSubmit: (value) {
                    employeeProvider.updateEmployeeField(
                        employeeId, employeeFieldPhone, value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),          ),
          ListTile(
            leading: const Icon(Icons.calendar_month,color: Colors.black,),
            title: const Text('Employee Creation Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: (employeeModel.employeeCreationTimeDateModel == null) ? const Text('') : Text(getFormattedDate(
                employeeModel.employeeCreationTimeDateModel!.timestamp.toDate())),
            trailing: IconButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
             /*   employeeProvider.updateAdminOfferField(employeeId, '$offerFieldOfferExpiredDateModel.$dateFieldTimestamp', Timestamp.fromDate(selectedDate!),);
                employeeProvider.updateAdminOfferField(employeeId, '$offerFieldOfferExpiredDateModel.$dateFieldDay', selectedDate.day);
                employeeProvider.updateAdminOfferField(employeeId, '$offerFieldOfferExpiredDateModel.$dateFieldMonth', selectedDate.month);
                employeeProvider.updateAdminOfferField(employeeId, '$offerFieldOfferExpiredDateModel.$dateFieldYear', selectedDate.year);*/
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person,color: Colors.black,),
            title: const Text('Age',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: (employeeModel.age == null)?const Text(''):Text(employeeModel.age!.toString()),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Age',
                  onSubmit: (value) {
                    employeeProvider.updateEmployeeField(
                        employeeId, employeeFieldAge, num.parse(value));
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person,color: Colors.black,),
            title: const Text('Gender',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle:  (employeeModel.gender == null)?const Text(''):Text(employeeModel.gender!),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Gender',
                  onSubmit: (value) {
                    employeeProvider.updateEmployeeField(
                        employeeId, employeeFieldGender, value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
        /*  ListTile(
            leading: Image.network(
              employeeModel.thumbnailImageModel.imageDownloadUrl,
              height: 200,
              width: 50,
              fit: BoxFit.cover,
            ),
            title:const Text('Offer Banner Photo',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            trailing: IconButton(
              onPressed: () async {
                final file = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 70);
                final imageModel =
                await employeeProvider.uploadImage(file!.path);
                employeeProvider.updateAdminOfferField(employeeId, '$offerFieldThumbnailImageModel.$imageFieldProductImageDownloadUrl', imageModel.imageDownloadUrl);
                employeeProvider.updateAdminOfferField(employeeId, '$offerFieldThumbnailImageModel.$imageFieldOfferId', employeeId);
                employeeProvider.updateAdminOfferField(employeeId, '$offerFieldThumbnailImageModel.$imageFieldOfferTitle', imageModel.title);
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),*/
        ],
      ),
    );
  }
}
