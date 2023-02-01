import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanic_koi_admin/models/offer_model.dart';
import 'package:mechanic_koi_admin/utils/constants.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../models/date_model.dart';
import '../models/subcategory_model.dart';
import '../providers/service_provider.dart';
import '../utils/helper_functions.dart';

class AddOfferPage extends StatefulWidget {
  static const String routeName = '/add_offer';

  const AddOfferPage({Key? key}) : super(key: key);

  @override
  State<AddOfferPage> createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  late ServiceProvider serviceProvider;
  final _formKey = GlobalKey<FormState>();

  final offerNameController = TextEditingController();
  final offerPriceController = TextEditingController();
  final offerDescriptionController = TextEditingController();
  CategoryModel? catModel;
  SubcategoryModel? subcategoryModel;
  DateTime? offerExpiredDate;
  String? thumbnail;
  final ImageSource _imageSource = ImageSource.gallery;

  @override
  void didChangeDependencies() {
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text(
                  'You must press the App Bar back button to exit this page'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('No'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: const Text('Add-Offer'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 3,
                child: Image.asset('assets/images/offerbg.png'),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      //Offer Name
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: TextFormField(
                          controller: offerNameController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.card_giftcard),
                              hintText: 'Offer Name',
                              labelText: 'Offer Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                      color: Colors.blue, width: 1))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Offer Name is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      //Category Model Dropdown
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: Consumer<ServiceProvider>(
                          builder: (context, provider, child) =>
                              DropdownButtonFormField<CategoryModel>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.category),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 1))),
                                  hint: const Text('Select Category'),
                                  items: provider.categoryList
                                      .map((catModel) => DropdownMenuItem(
                                            value: catModel,
                                            child: Text(catModel.categoryName),
                                          ))
                                      .toList(),
                                  value: catModel,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a category';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      catModel = value;
                                    });
                                  }),
                        ),
                      ),
                      //Sub Category Model Dropdown
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: Consumer<ServiceProvider>(
                          builder: (context, provider, child) =>
                              DropdownButtonFormField<SubcategoryModel>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Icons.category),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                              color: Colors.blue, width: 1))),
                                  hint: const Text('Select Sub Category'),
                                  items: catModel == null
                                      ? [
                                          const DropdownMenuItem<
                                                  SubcategoryModel>(
                                              value: null,
                                              child: Text(
                                                  'Please select a Sub Category'))
                                        ]
                                      : provider.subcategoryList
                                          .where((subcategory) =>
                                              catModel != null &&
                                              subcategory.categoryId ==
                                                  catModel!.categoryId)
                                          .map((subCatModel) =>
                                              DropdownMenuItem(
                                                value: subCatModel,
                                                child: ListTile(
                                                  title:
                                                  Text(subCatModel.serviceName),
                                                  trailing: Text(
                                                    subCatModel.servicePrice
                                                        .toString(),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                  value: subcategoryModel,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select a sub category';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      subcategoryModel = value;
                                    });
                                  }),
                        ),
                      ),
                      // Offer Date Selection
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          color: kPrimaryLightColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton.icon(
                                  onPressed: _selectDate,
                                  icon: const Icon(Icons.calendar_month),
                                  label: const Text('Select Offer Expired Date'),
                                ),
                                Text(offerExpiredDate == null
                                    ? 'No date chosen'
                                    : getFormattedDate(
                                        offerExpiredDate!,
                                      ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Offer Description
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: TextFormField(
                          controller: offerDescriptionController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.description),
                              labelText: 'Offer Description',
                              hintText: 'Offer Description',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  )),),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Offer Description is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      //Offer Price
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: TextFormField(
                          controller: offerPriceController,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.currency_rupee),
                              labelText: 'Offer Price',
                              hintText: 'Offer Price',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 1,
                                  ))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Offer Price is required';
                            }
                            return null;
                          },
                        ),
                      ),
                      // Image Pick Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 4.0,
                        ),
                        child: InkWell(
                          onTap: _getImage,
                          child: Card(
                            color: kPrimaryLightColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 18,
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                      child: Text('Upload Offer Banner')),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Picked Image Show Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 4.0,
                        ),
                        child: Card(
                          color: Colors.white.withOpacity(0.90),
                          child: (thumbnail == null)
                              ? Image.asset('assets/images/offerbg.png')
                              : Image.file(
                                  File(thumbnail!),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      // Save Button
                      Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 4.0,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _saveOffer();
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    offerNameController.dispose();
    offerDescriptionController.dispose();
    offerPriceController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (selectedDate != null) {
      setState(() {
        offerExpiredDate = selectedDate;
      });
    }
  }

  void _getImage() async {
    final file =
        await ImagePicker().pickImage(source: _imageSource, imageQuality: 70);
    if (file != null) {
      setState(() {
        thumbnail = file.path;
      });
    }
  }

  void _saveOffer() async {
    if (thumbnail == null) {
      showMsg(context, 'Please Select an Image');
      return;
    }
    if (offerExpiredDate == null) {
      showMsg(context, 'Please Select a purchase date');
      return;
    }

    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait');
      try {
        final imageModel = await serviceProvider.uploadImage(thumbnail!);
        final offerModel = OfferModel(
          offerExpiredDateModel: DateModel(
            timestamp: Timestamp.fromDate(offerExpiredDate!),
            day: offerExpiredDate!.day,
            month: offerExpiredDate!.month,
            year: offerExpiredDate!.year,
          ),
          offerPrice: num.parse(offerPriceController.text),
          categoryModel: catModel!,
          subcategoryModel: subcategoryModel!,
          offerDescription: offerDescriptionController.text,
          offerName: offerNameController.text,
          thumbnailImageModel: imageModel,
        );
        await serviceProvider.addNewOffer(offerModel);
        EasyLoading.dismiss();
        if (mounted) showMsg(context, 'Offer Saved Successfully');
        resetFields();
        if (mounted)Navigator.pop(context);
      } catch (error) {
        EasyLoading.dismiss();
        if (mounted) showMsg(context, 'Something wrong');
        showMsg(context, error.toString());
      }
    }
  }

  void resetFields() {
    setState(() {
      offerNameController.clear();
      offerDescriptionController.clear();
      offerPriceController.clear();
      offerExpiredDate = null;
      catModel = null;
      subcategoryModel = null;
      thumbnail = null;
    });
  }
}
