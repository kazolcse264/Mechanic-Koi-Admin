
import 'package:mechanic_koi_admin/models/subcategory_model.dart';
import 'package:mechanic_koi_admin/models/user_model.dart';

import 'category_model.dart';
import 'date_model.dart';

const String collectionBookServices = 'Book Services';

const String bookServiceFieldBookServiceId = 'bookServiceId';
const String bookServiceFieldBookEmployeeId = 'bookEmployeeId';
const String bookServiceFieldCategoryModel = 'categoryModel';
const String bookServiceFieldSubcategoryModel = 'subcategoryModel';
const String bookServiceFieldOtherProblem = 'otherProblem';
const String bookServiceFieldPickUpAddress = 'pickUpAddress';
const String bookServiceFieldDropAddress = 'dropAddress';
const String bookServiceFieldDateModel = 'dateModel';
const String bookServiceFieldPaymentStatus = 'paymentStatus';
const String bookServiceFieldUserModel = 'userModel';

class BookServiceModel {
  String? bookServiceId;
  String? bookEmployeeId;
  CategoryModel categoryModel;
  SubcategoryModel subcategoryModel;
  DateModel dateModel;
  String otherProblem;
  String pickUpAddress;
  String dropAddress;
  bool paymentStatus;
  UserModel userModel;

  BookServiceModel({
    required this.dateModel,
    this.bookServiceId,
    this.bookEmployeeId,
    this.paymentStatus = false,
     required this.categoryModel,
    required this.subcategoryModel,
    required this.otherProblem,
    required this.pickUpAddress,
    required this.dropAddress,
    required this.userModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      bookServiceFieldBookServiceId: bookServiceId,
      bookServiceFieldBookEmployeeId: bookEmployeeId,
      bookServiceFieldCategoryModel: categoryModel.toMap(),
      bookServiceFieldSubcategoryModel: subcategoryModel.toMap(),
      bookServiceFieldOtherProblem: otherProblem,
      bookServiceFieldPickUpAddress: pickUpAddress,
      bookServiceFieldDropAddress: dropAddress,
      bookServiceFieldPaymentStatus: paymentStatus,
      bookServiceFieldDateModel: dateModel.toMap(),
      bookServiceFieldUserModel: userModel.toMap(),
    };
  }

  factory BookServiceModel.fromMap(Map<String, dynamic> map) =>
      BookServiceModel(
        bookServiceId: map[bookServiceFieldBookServiceId],
        bookEmployeeId: map[bookServiceFieldBookEmployeeId],
        categoryModel: CategoryModel.fromMap(map[bookServiceFieldCategoryModel]),
        subcategoryModel: SubcategoryModel.fromMap(map[bookServiceFieldSubcategoryModel]),
        otherProblem: map[bookServiceFieldOtherProblem],
        pickUpAddress: map[bookServiceFieldPickUpAddress],
        dropAddress: map[bookServiceFieldDropAddress],
        paymentStatus: map[bookServiceFieldPaymentStatus],
        dateModel: DateModel.fromMap(map[bookServiceFieldDateModel]),
        userModel: UserModel.fromMap(map[bookServiceFieldUserModel]),
      );
}
