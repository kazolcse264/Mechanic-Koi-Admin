import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/models/address_model.dart';

import '../models/employee_model.dart';

const kPrimaryColor = Color(0xFF2B2B2B);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const String firebaseStorageProductImageDir = 'ProductImages';
const double defaultPadding = 16.0;
const String currencySymbol = '৳';

const List employeeProfileField = [
  employeeFieldDisplayName,
  employeeFieldPhone,
  employeeFieldEmail,
  '$employeeFieldAddressModel.$city',
  '$employeeFieldAddressModel.$zipcode',
  '$employeeFieldAddressModel.$addressLine1',
  '$employeeFieldAddressModel.$addressLine2',
  employeeFieldGender,
  employeeFieldAge,
  employeeFieldSalary
];

