import 'package:flutter/material.dart';

import '../utils/constants.dart';
class PrivacyPolicyPage extends StatelessWidget {
  static const String routeName = '/privacy';

  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeaderSection('Privacy Policy'),
              const Divider(
                thickness: 2,
              ),
              buildPrivacySection(),
              buildHeaderSection('Interpretation'),
              const Divider(
                thickness: 2,
              ),
              buildInterpretationSection(),
              buildHeaderSection('Definitions'),
              const Divider(
                thickness: 2,
              ),
              buildDefinitionSection(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Collecting and Using Your Personal Data',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              buildHeaderSection('Personal Data'),
              const Divider(
                thickness: 2,
              ),
              buildPersonalDataSection(),
              buildHeaderSection('Usage Data'),
              const Divider(
                thickness: 2,
              ),
              buildUsageDataSection(),
              buildHeaderSection('Changes to this Privacy Policy'),
              const Divider(
                thickness: 2,
              ),
              buildUpdatePolicySection(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              buildContactUsSection(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPrivacySection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            child: Text(
              privacy,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }

  Text buildHeaderSection(String title) => Text(
        title,
        style: const TextStyle(fontSize: 20, color: Colors.grey),
      );

  Padding buildInterpretationSection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            child: Text(
              interpretation,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }

  Padding buildDefinitionSection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            child: Text(
              definitions,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }

  Padding buildPersonalDataSection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            child: Text(
              personalData,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }

  Padding buildUsageDataSection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            child: Text(
              usageData,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }

  Padding buildUpdatePolicySection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            child: Text(
              updatePolicy,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
  }

  Padding buildContactUsSection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            child: Text(
              contact,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
