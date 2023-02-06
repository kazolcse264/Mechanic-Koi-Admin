import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mechanic_koi_admin/models/category_model.dart';
import 'package:mechanic_koi_admin/models/date_model.dart';
import 'package:mechanic_koi_admin/models/offer_model.dart';
import 'package:mechanic_koi_admin/models/subcategory_model.dart';

import '../models/book_service_model.dart';
import '../models/employee_model.dart';

class DbHelper {
  static const String collectAdmin = 'Admins';
  static const String collectionEmployees = 'Employees';
  static final _db = FirebaseFirestore.instance;

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(collectAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<bool> isEmployee(String uid) async {
    final snapshot = await _db.collection(collectionEmployees).doc(uid).get();
    return snapshot.exists;
  }

  static Future<bool> doesUserExist(String uid) async {
    final snapshot = await _db.collection(collectionEmployees).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addEmployee(EmployeeModel employeeModel) {
    final doc = _db.collection(collectionEmployees).doc(employeeModel.employeeId);
    return doc.set(employeeModel.toMap());
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(
          String uid) =>
      _db.collection(collectionEmployees).doc(uid).snapshots();

  static Future<void> updateEmployeeProfileField(
      String uid, Map<String, dynamic> map) {
    return _db.collection(collectionEmployees).doc(uid).update(map);
  }

  static Future<void> updateBookingStatus(String id, Map<String, dynamic> map) {
    return _db.collection(collectionBookServices).doc(id).update(map);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBookingServices() =>
      _db.collection(collectionBookServices).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBookingServicesToday() => _db
          .collection(collectionBookServices)
          .where('$bookServiceFieldDateModel.$dateFieldDay', isEqualTo: DateTime.now().day)
          .snapshots();


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllServicesByEmployee(String employeeId) => _db
          .collection(collectionBookServices)
          .where(bookServiceFieldBookEmployeeId, isEqualTo: employeeId)
          .where(bookServiceFieldPaymentStatus, isEqualTo: true)
          .snapshots();
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllServicesByEmployeeToday(employeeId) => _db
      .collection(collectionBookServices)
      .where(bookServiceFieldBookEmployeeId, isEqualTo: employeeId)
      .where(bookServiceFieldPaymentStatus, isEqualTo: true)
      .where('$bookServiceFieldDateModel.$dateFieldDay', isEqualTo: DateTime.now().day)
      .snapshots();

  static Future<void> addCategory(
      CategoryModel categoryModel, SubcategoryModel subcategoryModel) async {
    final wb = _db.batch(); //write batch
    final catDoc = _db
        .collection(collectionCategory)
        .doc('mEkAnIc${categoryModel.categoryName}kOi');
    final subCatDoc = _db.collection(collectionSubCategory).doc();
    final docSnapshot = await catDoc.get();
    if (docSnapshot.exists) {
      subcategoryModel.categoryId = catDoc.id;
      subcategoryModel.serviceId = subCatDoc.id;
      wb.set(subCatDoc, subcategoryModel.toMap());
      return wb.commit();
    } else {
      categoryModel.categoryId = catDoc.id;
      subcategoryModel.categoryId = catDoc.id;
      subcategoryModel.serviceId = subCatDoc.id;
      wb.set(catDoc, categoryModel.toMap());
      wb.set(subCatDoc, subcategoryModel.toMap());
      return wb.commit();
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCategories() {
    final collectionRef = _db.collection(collectionCategory);
    return collectionRef.snapshots();
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllEmployees() {
    final collectionRef = _db.collection(collectionEmployees);
    return collectionRef.snapshots();
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllOffers() {
    final collectionRef = _db.collection(collectionOffers);
    return collectionRef.snapshots();
  }

  static Future<void> updateProductField(
      String productId, Map<String, dynamic> map) {
    return _db.collection(collectionCategory).doc(productId).update(map);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSubCategories() {
    final collectionRef = _db.collection(collectionSubCategory);
    return collectionRef.snapshots();
  }

  static Future<void> addNewOffer(OfferModel offerModel, SubcategoryModel subcategoryModel) {
    final wb = _db.batch(); //write batch
    final offerDoc = _db
        .collection(collectionOffers)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    final subCatDoc = _db.collection(collectionSubCategory).doc(subcategoryModel.serviceId);
    offerModel.offerId = offerDoc.id;
    offerModel.subcategoryModel.servicePrice = offerModel.offerPrice;
    wb.update(subCatDoc, {subcategoryFieldServicePrice : offerModel.offerPrice});
    wb.set(offerDoc, offerModel.toMap());
    return wb.commit();
  }

  static Future<void> deleteOffer(String offerId) {
    return _db.collection(collectionOffers).doc(offerId).delete();
  }
  static Future<void> deleteEmployee(String employeeId) {
    return _db.collection(collectionEmployees).doc(employeeId).delete();
  }

  static Future<void> updateAdminOfferField(
      String offerId, Map<String, dynamic> map) {
    return _db.collection(collectionOffers).doc(offerId).update(map);
  }
  static Future<void> updateEmployeeField(
      String employeeId, Map<String, dynamic> map) {
    return _db.collection(collectionEmployees).doc(employeeId).update(map);
  }
}
