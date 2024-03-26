import 'package:ekycdemo/presentation/login_page.dart';
import 'package:flutter/material.dart'; 
import '../classic.dart';
import '../exploratory.dart';
import '../studio.dart';

void main() async {
  // await dotenv.load();

  runApp(const MaterialApp(
    title: 'Onfido',
    home: LoginPage(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Classic"),
                Tab(text: "Studio"),
                Tab(text: "Exploratory"),
              ],
            ),
            title: const Text('Flutter SDK'),
          ),
          body: const TabBarView(
            children: [OnfidoClassic(), OnfidoStudio(), QRCodeScanner()],
          ),
        ),
      ),
    );
  }
}
