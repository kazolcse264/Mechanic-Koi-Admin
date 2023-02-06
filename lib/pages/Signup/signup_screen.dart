import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mechanic_koi_admin/models/date_model.dart';
import 'package:provider/provider.dart';
import '../../auth/auth_service.dart';
import '../../models/employee_model.dart';
import '../../providers/employee_provider.dart';
import '../../utils/background.dart';
import '../../utils/constants.dart';
import '../../utils/helper_functions.dart';
import '../Login/login_screen.dart';
import '../launcher_page.dart';
import 'components/sign_up_top_image.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errMsg = '';
  bool isLogin = true;
  bool _isObscure = true;
  bool rememberPassword = false;
  final focusNode = FocusNode();
  late EmployeeProvider employeeProvider;

  @override
  void didChangeDependencies() {
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SignUpScreenTopImage(),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36.0, vertical: 8.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'Enter Your Email',
                            labelText: 'Enter Your Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 1))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36.0, vertical: 8.0),
                      child: TextFormField(
                        obscureText: _isObscure,
                        controller: passwordController,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36.0, vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _authenticate();
                          //Navigator.pushReplacementNamed(context, BottomNavBarPage.routeName);
                        },
                        child: Text("Sign Up".toUpperCase()),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    /*AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.pushNamed(context, LoginScreen.routeName,);
                      },
                    ),*/
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                        text: 'Already have an account!!',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      TextSpan(
                        text: '\tLogin',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushNamed(
                              context, LoginScreen.routeName,
                              arguments: false),
                      ),
                    ]))
                  ],
                )),
            // const SocalSignUp()
          ],
        ),
      ),
    );
  }

  void _authenticate() async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait', dismissOnTap: false);
      final email = emailController.text;
      final password = passwordController.text;
      await AuthService.register(email, password);
      final employeeModel = EmployeeModel(
        employeeId: AuthService.currentUser!.uid,
        email: emailController.text,
        employeeCreationTimeDateModel: DateModel(
          timestamp: Timestamp.fromDate(
              AuthService.currentUser!.metadata.creationTime!),
          day: AuthService.currentUser!.metadata.creationTime!.day,
          month: AuthService.currentUser!.metadata.creationTime!.month,
          year: AuthService.currentUser!.metadata.creationTime!.year,
        ),
      );
      employeeProvider.addEmployee(employeeModel).then((value) async {
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            LauncherPage.routeName,
          );
        } else {
          await AuthService.logOut();
          setState(() {
            errMsg =
                'This email account is not marked as Admin. Please use a valid Admin email address';
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
