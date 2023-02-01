
import 'package:flutter/material.dart';

import 'helper_functions.dart';

void showMultipleTextFieldInputDialog({
  required BuildContext context,
  required String title,
  String positiveButton = 'OK',
  String negativeButton = 'CLOSE',
  required Function(List) onSubmit,
}) {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final salaryController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Full Name',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Phone Number',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Email Address',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter City',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: zipCodeController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Zip Code',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: address1Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Address Line 1',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: address2Controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Address Line 2',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: genderController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Gender',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Age',
                  ),
                ),
                const SizedBox(height: 5,),
                TextField(
                  controller: salaryController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Salary',
                  ),
                ),
                const SizedBox(height: 5,),
              ],
            ),
          )
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(negativeButton),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.isEmpty) return;
              if (phoneController.text.isEmpty) return;
              if (emailController.text.isEmpty) return;
              if (cityController.text.isEmpty) return;
              if (zipCodeController.text.isEmpty) return;
              if (address1Controller.text.isEmpty) return;
              if (address2Controller.text.isEmpty) return;
              if (genderController.text.isEmpty) return;
              if (ageController.text.isEmpty) return;
              if (salaryController.text.isEmpty) return;
              final name = nameController.text;
              final phone = phoneController.text;
              final email = emailController.text;
              final city = cityController.text;
              final  zip = zipCodeController.text;
              final address1 = address1Controller.text;
              final address2 = address2Controller.text;
              final gender = genderController.text;
              final age = double.parse(ageController.text);
              final salary = double.parse(salaryController.text);
              final List value = [];
              value.add(name);
              value.add(phone);
              value.add(email);
              value.add(city);
              value.add(zip);
              value.add(address1);
              value.add(address2);
              value.add(gender);
              value.add(age);
              value.add(salary);
              Navigator.pop(context);
              onSubmit(value);
            },
            child: Text(positiveButton),
          ),
        ],
      ));
}
void showAddCategoryTextFieldInputDialog({
  required BuildContext context,
  required String title,
  String positiveButton = 'OK',
  String negativeButton = 'CLOSE',
  required Function(List) onSubmit,
}) {
  final categoryNameController = TextEditingController();
  final subCategoryNameController = TextEditingController();
  final subCategoryServicePriceController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: categoryNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Category Name',
                    ),
                  ),
                  const SizedBox(height: 5,),
                  TextField(
                    controller: subCategoryNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter SubCategory Name',
                    ),
                  ),
                  const SizedBox(height: 5,),
                  TextField(
                    controller: subCategoryServicePriceController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter SubCategory Service Price',
                    ),
                  ),
                  const SizedBox(height: 5,),

                ],
              ),
            )
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(negativeButton),
          ),
          TextButton(
            onPressed: () {
              if (categoryNameController.text.isEmpty) return;
              if (subCategoryNameController.text.isEmpty) return;
              if (subCategoryServicePriceController.text.isEmpty) return;
              final categoryName = categoryNameController.text;
              final subcategoryName = subCategoryNameController.text;
              final subCategoryServicePrice = double.parse(subCategoryServicePriceController.text);
              final List value = [];
              String categoryDocumentName = categoryName.trim();
              categoryDocumentName = categoryDocumentName.split(" ").map((word) => word[0].toUpperCase()+word.substring(1)).join(" ");
              value.add(categoryDocumentName);
              String subcategoryDocumentName = subcategoryName.trim();
              subcategoryDocumentName = subcategoryDocumentName.split(" ").map((word) => word[0].toUpperCase()+word.substring(1)).join(" ");

              value.add(subcategoryDocumentName);
              value.add(subCategoryServicePrice);
              Navigator.pop(context);
              onSubmit(value);
            },
            child: Text(positiveButton),
          ),
        ],
      ));
}
void showSingleTextFieldInputDialog({
  required BuildContext context,
  required String title,
  String positiveButton = 'OK',
  String negativeButton = 'CLOSE',
  required Function(String) onSubmit,
}) {
  final textController = TextEditingController();
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: 'Enter $title',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(negativeButton),
          ),
          TextButton(
            onPressed: () {
              if (textController.text.isEmpty) return;
              final value = textController.text;
              Navigator.pop(context);
              onSubmit(value);
            },
            child: Text(positiveButton),
          ),
        ],
      ));
}
showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  String positiveButtonText = 'OK',
  required VoidCallback onPressed,
}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CLOSE')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                onPressed();
              },
              child: Text(positiveButtonText)),
        ],
      ));
}

String get generateOrderId => 'PB_${getFormattedDate(DateTime.now(),pattern: 'yyyyMMdd_HH:MM:ss')}';
