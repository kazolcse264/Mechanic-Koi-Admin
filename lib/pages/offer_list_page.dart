import 'package:flutter/material.dart';
import 'package:mechanic_koi_admin/pages/add_offer_page.dart';
import 'package:mechanic_koi_admin/providers/service_provider.dart';
import 'package:mechanic_koi_admin/utils/constants.dart';
import 'package:mechanic_koi_admin/utils/helper_functions.dart';
import 'package:provider/provider.dart';

import 'offer_details_page.dart';

enum _MenuValues {
  edit,
  delete,
}

class OfferListPage extends StatefulWidget {
  static const String routeName = '/offer';

  const OfferListPage({Key? key}) : super(key: key);

  @override
  State<OfferListPage> createState() => _OfferListPageState();
}

class _OfferListPageState extends State<OfferListPage> {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer list Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Recent Offers',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton.icon(
              onPressed: () async {
                Navigator.pushNamed(context, AddOfferPage.routeName);
              },
              icon: const Icon(Icons.card_giftcard),
              label: const Text(
                'New Offer',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.deepPurple,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          (serviceProvider.offerModelList.isEmpty)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Offer not available.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ),
                  ],
                )
              : Consumer<ServiceProvider>(
                  builder: (context, provider, child) => Expanded(
                    child: ListView.builder(
                      itemCount: provider.offerModelList.length,
                      itemBuilder: (context, index) {
                        final offerModel = provider.offerModelList[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () =>  Navigator.pushNamed(context, OfferDetailsPage.routeName,arguments: offerModel.offerId),
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    offerModel.thumbnailImageModel.imageDownloadUrl,
                                  ),
                                ),
                                tileColor: Colors.tealAccent.shade100,
                                title: Text(
                                  offerModel.offerName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  getFormattedDate(offerModel
                                      .offerExpiredDateModel.timestamp
                                      .toDate()),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                trailing: buildPopupMenuButton(context, offerModel.offerId!,provider),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  PopupMenuButton<_MenuValues> buildPopupMenuButton(
      BuildContext context, String offerId, ServiceProvider provider) {
    return PopupMenuButton<_MenuValues>(
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: _MenuValues.edit,
          child: Card(
              color: kPrimaryColor,
              child: ListTile(
                title: Text('Edit',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.edit,color: Colors.white,),
              )),
        ),
        const PopupMenuItem(
            value: _MenuValues.delete,
            child: Card(
              color: kPrimaryColor,
              child: ListTile(
                title: Text('Delete',style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.delete,color: Colors.white,),
              ),
            )),
      ],
      onSelected: (value) {
        switch (value) {
          case _MenuValues.edit:
            Navigator.pushNamed(context, OfferDetailsPage.routeName,arguments: offerId);
            break;
          case _MenuValues.delete:
            provider.deleteOffer(offerId);
            break;
        }
      },
      iconSize: 35,
    );
  }
}
