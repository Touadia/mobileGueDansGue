//import 'dart:html';
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Collecteur/Collecteur.dart';
import 'package:gue_dans_gue_mobile/Collecteur/CollecteurTest.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';

import 'ButtonWidget.dart';
import 'ProfileWidget.dart';

class ProfilPage extends StatefulWidget {
  ProfilPage({Key? key}) : super(key: key);
  @override
  _ProfilPage createState() => _ProfilPage();
}

class _ProfilPage extends State<ProfilPage> {
  //final user = CollecteurTest.Test;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
        color: Colors.grey.withOpacity(.1),
        child: ListView(physics: BouncingScrollPhysics(), children: [
          Container(
            padding: EdgeInsets.only(top: 75),
            color: Colors.grey.withOpacity(.1),
          ),
          const SizedBox(
            height: 24,
          ),
          ProfileWidget(
            imagePath: user.image,
            onClicked: () async {},
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Text("Solde: 500 gués"),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: buildUpgradeButton(),
          ),
          Container(
            //color: AppColors.orange.withOpacity(0.3),
            padding: EdgeInsets.all(100),
            child: Form(
                child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Text(
                            "Nom: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  Align(
                    alignment: Alignment(0, -1),
                    child: TextFormField(
                      key: Key("nomkey"),
                      initialValue: user.nom,
                      readOnly: true,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Text("Prénom: ",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                  Align(
                    alignment: Alignment(-1, -0.50),
                    child: TextFormField(
                      key: Key("prenomkey"),
                      initialValue: user.prenom,
                      readOnly: true,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 0),
                          child: Text("Téléphone: ",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                  Align(
                    alignment: Alignment(-1, -0.50),
                    child: modification(),
                  ),
                ],
              ),
            )),
          )
        ]),
      ),
/*
            buildNom(user),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: buildUpgradeButton(),
            ),
            const SizedBox(
              height: 50,
            ),

            
            Container(
                padding: EdgeInsets.only(bottom: 200),
                color: Colors.grey.withOpacity(.1)),*/
    );
  }

  TextFormField modification() {
    return TextFormField(
      key: Key("telkey"),
      initialValue: user.telephone,
    );
  }

  Widget buildNom(Collecteur user) => Column(
        children: [
          Text(
            user.nom,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            user.telephone,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
  Widget buildPrenom(Collecteur user) => Column(
        children: [
          Text(
            user.prenom,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            user.telephone,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  AppBar myAppBar() {
    return AppBar(
      title: Text(
        "Profil",
        style: TextStyle(
          color: AppColors.blue,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0.0,
      leading: BackButton(color: AppColors.blue),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.moon_stars),
          onPressed: () {},
          color: AppColors.blue,
        ),
        IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {},
          color: AppColors.blue,
        )
      ],
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: "Modifier ses informations",
        onClicked: () {},
      );
}
*/