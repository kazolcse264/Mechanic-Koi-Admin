
import 'address_model.dart';
import 'date_model.dart';
import 'image_model.dart';

const String collectionEmployees = 'Employees';

const String employeeFieldEmployeeId = 'employeeId';
const String employeeFieldDisplayName = 'displayName';
const String employeeFieldDesignation= 'designation';
const String employeeFieldEmployeeImageModel = 'employeeImageModel';
const String employeeFieldGender = 'gender';
const String employeeFieldPhone = 'phone';
const String employeeFieldEmail = 'email';
const String employeeFieldAge = 'age';
const String employeeFieldSalary = 'salary';
const String employeeFieldEmployeeCreationTimeDateModel =
    'employeeCreationTimeDateModel';
const String employeeFieldAddressModel = 'addressModel';

class EmployeeModel {
  String? employeeId;
  String? displayName;
  String? designation;
  ImageModel? employeeImageModel;
  String? gender;
  String? phone;
  String email;
  num? age;
  num? salary;
  DateModel? employeeCreationTimeDateModel;
  AddressModel? addressModel;

  EmployeeModel({
    this.employeeId,
    this.displayName,
    this.designation,
    this.employeeImageModel,
    this.gender,
    this.phone,
    required this.email,
    this.age,
    this.salary,
    this.employeeCreationTimeDateModel,
    this.addressModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      employeeFieldEmployeeId: employeeId,
      employeeFieldDisplayName: displayName,
      employeeFieldDesignation: designation,
      employeeFieldEmployeeImageModel: employeeImageModel?.toMap(),
      employeeFieldGender: gender,
      employeeFieldPhone: phone,
      employeeFieldEmail: email,
      employeeFieldAge: age,
      employeeFieldSalary: salary,
      employeeFieldEmployeeCreationTimeDateModel:
      employeeCreationTimeDateModel?.toMap(),
      employeeFieldAddressModel: addressModel?.toMap(),
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) => EmployeeModel(
    employeeId: map[employeeFieldEmployeeId],
    displayName: map[employeeFieldDisplayName],
    designation: map[employeeFieldDesignation],
    employeeImageModel: map[employeeFieldEmployeeImageModel] == null
        ? null
        : ImageModel.fromMap(map[employeeFieldEmployeeImageModel]),
    gender: map[employeeFieldGender],
    phone: map[employeeFieldPhone],
    email: map[employeeFieldEmail],
    age: map[employeeFieldAge],
    salary: map[employeeFieldSalary],
    employeeCreationTimeDateModel:
    map[employeeFieldEmployeeCreationTimeDateModel] == null
        ? null
        : DateModel.fromMap(
        map[employeeFieldEmployeeCreationTimeDateModel]),
    addressModel: map[employeeFieldAddressModel] == null
        ? null
        : AddressModel.fromMap(map[employeeFieldAddressModel]),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EmployeeModel &&
              runtimeType == other.runtimeType &&
              employeeId == other.employeeId;

  @override
  int get hashCode => employeeId.hashCode;
}
