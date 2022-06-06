import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/screens/ArticlePage/Article.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';

/*
import 'package:gue_dans_gue/Contants/Constants.dart';
import 'package:gue_dans_gue/Pages/ArticlePage/Article.dart';*/

class ArticleTitreImage extends StatelessWidget {
  const ArticleTitreImage({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.titre,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(
            width: DefaultPaddin,
          ),
          Row(
            children: <Widget>[
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: "Prix: ", style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: "\n${article.prix} gués",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold))
              ])),
              SizedBox(width: DefaultPaddin),
              Expanded(
                  child: Image.asset(
                article.image,
                fit: BoxFit.fill,
              )),
            ],
          )
        ],
      ),
    );
  }
}
