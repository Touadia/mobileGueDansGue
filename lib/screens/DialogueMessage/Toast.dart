import 'package:flutter/material.dart';

void _showToast(BuildContext context, String message) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(SnackBar(
    content: Text(message),
    //action: SnackBarAction(La)
  ));
}
