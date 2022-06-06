//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:get/get.dart';
import 'package:gue_dans_gue_mobile/screens/HistoriqueAchatPage/HistoriqueAchatPage.dart';
import 'body.dart';

class AchatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        color: AppColors.blue,
        onPressed: () {
          Get.off(AccueilPage());
        },
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search), color: AppColors.blue, onPressed: () {}),
        IconButton(
            icon: Icon(Icons.history),
            color: AppColors.blue,
            onPressed: () {
              Get.off(HistoriqueAchatPage());
            }),
        SizedBox(width: 20.0 / 2),
      ],
    );
  }
}

Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation) {
      return AccueilPage();
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation,
        Widget child) {
      return child;
    },
  );
}
