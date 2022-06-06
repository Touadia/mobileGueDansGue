import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/screens/ArticlePage/Article.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
/*
import 'package:gue_dans_gue/Contants/Constants.dart';
import 'package:gue_dans_gue/Couleurs/AppColors.dart';
import 'package:gue_dans_gue/Pages/ArticlePage/Article.dart';
*/

import 'ArticleTitreImage.dart';

class Body extends StatelessWidget {
  final Article article;

  const Body({Key? key, required this.article}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //nous permet d'avoir acces a toute l'epaisseur et toute la longueur de la page
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: AppColors.blue),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24))),
                    child: Column(
                      children: <Widget>[
                        SizedBox(width: DefaultPaddin),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: DefaultPaddin * 2,
                              height: DefaultPaddin * 2,
                            ),
                            RichText(
                                text: TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    children: [
                                  TextSpan(text: "Taille: \n"),
                                  TextSpan(
                                      text: "${article.size} cm",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black))
                                ])),
                          ],
                        ),

                        ArticleDescription(
                          article: article,
                        ),
                        /*
                        SizedBox(
                          width: DefaultPaddin,
                          height: DefaultPaddin,
                        ),

                        */

                        SizedBox(
                          width: DefaultPaddin * 2,
                          height: DefaultPaddin * 2,
                        ),
                        Text(
                          "Mon solde: ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),

                        Container(
                          height: 25,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.blue,
                          ),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            //fonction pour soustraire des points sur le solde
                            onPressed: () {},
                            child: Text("OBTENIR",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        //color: Colors.white,
                        //)
                      ],
                    ),
                  ),
                ),
                ArticleTitreImage(article: article)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ArticleDescription extends StatelessWidget {
  const ArticleDescription({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: DefaultPaddin * 2, horizontal: DefaultPaddin * 2),
        child: Text(article.description,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  //fontWeight: FontWeight.bold,
                  color: Colors.black,
                )));
  }
}
