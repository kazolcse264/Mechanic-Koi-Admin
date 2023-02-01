import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/models/book_service_model.dart';
import 'package:mechanic_koi_admin/models/employee_model.dart';

import '../auth/auth_service.dart';
import '../db/db_helper.dart';
import '../models/image_model.dart';
import '../utils/constants.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeeModel? employeeModel;
  List<EmployeeModel> employeeModelList = [];
  List<BookServiceModel> employeeServicesModelList = [];
  List<BookServiceModel> employeeServicesModelListToday = [];

  Future<void> addEmployee(EmployeeModel employeeModel) =>
      DbHelper.addEmployee(employeeModel);

  Future<bool> doesUserExist(String uid) => DbHelper.doesUserExist(uid);

  getUserInfo() {
    DbHelper.getUserInfo(AuthService.currentUser!.uid).listen((snapshot) {
      if (snapshot.exists) {
        employeeModel = EmployeeModel.fromMap(snapshot.data()!);
        notifyListeners();
      }
    });
  }

  getAllEmployees() {
    DbHelper.getAllEmployees().listen((snapshot) {
      employeeModelList = List.generate(snapshot.docs.length,
          (index) => EmployeeModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllServicesByEmployee(String employeeId) {
    DbHelper.getAllServicesByEmployee(employeeId).listen((snapshot) {
      employeeServicesModelList = List.generate(snapshot.docs.length,
          (index) => BookServiceModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllServicesByEmployeeToday(String employeeId) {
    DbHelper.getAllServicesByEmployeeToday(employeeId).listen((snapshot) {
      employeeServicesModelListToday = List.generate(snapshot.docs.length,
          (index) => BookServiceModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<void> updateUserProfileField(String field, dynamic value) =>
      DbHelper.updateEmployeeProfileField(
        AuthService.currentUser!.uid,
        {field: value},
      );

  Future<ImageModel> uploadImage(String path) async {
    final imageName = 'pro_${DateTime.now().millisecondsSinceEpoch}';
    final imageRef = FirebaseStorage.instance
        .ref()
        .child('$firebaseStorageProductImageDir/$imageName');
    final uploadTask = imageRef.putFile(File(path));
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return ImageModel(title: imageName, imageDownloadUrl: downloadUrl);
  }

  EmployeeModel getEmployeeById(String id) {
    return employeeModelList.firstWhere((element) => element.employeeId == id);
  }

  Future<void> updateEmployeeField(
          String employeeId, String field, dynamic value) =>
      DbHelper.updateEmployeeField(
        employeeId,
        {field: value},
      );

  Future<void> deleteEmployee(String employeeId) {
    return DbHelper.deleteEmployee(employeeId);
  }
}
