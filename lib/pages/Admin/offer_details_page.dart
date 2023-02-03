import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mechanic_koi_admin/models/offer_model.dart';
import 'package:mechanic_koi_admin/models/subcategory_model.dart';
import 'package:mechanic_koi_admin/providers/service_provider.dart';
import 'package:mechanic_koi_admin/utils/helper_functions.dart';

import 'package:provider/provider.dart';
import '../../models/date_model.dart';
import '../../models/image_model.dart';
import '../../utils/widget_functions.dart';

class OfferDetailsPage extends StatefulWidget {
  static const String routeName = '/offer_details';

  const OfferDetailsPage({Key? key}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final offerId = ModalRoute.of(context)!.settings.arguments as String;
    final offerModel = serviceProvider.getOfferById(offerId);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Offer Details Page',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.card_giftcard,color: Colors.black,),
            title: const Text('Offer Name',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(offerModel.offerName),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Offer Name',
                  onSubmit: (value) {
                    serviceProvider.updateAdminOfferField(
                        offerId, offerFieldOfferName, value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.category,color: Colors.black,),
            title: const Text('Category Name',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(offerModel.categoryModel.categoryName),
          ),
          ListTile(
            leading: const Icon(Icons.category,color: Colors.black,),
            title: const Text('Sub Category Name',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(offerModel.subcategoryModel.serviceName),
            trailing:Text('Cost : ${offerModel.subcategoryModel.servicePrice.toString()}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent,fontSize: 20),),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month,color: Colors.black,),
            title: const Text('Expired Date',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(getFormattedDate(
                offerModel.offerExpiredDateModel.timestamp.toDate())),
            trailing: IconButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 1),
                );
                serviceProvider.updateAdminOfferField(offerId, '$offerFieldOfferExpiredDateModel.$dateFieldTimestamp', Timestamp.fromDate(selectedDate!),);
                serviceProvider.updateAdminOfferField(offerId, '$offerFieldOfferExpiredDateModel.$dateFieldDay', selectedDate.day);
                serviceProvider.updateAdminOfferField(offerId, '$offerFieldOfferExpiredDateModel.$dateFieldMonth', selectedDate.month);
                serviceProvider.updateAdminOfferField(offerId, '$offerFieldOfferExpiredDateModel.$dateFieldYear', selectedDate.year);
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.description,color: Colors.black,),
            title: const Text('Offer Description',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(offerModel.offerDescription),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Offer Description',
                  onSubmit: (value) {
                    serviceProvider.updateAdminOfferField(
                        offerId, offerFieldOfferDescription, value);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.currency_rupee,color: Colors.black,),
            title: const Text('Offer Price',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(offerModel.offerPrice.toString(),style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,fontSize: 20,),),
            trailing: IconButton(
              onPressed: () {
                showSingleTextFieldInputDialog(
                  context: context,
                  title: 'Offer Price',
                  onSubmit: (value) {
                    num price= num.parse(value);
                    serviceProvider.updateAdminOfferField(
                        offerId, offerFieldOfferPrice, price);
                    serviceProvider.updateAdminOfferField(
                        offerId, '$offerFieldSubCategoryModel.$subcategoryFieldServicePrice', price);
                  },
                );
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
          ListTile(
            leading: Image.network(
              offerModel.thumbnailImageModel.imageDownloadUrl,
              height: 200,
              width: 50,
              fit: BoxFit.cover,
            ),
            title:const Text('Offer Banner Photo',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            trailing: IconButton(
              onPressed: () async {
                final file = await ImagePicker()
                    .pickImage(source: ImageSource.gallery, imageQuality: 70);
                final imageModel =
                    await serviceProvider.uploadImage(file!.path);
                serviceProvider.updateAdminOfferField(offerId, '$offerFieldThumbnailImageModel.$imageFieldImageDownloadUrl', imageModel.imageDownloadUrl);
                serviceProvider.updateAdminOfferField(offerId, '$offerFieldThumbnailImageModel.$imageFieldOfferId', offerId);
                serviceProvider.updateAdminOfferField(offerId, '$offerFieldThumbnailImageModel.$imageFieldOfferTitle', imageModel.title);
              },
              icon: const Icon(Icons.edit,color: Colors.blue,),
            ),
          ),
        ],
      ),
    );
  }
}
