import 'package:flutter/material.dart';

customSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text("Coming soon"),
    backgroundColor: Colors.indigoAccent,
    duration: Duration(seconds: 2),
  ));
}