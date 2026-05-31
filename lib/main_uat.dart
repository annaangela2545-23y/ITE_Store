import 'package:flutter/material.dart';
import 'app.dart';
import 'app/config.dart';

void main() {
  Config().env = 'UAT'; // Set the environment to UAT for testing
  runApp(App());
}
