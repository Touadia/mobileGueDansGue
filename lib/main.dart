import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';

import 'package:get/get.dart';
import 'package:gue_dans_gue_mobile/screens/HomePage/HomePage.dart';

import 'screens/AchatPage/AchatPage.dart';
import 'screens/HistoriqueAchatPage/HistoriqueAchatPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
