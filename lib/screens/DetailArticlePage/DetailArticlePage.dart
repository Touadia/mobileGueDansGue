import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:gue_dans_gue_mobile/screens/AchatPage/AchatPage.dart';
import 'package:gue_dans_gue_mobile/screens/ArticlePage/Article.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:get/get.dart';
import 'body.dart';

class DetailArticlePage extends StatelessWidget {
  final Article article;
  //final press;
  const DetailArticlePage({
    Key? key,
    required this.article,
    //this.press,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(context),
      body: Body(
        article: article,
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: article.color,
      elevation: 0,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.blue,
          onPressed: () {
            Get.to(AchatPage());
          }
          //=> Navigator.pop(context)
          ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search), color: AppColors.blue, onPressed: () {}),
        IconButton(
            icon: Icon(Icons.card_travel),
            color: AppColors.blue,
            onPressed: () {}),
        SizedBox(width: DefaultPaddin / 2),
      ],
    );
  }
}
