import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mechanic_koi_admin/auth/auth_service.dart';
import 'package:mechanic_koi_admin/models/date_model.dart';
import 'package:mechanic_koi_admin/models/employee_model.dart';
import 'package:mechanic_koi_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';
import '../../providers/employee_provider.dart';
import '../../utils/background.dart';
import '../../utils/constants.dart';

import '../Signup/signup_screen.dart';

import '../bottom_nav_bar_wrapper_page.dart';
import '../launcher_page.dart';
import 'components/login_screen_top_image.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errMsg = '';
  bool isLogin = true;
  bool _isObscure = true;
  final focusNode = FocusNode();
  late bool isAdmin;
  late EmployeeProvider employeeProvider;

  @override
  void didChangeDependencies() {
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isAdmin = ModalRoute.of(context)!.settings.arguments as bool;
    return Background(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const LoginScreenTopImage(),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36.0, vertical: 8.0),
                      child: TextFormField(
                        controller: _emailController,
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
                    const SizedBox(
                      height: 10,
                    ),
                    if (!isAdmin)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?'),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 36.0, vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _authenticate(isAdmin);
                        },
                        child: isAdmin
                            ? Text(
                                "Login as Admin".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            : Text(
                                "Login as Employee".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    /*AlreadyHaveAnAccountCheck(
                      press: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName, arguments: true);
                      },
                    ),*/

                    if (!isAdmin)
                      Column(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                              text: 'Don\'t have an account??',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            TextSpan(
                              text: '\tSingUp',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.pushNamed(
                                    context, SignUpScreen.routeName),
                            ),
                          ])),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'OR',
                            style: TextStyle(color: Colors.red),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Sign In with',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              _signInWithGoogleAccount(employeeProvider);
                              Navigator.pushReplacementNamed(
                                  context, BottomNavBarPageWrapper.routeName,
                                  arguments: false);
                            },
                            child: Card(
                              elevation: 10,
                              shadowColor: kPrimaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/images/google.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      'Google',
                                      style: TextStyle(
                                          fontSize: 22, color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void _authenticate(bool isAdmin) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait', dismissOnTap: false);
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        final status = (isAdmin)
            ? await AuthService.loginAdmin(email, password)
            : await AuthService.loginEmployee(email, password);
        EasyLoading.dismiss();
        if (status) {
          if (mounted) {
            Navigator.pushReplacementNamed(
              context,
              LauncherPage.routeName,
            );
          }
        } else {
          await AuthService.logOut();
          if (mounted) {
            showMsg(context,
                'This email account is not marked as Admin. Please use a valid Admin email address');
          }
        }
        /*if (mounted) {
          Navigator.pushReplacementNamed(context, LauncherPage.routeName);
        }*/
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        setState(() {
          _errMsg = error.message!;
        });
        if (mounted) showMsg(context, _errMsg);
      }
    }
  }
}

void _signInWithGoogleAccount(EmployeeProvider employeeProvider) async {
  try {
    final credential = await AuthService.signInWithGoogle();

    final userExists = await employeeProvider.doesUserExist(credential.user!.uid);
    if (!userExists) {
      EasyLoading.show(status: 'Redirecting user...');
      final employeeModel = EmployeeModel(
        employeeId: credential.user!.uid,
        email: credential.user!.email!,
        employeeCreationTimeDateModel: DateModel(
          timestamp: Timestamp.fromDate(DateTime.now()),
          day: DateTime.now().day,
          month: DateTime.now().month,
          year: DateTime.now().year,
        ),
        displayName: credential.user!.displayName,
        phone: credential.user!.phoneNumber,
      );
      await employeeProvider.addEmployee(employeeModel);
      EasyLoading.dismiss();
    }
  } catch (error) {
    EasyLoading.dismiss();
    rethrow;
  }
}
