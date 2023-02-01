

const String collectionCategory = 'Categories';

const String categoryFieldCategoryId = 'categoryId';
const String categoryFieldCategoryName = 'categoryName';
const String categoryFieldSubCategoryModel = 'subcategoryModel';


class CategoryModel {
  String? categoryId;
  String categoryName;
  CategoryModel({
    this.categoryId,
    required this.categoryName,


  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      categoryFieldCategoryId: categoryId,
      categoryFieldCategoryName: categoryName,

    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
    categoryId: map[categoryFieldCategoryId],
    categoryName: map[categoryFieldCategoryName],

  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId;

  @override
  int get hashCode => categoryId.hashCode;
}
