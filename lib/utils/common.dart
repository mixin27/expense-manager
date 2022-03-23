import 'package:expense_manager/widgets/snackbar.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, SnackBar snackBar) {
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
