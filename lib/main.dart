// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors


import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quotes_app_db_miner/view/home_screen.dart';
import 'package:quotes_app_db_miner/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: Quote_Home(),
      initialRoute: '/',
      routes: {
        'HomePage': (context) => const QuoteHome(),
        '/': (context) => const SplashScreen(),
      },

    );
  }
}