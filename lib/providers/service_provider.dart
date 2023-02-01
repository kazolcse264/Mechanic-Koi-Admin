
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/models/category_model.dart';

import 'package:mechanic_koi_admin/models/offer_model.dart';
import 'package:mechanic_koi_admin/models/subcategory_model.dart';
import '../db/db_helper.dart';
import '../models/book_service_model.dart';
import '../models/image_model.dart';
import '../utils/constants.dart';

class ServiceProvider extends ChangeNotifier {
  CategoryModel? categoryModel;
  List<CategoryModel> categoryList = [];
  List<SubcategoryModel> subcategoryList = [];
  List<BookServiceModel> bookServiceList = [];
  List<BookServiceModel> bookServiceListToday = [];
  List<OfferModel> offerModelList = [];

  Future<void> addCategory(
          CategoryModel categoryModel, SubcategoryModel subcategoryModel) =>
      DbHelper.addCategory(categoryModel, subcategoryModel);


  getAllCategories() {
    DbHelper.getAllCategories().listen((snapshot) {
      categoryList = List.generate(snapshot.docs.length,
          (index) => CategoryModel.fromMap(snapshot.docs[index].data()));
      /*  categoryList.sort((model1, model2) =>
          model1.categoryName.compareTo(model2.categoryName));*/
      notifyListeners();
    });
  }


getAllSubCategories(){
  DbHelper.getAllSubCategories().listen((snapshots) {
    subcategoryList = List.generate(snapshots.docs.length,
            (index) => SubcategoryModel.fromMap(snapshots.docs[index].data()));
    notifyListeners();
  });
}
  getAllOffers() {
    DbHelper.getAllOffers().listen((snapshot) {
      offerModelList = List.generate(snapshot.docs.length,
              (index) => OfferModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllBookingServices() {
    DbHelper.getAllBookingServices().listen((snapshot) {
      bookServiceList = List.generate(snapshot.docs.length,
              (index) => BookServiceModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllBookingServicesToday() {
    DbHelper.getAllBookingServicesToday().listen((snapshot) {
      bookServiceListToday = List.generate(snapshot.docs.length,
              (index) => BookServiceModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
  Future<void> updateProductField(
      String productId, String field, dynamic value) {
    return DbHelper.updateProductField(productId, {field: value});
  }

  Future<void> updateBookingStatus(String notId,String field,dynamic value) =>
      DbHelper.updateBookingStatus(notId,{field:value});

  int get totalUnreadMessage {
    int total = 0;
    for (final n in bookServiceList) {
      if (!n.paymentStatus) {
        total += 1;
      }
    }
    return total;
  }

  BookServiceModel getOrderById(String id) {
    return bookServiceList.firstWhere((element) => element.bookServiceId == id);
  }

  BookServiceModel getOrderByIdWithDate(String id, num day) {
    return bookServiceList.firstWhere((element) => element.bookServiceId == id && element.dateModel.day == day);
  }
  OfferModel getOfferById(String id) {
    return offerModelList.firstWhere((element) => element.offerId == id);
  }

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

  Future<void> addNewOffer(
      OfferModel offerModel) =>
      DbHelper.addNewOffer(offerModel);


  Future<void> deleteOffer(String offerId) {
    return DbHelper.deleteOffer( offerId);
  }
  Future<void> updateAdminOfferField(String offerId, String field, dynamic value) =>
      DbHelper.updateAdminOfferField(
        offerId,
        {field : value},
      );


}
