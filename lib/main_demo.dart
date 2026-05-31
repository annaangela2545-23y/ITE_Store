import 'package:flutter/material.dart';
import 'app.dart';
import 'app/config.dart';

void main() {
  Config().env = 'DEMO'; // Set the environment to DEMO for testing
  runApp(App());
}
