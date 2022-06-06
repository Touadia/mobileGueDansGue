import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Collecteur/Collecteur.dart';
import 'package:gue_dans_gue_mobile/Collecteur/CollecteurTest.dart';
import 'package:gue_dans_gue_mobile/Collecteur/message_collecteur.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/Profile/Profile.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:gue_dans_gue_mobile/screens/Reglages/Reglages.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoCompte extends StatefulWidget {
  InfoCompte({Key? key}) : super(key: key);
  @override
  _InfoCompte createState() => _InfoCompte();
}

class _InfoCompte extends State<InfoCompte> {
  bool _isLoading = false;
  bool isObscurePassword = true;

  Profile? profile;
  MessageCollecteur? userColl;
  final TextEditingController nomController = new TextEditingController();
  final TextEditingController prenomController = new TextEditingController();
  static TextEditingController soldeController = new TextEditingController();
  final TextEditingController telephoneController = new TextEditingController();

//***************Fonction de récupération des données de la bd  ********************************

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
    });
  }

/*
  getCollecteurData() async {
    //entrer la route de l'api, et l'id de celui qui est connecté
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token")!;
    var response = await http.get(
      Uri.parse(
          'http://178.128.149.185:33036/api/collecteurs/getCollecteurByUserId/${user?.message?.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    print('Collecteur response ${response.body}');
    var jsonData = jsonDecode(response.body);

    setState(() {
      userColl = MessageCollecteur.fromJson(jsonData);
    });
  }
*/
  @override
  void initState() {
    super.initState();
    getUserData();
  }

//******************************** MISE À JOUR DES INFOS UTILISATEURS ************************************************
  /*MAJUserData(String solde, String name, String telephone) async {
    //entrer la route de l'api, et l'id de celui qui est connecté
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token")!;
    var response = await http.put(
        Uri.parse(
            'http://178.128.149.185:33036/api/collecteurs/${user?.message?.id}/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: {
          "solde": solde,
          "name": name,
          "telephone": telephone,
        });
    print('mise a jour response ${response.body}');
    print('id: ${user?.message?.id}');
    var jsonData = jsonDecode(response.body);

    setState(() {
      user = Collecteur.fromJson(jsonData);
    });
  }*/

  //la modification se fait dans la table collecteur
  MAJUserData(String nom, String prenom) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //String token = '123|Fjt1R4iWruVO7FJCunx7n8I0iDkQmcKyKlYAJ07Y';
    String token = sharedPreferences.getString("token")!;

    var jsonResponse = null;
    print("mise à jour en cours...");
    //print(token);
    // reponse apres le post
    var response = await http.put(
      /*Uri.parse('$urlApi/login/collecteur/${user?.message?.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //
      body: jsonEncode(<String, String>{
        'telephone': telephone,
        'name': name,
        'solde': solde,
      }),*/
//Uri.parse('$urlApi/collecteurs/${userColl?.id}'),
      Uri.parse('$urlApi/collecteurs/${profile?.message?.collecteurId}'),

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',

        //Autorisation d'un autre collecteur authentifié demandée, ce qui n'est pas normal
        'Authorization': 'Bearer $token',
      },
      //

      body: jsonEncode(<String, String>{
        //'id': (user?.message?.id).toString(),
        'nom': nom,
        'prenom': prenom,
      }),
      //print(user?.message?.nom),
    );

    print("etape 2 de la mise à jours");
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      //print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        //sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => InfoCompte()),
            (Route<dynamic> route) => false);
        print("Mise a jour effectuée");
        //print(response.body);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
//*************************************************************************************

  //final CollecteurTest test = CollecteurTest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text("Profil"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.off(AccueilPage());
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => Reglages());
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child:
              /*Card(
              child: FutureBuilder(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(
                      child: Text("Loading..."),
                    ));
                  }else return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,i){
                      return ListTile(
                        title: Text(snapshot.data[i].nom)
                      );

                    },
                    
                    )
                },
              ),
            )*/

              ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(""),
                          )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          color: AppColors.blue,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Text('SOLDE: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              buildTextField(
                labelText: "Solde",
                placeHolder: "${profile?.message?.solde ?? '0'} gués",
                isPasswordTextField: false,
                controller: soldeController,
              ),
              SizedBox(
                height: 10,
              ),
              Text('NOM: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              buildTextField(
                labelText: "Nom",
                placeHolder: "${profile?.message?.nom ?? ''}",
                isPasswordTextField: false,
                controller: nomController,
              ),
              SizedBox(
                height: 10,
              ),
              Text('PRENOM: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              buildTextField(
                labelText: "Prenom",
                placeHolder: "${profile?.message?.prenom ?? ''}",
                isPasswordTextField: false,
                controller: prenomController,
              ),
              SizedBox(
                height: 10,
              ),
              Text('TÉLÉPHONE: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              buildTextField(
                labelText: "Telephone",
                placeHolder: "${profile?.message?.telephone ?? ''}",
                isPasswordTextField: false,
                controller: telephoneController,
              ),

              //buildTextField("Téléphone", test.telephone, false),
              SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /*
                  OutlinedButton(
                    onPressed: () {},
                    child: Text("Retour",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),*/
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        //print(telephoneController.text);
                        setState(() {
                          MAJUserData(
                            nomController.text,
                            prenomController.text,
                          );
                        });
                      },
                      child: Text(
                        "Sauvegarder",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String labelText,
    required String placeHolder,
    required bool isPasswordTextField,
    required TextEditingController controller,
  }) {
    controller.text = placeHolder;
    return Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: TextField(
            controller: controller,
            obscureText: isPasswordTextField ? isObscurePassword : false,
            decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscurePassword = !isObscurePassword;
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                      ),
                      color: Colors.grey,
                    )
                  : null,
              contentPadding: EdgeInsets.only(bottom: 5),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeHolder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            )));
  }
}
