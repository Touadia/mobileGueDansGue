//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/screens/connexion/connexionForm.dart';
import 'package:gue_dans_gue_mobile/screens/inscription/sign_up_form.dart';

/*
import 'package:gue_dans_gue/Couleurs/AppColors.dart';
import 'package:gue_dans_gue/Pages/AchatPage/AchatPage.dart';
import 'package:gue_dans_gue/Pages/ConnexionForm/connexionForm.dart';
*/
class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          //SingleChildScrollView(
          //scrollDirection: Axis.vertical,
          Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topLeft,
                colors: [AppColors.blue.withOpacity(.2), Colors.white])),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: Image.asset("images/logo.png"),
            ),
            //SizedBox(30),
            Positioned(
              //left: 20,
              //bottom: 50,
              // ignore: deprecated_member_use
              child: ElevatedButton(
                child: Text(
                  "S'inscrire",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 15,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side:
                            BorderSide(color: AppColors.blue.withOpacity(.2)))),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignUpForm()),
                      (Route<dynamic> route) => true);
                },
              ),
            ),
            Container(
              child: Positioned(
                //left: 20,
                //bottom: 50,
                child: TextButton(
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                      color: AppColors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    //il y a un problème qui se passe avec les push, quand on relance la page, après connexion, ca ne passe pas, on a des erreurs
                    /* Par contre avec juste
                MaterialPageRoute(
                              builder: (BuildContext context) => ConnexionForm()),
      
      Ça passe
      
                      */
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => ConnexionForm()),
                        (Route<dynamic> route) => true);
                  },
                ),
              ),
            )
          ],
        ),
      ),
      //),
      //backgroundColor: Colors.black,
      backgroundColor: Colors.white,
      //backgroundColor: Colors.deepPurple[100],
    );
  }
}
