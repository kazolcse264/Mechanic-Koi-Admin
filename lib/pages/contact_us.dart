import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ContactUsPage extends StatelessWidget {
  static const String routeName = '/contact';

  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us Page'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListWheelScrollView(
          itemExtent: 250,
          clipBehavior: Clip.antiAlias,
          diameterRatio: 1.5,
          children: imageGalleryList
              .map((imagePath) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 8.0),
                    child: SizedBox(
                      //height: 50,
                      width: double.infinity,
                      child: Card(
                        color: Colors.black54,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/profile.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
