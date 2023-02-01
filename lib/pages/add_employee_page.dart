import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanic_koi_admin/models/employee_model.dart';
import 'package:mechanic_koi_admin/providers/employee_provider.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../models/date_model.dart';
import '../utils/helper_functions.dart';
import 'launcher_page.dart';

class AddEmployeePage extends StatefulWidget {
  static const String routeName = '/add_employee';

  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  String _errMsg = '';
  final _employeeNameController = TextEditingController();
  final _designationController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();
  bool _isObscure = true;
  String? thumbnail;
  late EmployeeProvider employeeProvider;
  @override
  void didChangeDependencies() {
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text(
                  'You must press the App Bar back button to exit this page'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('No'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: const Text('Add Employee '),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SizedBox(
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
                        ClipOval(
                          child: (thumbnail == null) ? Image.asset(
                            'assets/images/profile.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ):Image.file(
                            File(thumbnail!),
                            fit: BoxFit.cover,
                          ),
                        ),

                    /*    CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          child: (thumbnail == null) ? Image.asset(
                            'assets/images/profile.png',
                          ) :Image.file(
                            File(thumbnail!),
                            fit: BoxFit.cover,
                          ),
                        ),*/
                        Positioned(
                          left: 100,
                          right: 0,
                          top: 80,
                          child: CircleAvatar(
                            child: IconButton(
                              onPressed: _getImage,
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
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: TextFormField(
                          controller: _employeeNameController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'Employee Name',
                              labelText: 'Employee Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 1))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Employee Name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email),
                              labelText: 'Email',
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: TextFormField(
                          obscureText: _isObscure,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password),
                              labelText: 'Enter your password',
                              hintText: 'Enter your password',
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field must not be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 4.0,
                        ),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.phone),
                              labelText: 'Phone Number',
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone Number is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 4.0,
                        ),
                        child: TextFormField(
                          controller: _designationController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.school),
                              labelText: 'Designation',
                              hintText: 'Designation',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Designation is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 4.0,
                        ),
                        child: TextFormField(
                          controller: _ageController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.calendar_month),
                              labelText: 'Age',
                              hintText: 'Age',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 4.0,
                        ),
                        child: TextFormField(
                          controller: _salaryController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.currency_rupee),
                              labelText: 'Salary',
                              hintText: 'Salary',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Salary is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 4.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _saveEmployee();
                              //for return a value from pop method
                              Navigator.pop(context, true);
                            },
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
  void _getImage() async {
    final file =
    await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (file != null) {
      setState(() {
        thumbnail = file.path;
      });
    }
  }
  void _saveEmployee() async{
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait', dismissOnTap: false);
      final email = _emailController.text;
      final password = _passwordController.text;
      await AuthService.register(email, password);
      final imageModel = await employeeProvider.uploadImage(thumbnail!);
      final employeeModel = EmployeeModel(
        employeeId: AuthService.currentUser!.uid,
        displayName: _employeeNameController.text,
        designation: _designationController.text,
        phone: _phoneNumberController.text,
        email: _emailController.text,
        salary: double.parse(_salaryController.text),
        employeeImageModel: imageModel,
        employeeCreationTimeDateModel: DateModel(
          timestamp: Timestamp.fromDate(
              AuthService.currentUser!.metadata.creationTime!),
          day: AuthService.currentUser!.metadata.creationTime!.day,
          month: AuthService.currentUser!.metadata.creationTime!.month,
          year: AuthService.currentUser!.metadata.creationTime!.year,
        ),
      );
      employeeProvider.addEmployee(employeeModel).then((value) async{
        await AuthService.logOut();
        final status = await AuthService.loginAdmin('admin@gmail.com', '123456');
        EasyLoading.dismiss();
        if (status) {
          if (mounted) {
            Navigator.pushReplacementNamed(context, LauncherPage.routeName,) ;
            EasyLoading.dismiss();
          }
        } else {
          await AuthService.logOut();
          setState(() {
            _errMsg =
            'This email account is not marked as Admin. Please use a valid Admin email address';
            showMsg(context, _errMsg);
          });
        }
        EasyLoading.dismiss();
      }).catchError((error) {
        EasyLoading.dismiss();
        showMsg(context, 'could not save user info');
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _salaryController.dispose();
    _phoneNumberController.dispose();
    _employeeNameController.dispose();
    _designationController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}


