import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
//import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/Modeles/Article.dart';
//import 'package:gue_dans_gue_mobile/Modeles/ReponseAchat.dart';
import 'package:gue_dans_gue_mobile/Profile/Profile.dart';
//import 'package:gue_dans_gue_mobile/constants/AppRequest.dart';

//import 'package:gue_dans_gue_mobile/screens/DetailArticlePage/DetailArticlePage.dart';
//import 'package:gue_dans_gue_mobile/screens/DetailArticlePage/DetailDialog.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:http/http.dart' as http;
//import 'package:get/get.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:gue_dans_gue_mobile/screens/ProfilPage/InfoCompte.dart';

//import '../home.dart';
//import 'package:gue_dans_gue_mobile/screens/ProfilePage/InfoCompte';
//import 'package:gue_dans_gue/Couleurs/AppColors.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  get token => null;
  Profile? profile;
  String? messageAffiche = "";

  bool _isLoading = false;

  //SharedPreferences sharedPreferences = SharedPreferences.getInstance();
/*
  String _token = '105|Hu2KgTKZasoxByNtjs3us8iJzBsuMWFqJlk92chn';
  //final String token = sharedPreferences.getString("token")!;

  _loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = (prefs.getString('token'))!;
    });
  }

  void initStates() {
    super.initState();
    _loadPref();
  }*/

  static Future<List<Article>> _loadPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("token")!;
    var response = await http.get(
      Uri.parse('$urlApi/articles'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var jsontolist = jsonDecode(response.body) as List;
    return jsontolist.map((tagJson) => Article.fromJson(tagJson)).toList();

    //return  MessageCollecteur.fromJson(jsonDecode(response.body));
  }

  void initStates() {
    super.initState();
    _loadPref();
  }

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

    //print(jsonDecode(response.body));

    setState(() {
      profile = Profile.fromJson(jsonDecode(response.body));
    });

    return profile;
  }

  //****************** */

  // ignore: non_constant_identifier_names
  void FaireUnAchat(
      dynamic collecteurId, dynamic articleId, dynamic quantite) async {
    //print("Lancement de la fonction");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("token")!;
    //var jsonResponse = null;
    //print("Partie1");
    var reponse = await http.post(Uri.parse("$urlApi/historique/achats"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<dynamic, dynamic>{
          "collecteur_id": collecteurId.toString(),
          "details": [
            {
              "article_id": articleId.toString(),
              "quantite": quantite.toString()
            }
          ]
        }));

    /************************************************************ */

    /************************************************************ */

    //print("Partie2");

    if (reponse.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(reponse.body);

      int? resultat = jsonResponse['result'];
      String? message = jsonResponse['message'];
      print("result ------> " + resultat.toString());

      if (resultat.toString() == '200') {
        print("l'achat passe");
        //messageAffiche = "Achat effectué avec succès! Merci pour le Gué!!!";
        //final scaffold = ScaffoldMessenger.of(context);
        ScaffoldMessenger?.maybeOf(context)!.showSnackBar(SnackBar(
          content: Center(
              child: Text("Achat effectué avec succès! Merci pour le Gué!!!",
                  style: TextStyle(fontSize: 20))),
          //action: SnackBarAction(La)
        ));
        /*
        setState(() {
          //messageAffiche = "Achat effectué avec succès! Merci pour le Gué!!!";
          _isLoading = false;
        });*/
        //Get.to(() => Home());
        // faire une logique pour dire que l'achat a été effectué avec succés
        //print(
        // "faire une logique pour dire que l'achat a été effectué avec succés");
      } else {
        //final scaffold = ScaffoldMessenger.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
              child: Text("Vous n'avez pas assez d'argent pour cet article!!",
                  style: TextStyle(fontSize: 20))),
          //action: SnackBarAction(La)
        ));
        //messageAffiche = "Vous n'avez pas assez d'argent pour cet article!";
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      //messageAffiche = "Impossible d'effectuer un achat! Veuillez réessayer.";
      //final scaffold = ScaffoldMessenger.of(context);
      ScaffoldMessenger?.of(context).showSnackBar(SnackBar(
        content: Center(
          child: Text(
            "Impossible d'effectuer un achat! Veuillez réessayer plus tard.",
            style: TextStyle(fontSize: 20),
          ),
        ),
        //action: SnackBarAction(La)
      ));
      setState(() {
        _isLoading = false;
      });
      //print(response.body);
      //print("Partie3");
      // Achat n'a pas été effectué
      //print("Achat n'a pas été effectué");
    }
    //return print("bien effectuee");
  }
  //****************** */

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DefaultPaddin),
          child: Text(
            "RECOMPENSES",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
            child: (token != '')
                ? FutureBuilder<List<Article>>(
                    future: _loadPref(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.75,
                          ),
                          itemBuilder: (context, index) => ItemCard(
                              article: snapshot.data[index],
                              press: () {
                                print(snapshot.data[index].id);
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                              "Obtenir cette recompense? "),
                                          content: const Text(
                                            "Confirmez ou annuler la selection",
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Retour'),
                                              child: const Text('Retour'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                getUserData();
                                                //print("Partie4");

                                                FaireUnAchat(
                                                    profile!
                                                        .message?.collecteurId,
                                                    snapshot.data[index].id,
                                                    1);
                                                Navigator.pop(context);

                                                /*final scaffold =
                                                    ScaffoldMessenger.of(
                                                        context);
                                                scaffold.showSnackBar(SnackBar(
                                                  content: Text(messageAffiche!,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  //action: SnackBarAction(La)
                                                ));
                                                print("messageAffiche ----> " +
                                                    messageAffiche!);*/
                                              },
                                              child: const Text('Obtenir'),
                                            ),
                                          ],
                                        ));
                              }),
                        );
                      } else {
                        return Center(
                          child: Text("Chargement en cours..."),
                        );
                      }
                    },
                  )
                : Center(
                    child: Text("Chargement en cours..."),
                  )),
      ],
    );
  }
}

class ItemCard extends StatelessWidget {
  final Article article;
  final Function press;
  const ItemCard({
    Key? key,
    required this.article,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return press();
      },
      child: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(DefaultPaddin),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 10.0,
                      blurRadius: 10.0,
                      offset: Offset(10.0, 10.0),
                      // shadow direction: bottom right
                    ),
                  ],
                  color: Colors.white,
                  //color: AppColors.blue.withOpacity(.1),
                  borderRadius: BorderRadius.circular(16)),
              child: (article.image == "")
                  ? Icon(Icons.not_interested_rounded)
                  : Image.memory(
                      Uri.parse("data:image/png;base64,${article.image}")
                          .data!
                          .contentAsBytes()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: DefaultPaddin / 4),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  article.nom!,
                  maxLines: 1,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Text(
              "${article.prixUnitaire} gués",
              style: TextStyle(color: AppColors.blue),
            ),
            /*
            // ignore: deprecated_member_use
            FlatButton(
              onPressed: () {},
              child: Text(
                "Obtenir",
                style: TextStyle(color: Colors.white),
              ),
              color: AppColors.blue,
            )*/
          ],
        ),
      ),
    );
    //return gestureDetector;
  }
}
