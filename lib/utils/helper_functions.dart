import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));


String getFormattedDate(DateTime dateTime, {String pattern = 'dd/MM/yyyy'}) {
  return DateFormat(pattern).format(dateTime);
}