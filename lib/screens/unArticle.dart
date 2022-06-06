import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';

class UnArticle extends StatefulWidget {
  @override
  _UnArticleState createState() => _UnArticleState();
}

class _UnArticleState extends State<UnArticle> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 75),
      //margin: EdgeInsets.all(30),
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: [myBlue.withOpacity(.2), Colors.white])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      ),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
