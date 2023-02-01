const String collectionSubCategory = 'SubCategories';

const String subcategoryFieldServiceId = 'serviceId';
const String subcategoryFieldCategoryId = 'categoryId';
const String subcategoryFieldServiceName= 'serviceName';
const String subcategoryFieldServicePrice = 'servicePrice';


class SubcategoryModel {
  String serviceName;
  String? serviceId;
  String? categoryId;
  num servicePrice;

  SubcategoryModel({
    required this.serviceName,
    this.serviceId,
    this.categoryId,
    required this.servicePrice,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      subcategoryFieldServiceId: serviceId,
      subcategoryFieldCategoryId: categoryId,
      subcategoryFieldServiceName: serviceName,
      subcategoryFieldServicePrice: servicePrice,

    };
  }

  factory SubcategoryModel.fromMap(Map<String, dynamic> map) => SubcategoryModel(
    serviceId: map[subcategoryFieldServiceId],
    categoryId: map[subcategoryFieldCategoryId],
    serviceName: map[subcategoryFieldServiceName],
    servicePrice: map[subcategoryFieldServicePrice],
  );


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubcategoryModel &&
              runtimeType == other.runtimeType &&
              serviceId == other.serviceId;

  @override
  int get hashCode => serviceId.hashCode;
}
