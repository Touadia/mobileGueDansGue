import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gue_dans_gue_mobile/Profile/Profile.dart';
import 'package:gue_dans_gue_mobile/screens/connexion/connexionForm.dart';
import 'package:http/http.dart' as http;
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:gue_dans_gue_mobile/screens/AchatPage/AchatPage.dart';
import 'package:gue_dans_gue_mobile/screens/Machine/EmplacementMachine.dart';
import 'package:gue_dans_gue_mobile/screens/ProfilPage/InfoCompte.dart';
import 'package:gue_dans_gue_mobile/screens/Reglages/Reglages.dart';
//import 'package:gue_dans_gue_mobile/screens/connexion/connexionForm.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildDrawer extends StatefulWidget {
  const BuildDrawer({
    Key? key,
  }) : super(key: key);

  @override
  _BuildDrawerState createState() => _BuildDrawerState();
}

class _BuildDrawerState extends State<BuildDrawer> {
  Profile? profile;

  getUserData() async {
    //entrer la route de l'api, et l'id de celui qui est connecté
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //String token = '123|Fjt1R4iWruVO7FJCunx7n8I0iDkQmcKyKlYAJ07Y';
    final String token = sharedPreferences.getString("token")!;

    var response = await http.get(
      Uri.parse('http://178.128.149.185:33036/api/profile/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    setState(() {
      profile = Profile.fromJson(jsonDecode(response.body));
      sharedPreferences.setString(
          "IdCollecteur", profile!.message!.collecteurId.toString());
    });
    //print(profile!.message!.collecteurId);//j'ai bien l'id du collecteur
  }

  Deconnexion() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("token")!;
    var response = await http.get(
      Uri.parse('http://178.128.149.185:33036/api/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(children: [
      DrawerHeader(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Image(
          image: AssetImage("images/gdg LOGO smile animated 3 GIF.gif"),
          height: 100,
          width: 310,
        ),
        decoration: BoxDecoration(
          color: myBlue,
          // borderRadius: BorderRadius.circular(30)
        ),
      ),
      ListTile(
        title: Text(
          "${profile?.message?.solde ?? '0'} gués",
          style: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
          ),
        ),
        dense: true,
        leading: Text(
          "Solde : ",
          style: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
          ),
        ),
      ),
      Divider(
        height: 20,
      ),
      ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccueilPage()),
          );
        },
        title: Text(
          'Accueil',
          style: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
          ),
        ),
        dense: true,
        leading: Icon(
          Icons.home,
          size: 30,
        ),
      ),
      Divider(
        height: 20,
      ),
      ListTile(
        onTap: () {
          Get.off(InfoCompte());
        },
        title: Text(
          'Profil',
          style: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
          ),
        ),
        dense: true,
        leading: Icon(
          Icons.account_circle_outlined,
          size: 30,
        ),
      ),
      Divider(
        height: 20,
      ),
      ListTile(
        onTap: () {
          Get.off(AchatPage());
        },
        title: Text(
          'Récompenses',
          style: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
          ),
        ),
        dense: true,
        leading: Icon(
          Icons.card_giftcard_outlined,
          size: 30,
        ),
      ),
      Divider(
        height: 20,
      ),
      ListTile(
        onTap: () {
          Get.off(EmplacementMachine());
        },
        title: Text(
          'Nos Machines',
          style: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
          ),
        ),
        dense: true,
        leading: Icon(
          Icons.location_on_outlined,
          size: 30,
        ),
      ),
      Divider(
        height: 20,
      ),
      ListTile(
        onTap: () {
          Get.off(Reglages());
        },
        title: Text(
          'Réglages',
          style: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
          ),
        ),
        dense: true,
        leading: Icon(
          Icons.settings,
          size: 30,
        ),
      ),
      Divider(
        height: 20,
      ),
      ListTile(
        onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                    title: Text("Déconnexion"),
                    content: Text("Voulez vous vraiment vous déconnecter?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Annuler'),
                        child: Text("Annuler"),
                      ),
                      TextButton(
                        onPressed: () {
                          Deconnexion();
                          Navigator.pop(context);
                          Get.off(ConnexionForm());
                        },
                        child: Text("OK"),
                      ),
                    ])),
        title: Text(
          'Deconnexion',
          style: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
          ),
        ),
        dense: true,
        leading: Icon(
          Icons.logout_outlined,
          size: 30,
        ),
      ),
    ]));
  }
}
