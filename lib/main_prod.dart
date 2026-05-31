import 'package:flutter/material.dart';
import 'app.dart';
import 'app/config.dart';

void main() {
  Config().env = 'PROD'; // Set the environment to PROD for production
  runApp(App());
}
