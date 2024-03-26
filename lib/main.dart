import 'package:ekycdemo/singleton/app_context.dart';
import 'package:ekycdemo/presentation/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    /// Handle error log here
  }
  try {
    await AppContext().initDotEnv();
  } catch (e) {
    /// Handle error log here
  }
  runApp(const MaterialApp(
    title: 'Cognito',
    home: LoginPage(),
  ));
}
