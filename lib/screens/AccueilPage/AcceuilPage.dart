import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/Modeles/TotalDepot.dart';
import 'package:gue_dans_gue_mobile/Modeles/TotalDepot.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/Profile/Profile.dart';
import 'package:gue_dans_gue_mobile/screens/AchatPage/AchatPage.dart';
import 'package:gue_dans_gue_mobile/screens/HistoriqueAchatPage/HistoriqueAchatPage.dart';
import 'package:gue_dans_gue_mobile/screens/HistoriqueDepotPage/HistoriqueDepotPage.dart';
import 'package:gue_dans_gue_mobile/screens/Machine/EmplacementMachine.dart';
import 'package:gue_dans_gue_mobile/screens/ProfilPage/InfoCompte.dart';
import 'package:gue_dans_gue_mobile/screens/Reglages/Reglages.dart';
import 'package:gue_dans_gue_mobile/screens/connexion/connexionForm.dart';
//import 'package:gue_dans_gue_mobile/screens/sideBar/sideBar.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

//import 'package:interface_connexion_gdg_actualise_2/values/values.dart';

class AccueilPage extends StatefulWidget {
  AccueilPage({Key? key}) : super(key: key);
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  TotalDepot? totalDepot;
  Profile? profile;
  int? total;
  getUserData() async {
    //entrer la route de l'api, et l'id de celui qui est connecté
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //String token = '123|Fjt1R4iWruVO7FJCunx7n8I0iDkQmcKyKlYAJ07Y';
    final String token = sharedPreferences.getString("token")!;

    var response = await http.get(
      Uri.parse('$urlApi/profile/'),
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
      Uri.parse('$urlApi/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
  }

  TotalDesDepot() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("token")!;
    var response = await http.get(
      Uri.parse('$urlApi/statistique/mobile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    //totalDepot = TotalDepot.fromJson(jsonDecode(response.body));
    var totalDepot = jsonDecode(response.body) as Map<String, dynamic>;
    print(" ----------------->>  ${totalDepot['message']}");
    setState(() {
      total = totalDepot['message'];
    });
    return totalDepot['message'];
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    TotalDesDepot();
  }

  @override
  Widget build(BuildContext context) {
    //Adapter la page à la taille de l'ecran
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    /*RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );*/
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          foregroundColor: Colors.grey[100],
          backgroundColor: Colors.grey[100],
          elevation: 0,
          iconTheme: new IconThemeData(
              //color: AppColors.blue,
              size: 60),
          actions: [],
          //elevation: 0.5,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              width: queryData.size.width,
              //height: queryData.size.height,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                //borderRadius: BorderRadius.circular(30)
              ),
              //color: Colors.transparent,
              child: Column(children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  //padding: EdgeInsets.only(left: 10),
                  //margin: EdgeInsets.only(top: 50),
                  child: Container(
                    //margin: EdgeInsets.only(right: 200),
                    //child: Padding(
                    //padding: EdgeInsets.only(right: 175),
                    child: Text("Bienvenue ${profile?.message?.prenom ?? ''} !",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontFamily: "Helvetica Neue",
                            //color: Color(0xff1dabc5),
                            color: Colors.black,
                            //fontWeight: FontWeight.bold,
                            //fontWeight: FontWeight.w300,
                            fontSize: 25)),
                    //),
                  ),
                ),
                /*Center(child: Image.asset("/images/sourireOrange.png")),*/
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          //padding: EdgeInsets.only(left: 5),
                          width: queryData.size.width / 2.3,
                          height: 110,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 10.0,
                                  blurRadius: 20.0,
                                  offset: Offset(10.0, 10.0),
                                  // shadow direction: bottom right
                                )
                              ],
                              color: AppColors.blue,
                              //color: Color(0xff1dabc5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Bouteilles collectées:",
                                //textAlign: TextAlign.start,
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                    //fontFamily: "Helvetica Neue",
                                    fontSize: 15,
                                    color: Colors.white,
                                    //color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  "${total ?? 'O'} g",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      //color: Colors.black,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 0.1 * queryData.size.width / 2.1),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right: 15),
                              width: queryData.size.width / 2.3,
                              height: 110,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      spreadRadius: 10.0,
                                      blurRadius: 20.0,
                                      offset: Offset(10.0, 10.0),
                                      // shadow direction: bottom right
                                    )
                                  ],
                                  color: AppColors.blue,
                                  //color: Color(0xff50BE87),
                                  //color: Color(0xff1dabc5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Text(
                                  " ${profile?.message?.solde ?? '0'} gués",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white
                                      //color: Color(0xff1dabc5)
                                      ),
                                ),
                              )

                              /*SizedBox(
                                    height: 30,
                                  ),
                                  /*Text(
                                    "Grade: ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),*/
                                  Center(
                                    child: RatingBar.builder(
                                      unratedColor: Colors.black,
                                      //unratedColor: Colors.grey[200],
                                      itemSize: 25,
                                      initialRating: 2,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      //allowHalfRating: false,
                                      itemCount: 5,
                                      //itemPadding:EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Color(0xffe07312),
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 100),
                                    child: IconButton(
                                        iconSize: 20,
                                        color: AppColors.blue,
                                        onPressed: () {},
                                        icon: Icon(Icons.info)),
                                  )*/

                              ),
                          /*SizedBox(
                                width: 30,
                              ),*/
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 0.1 * queryData.size.width / 2.1,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          width: queryData.size.width / 2.3,
                          height: 110,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 10.0,
                                  blurRadius: 20.0,
                                  offset: Offset(10.0, 10.0),
                                  // shadow direction: bottom right
                                )
                              ],
                              //color: Colors.white,
                              color: Colors.white,
                              //color: Color(0xffA885D8),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Column(
                              children: [
                                IconButton(
                                  iconSize: 50,
                                  color: Colors.black,
                                  onPressed: () {
                                    Get.to(EmplacementMachine());
                                  },
                                  icon: Icon(Icons.location_on_outlined),
                                ),
                                //SizedBox(width: 50),
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text("Les machines",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 0.1 * queryData.size.width / 2.1),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: 15),
                            width: queryData.size.width / 2.3,
                            height: 110,
                            //padding: EdgeInsets.only(left: 40),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 10.0,
                                    blurRadius: 20.0,
                                    offset: Offset(10.0, 10.0),
                                    // shadow direction: bottom right
                                  )
                                ],
                                //color: Colors.white,
                                color: Colors.white,
                                //color: Color(0xffFFD200),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Column(
                                children: [
                                  IconButton(
                                    color: Colors.black,
                                    iconSize: 50,
                                    onPressed: () {
                                      Get.to(AchatPage());
                                    },
                                    icon: Icon(Icons.card_giftcard_outlined),
                                  ),
                                  Text("Faire un achat",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          /*SizedBox(
                                width: 30,
                              ),*/
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      //margin: EdgeInsets.only(),
                      width: queryData.size.width,
                      height: 110,
                      //padding: EdgeInsets.only(left: 40),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 50.0,
                            blurRadius: 10.0,
                            offset: Offset(10.0, 10.0),
                            // shadow direction: bottom right
                          ),
                        ],
                        //color: Colors.white,
                        color: Color(0xffFF7900),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Besoin d'aide ?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Vous pouvez signaler un problème en cliquant ici",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(width: 0.1 * queryData.size.width / 2.1),

                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                        //flex: 1,
                        child: Container(
                      margin: EdgeInsets.only(left: 15),
                      width: queryData.size.width / 2.1,
                      height: 100,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 10.0,
                              blurRadius: 20.0,
                              offset: Offset(10.0, 10.0),
                              // shadow direction: bottom right
                            )
                          ],
                          color: Colors.white,
                          //color: AppColors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: TextButton(
                        onPressed: () {
                          Get.to(HistoriqueDepotPage());
                        },
                        child: Text(
                          "MES DÉPOTS",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      )),
                    )),
                    SizedBox(width: 0.1 * queryData.size.width / 2.1),
                    Expanded(
                      //flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 15),
                        width: queryData.size.width / 2.1,
                        height: 100,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                spreadRadius: 10.0,
                                blurRadius: 20.0,
                                offset: Offset(10.0, 10.0),
                                // shadow direction: bottom right
                              )
                            ],
                            color: Colors.white,
                            //color: Color(0xffFF7900),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: TextButton(
                          onPressed: () {
                            Get.to(HistoriqueAchatPage());
                          },
                          child: Text(
                            "MES ACHATS",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )),
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                /********************** Nombre total de plastique collecté*****************************************/
                //Text("Vous avez collecté ${total ?? 'O'} gramme de plastique"),
                //RatingBar.builder()
                /********************** Nombre total de plastique collecté****************************************/
              ])),
        ),
        drawer: Drawer(
            child: ListView(children: [
          const DrawerHeader(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Image(
              image: AssetImage("images/gdg LOGO smile animated 3 GIF.gif"),
              height: 100,
              width: 310,
            ),
            decoration: BoxDecoration(
              color: Color(0xff1dabc5),
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
            onTap: () => Navigator.pop(context, 'Accueil'),
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
              'Paramètres',
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
        ])));

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*return Scaffold(
      drawer: BuildDrawer(
          //key: key,
          ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              /*
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),*/
              child: Column(
                children: [
                  Image.asset("images/gdg LOGO smile animated 3 GIF.gif"),
                  //SizedBox(height: 30,),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(">>> Glissez  pour afficher le menu"),
                      //ScaleAnimatedText(">>> Glissez pour afficher le menu",),
                      //ColorizeAnimatedText("Glisser vers la droite", textStyle: TextStyle(fontSize: 20), colors: ),
                    ],
                  ),

                  Column(
                    children: [
                      Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 100,
                              //color: Colors.grey.withOpacity(.1),
                              child: Image.asset(
                                "images/bouteilleeau.png",
                              ),
                            ),
                            Container(
                              //color: Colors.grey.withOpacity(.1),
                              width: 200,
                              height: 100,
                              child: Center(
                                child: Text(
                                  "Donnez vos bouteilles\nEt gagnez de nombreux \nlots---------------------->",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            Container(
                              //color: Colors.grey.withOpacity(.1),
                              width: 75,
                              child: Image.asset(
                                "images/cadeauBeige.png",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    //width: 20,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText("Avec Gué dans Gué",
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              //fontWeight: FontWeight.bold
                            )),
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      "Tout le monde y gagne!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    children: [
                      Container(
                        //color: AppColors.blue,
                        width: 100,
                        height: 100,
                        child: Image.asset("images/coin.png"),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                AppColors.orange.withOpacity(.2),
                                Colors.white
                              ])),
                          //color: Colors.amber,
                          //width: 50,
                          //height: 50,
                          child: Column(
                            children: [
                              Text(
                                '\n" Le Gué" ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Monnaie écologique\nPermet d'effectuer des achats sur toutes les machines Gué dans Gué!\nProfitez de nos offres, et restez connecté! \n  ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), /*
                      Expanded(
                          child: Container(
                        //color: AppColors.blue,
                        width: 50,
                        height: 100,
                        child: Image.asset("images/coin.png"),
                      ))*/
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.topRight,
                                colors: [
                              AppColors.orange.withOpacity(.3),
                              Colors.white
                            ])),
                        //color: Colors.amber,
                        //width: 50,
                        //height: 50,
                        child: Column(
                          children: [
                            Text(
                              '\n" Les recompenses" ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Recevez des bons de réduction de \nvos supermarchés préférés.\nFaites vos achats à moindre coût\nen envoyant vos bouteilles\n ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          //color: AppColors.blue,
                          width: 100,
                          height: 100,
                          child: Image.asset("images/bon_reduction.png"),
                        ),
                      ), /*
                      Expanded(
                          child: Container(
                        //color: AppColors.blue,
                        width: 50,
                        height: 100,
                        child: Image.asset("images/coin.png"),
                      ))*/
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Container(
                        //color: AppColors.blue,
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.location_on,
                          size: 75,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                AppColors.orange.withOpacity(.2),
                                Colors.white
                              ])),
                          //color: Colors.amber,
                          //width: 50,
                          //height: 50,
                          child: Column(
                            children: [
                              Text(
                                '\n" Les machines" ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Retrouvez les machines Gué dans Gué\npartout sur le territoire ivoirien\nConsultez la carte pour les localiser\n ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), /*
                      Expanded(
                          child: Container(
                        //color: AppColors.blue,
                        width: 50,
                        height: 100,
                        child: Image.asset("images/coin.png"),
                      ))*/
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );*/
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation) {
      return AchatPage();
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation,
        Widget child) {
      return child;
    },
  );
}
