
import 'package:mechanic_koi_admin/models/subcategory_model.dart';
import 'category_model.dart';
import 'date_model.dart';
import 'image_model.dart';

const String collectionOffers = 'Offers';

const String offerFieldOfferId = 'offerId';
const String offerFieldCategoryModel = 'categoryModel';
const String offerFieldSubCategoryModel = 'subcategoryModel';
const String offerFieldOfferDescription = 'offerDescription';
const String offerFieldOfferName = 'offerName';
const String offerFieldOfferExpiredDateModel = 'offerExpiredDateModel';
const String offerFieldOfferPrice = 'offerPrice';
const String offerFieldThumbnailImageModel = 'thumbnailImageModel';

class OfferModel {
  String? offerId;
  CategoryModel categoryModel;
  SubcategoryModel subcategoryModel;
  DateModel offerExpiredDateModel;
  String offerDescription;
  String offerName;
  ImageModel thumbnailImageModel;
  num offerPrice;

  OfferModel({
    required this.offerExpiredDateModel,
    this.offerId,
    required this.offerPrice,
    required this.categoryModel,
    required this.subcategoryModel,
    required this.offerDescription,
    required this.offerName,
    required this.thumbnailImageModel,

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      offerFieldOfferId: offerId,
      offerFieldCategoryModel: categoryModel.toMap(),
      offerFieldSubCategoryModel: subcategoryModel.toMap(),
      offerFieldOfferDescription: offerDescription,
      offerFieldOfferName: offerName,
      offerFieldOfferPrice: offerPrice,
      offerFieldOfferExpiredDateModel: offerExpiredDateModel.toMap(),
      offerFieldThumbnailImageModel: thumbnailImageModel.toMap(),
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) =>
      OfferModel(
        offerId: map[offerFieldOfferId],
        categoryModel: CategoryModel.fromMap(map[offerFieldCategoryModel]),
        subcategoryModel: SubcategoryModel.fromMap(map[offerFieldSubCategoryModel]),
        offerDescription: map[offerFieldOfferDescription],
        offerName: map[offerFieldOfferName],
        offerPrice: map[offerFieldOfferPrice],
        offerExpiredDateModel: DateModel.fromMap(map[offerFieldOfferExpiredDateModel]),
        thumbnailImageModel: ImageModel.fromMap(map[offerFieldThumbnailImageModel]),
      );
}
