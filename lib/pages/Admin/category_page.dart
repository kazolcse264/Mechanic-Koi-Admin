import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/models/category_model.dart';
import 'package:mechanic_koi_admin/models/subcategory_model.dart';
import 'package:mechanic_koi_admin/providers/service_provider.dart';
import 'package:mechanic_koi_admin/utils/widget_functions.dart';
import 'package:provider/provider.dart';


class CategoryPage extends StatefulWidget {
  static const String routeName = '/category';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool _isInnerListVisible = false;

  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddCategoryTextFieldInputDialog(
            context: context,
            title: 'Category',
            positiveButton: 'ADD',
            onSubmit: (value) {
              final subcategoryModel = SubcategoryModel(
                serviceName: value[1],
                servicePrice: value[2],
              );
              final categoryModel = CategoryModel(
                categoryName: value[0],
              );
              serviceProvider.addCategory(categoryModel, subcategoryModel);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: /*Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width/2 - 5,
            child: Consumer<ServiceProvider>(
              builder: (context, provider, child) => ListView.builder(
                itemCount: provider.categoryList.length,
                itemBuilder: (context, index) {
                  final catModel = provider.categoryList[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      tileColor: Colors.grey.shade100,
                      title: Text(catModel.categoryName),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Container(
            width: MediaQuery.of(context).size.width/2 -5,
            child: Consumer<ServiceProvider>(
              builder: (context, provider, child) => ListView.builder(
                itemCount: provider.subcategoryList.length,
                itemBuilder: (context, index) {
                  final catModel = provider.subcategoryList[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      tileColor: Colors.tealAccent,
                      title: Text(catModel.serviceName),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )*/
          Consumer<ServiceProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.categoryList.length,
          itemBuilder: (context, index) {
            final catModel = provider.categoryList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 4.0),
              child: ListTile(
                shape:RoundedRectangleBorder( //<-- SEE HERE
                  side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
                tileColor: const Color(0xFF2B2B2B),

                title: Center(child: Text(catModel.categoryName,style: const TextStyle(fontSize: 25,color: Colors.blue,fontWeight: FontWeight.bold),)),
                onTap: () {
                  setState(() {
                    _isInnerListVisible = !_isInnerListVisible;
                  });
                },
                subtitle:_isInnerListVisible ?  Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.subcategoryList.length,
                    itemBuilder: (BuildContext context, int subIndex) {
                      final subcatModel = provider.subcategoryList[subIndex];
                      return (catModel.categoryId == subcatModel.categoryId ) ?ListTile(
                          shape:RoundedRectangleBorder( //<-- SEE HERE
                            side: const BorderSide(width: 2),
                            borderRadius: BorderRadius.circular(30),),
                        tileColor: Colors.white,
                        title: Text( subcatModel.serviceName ,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        trailing: Text(subcatModel.servicePrice.toString(),style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      ): Container();
                    },
                  ),
                ): Container(),
              ),
            );
          },
        ),
      ),
    );
  }
}
