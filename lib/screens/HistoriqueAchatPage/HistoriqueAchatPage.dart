import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
//import 'package:gue_dans_gue_mobile/Modeles/Article.dart';
import 'package:gue_dans_gue_mobile/Modeles/HistoriqueAchat.dart';
import 'package:gue_dans_gue_mobile/Profile/Profile.dart';
import 'package:gue_dans_gue_mobile/screens/AchatPage/AchatPage.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriqueAchatPage extends StatefulWidget {
  HistoriqueAchatPage({Key? key}) : super(key: key);

  @override
  _HistoriqueAchatPage createState() => _HistoriqueAchatPage();
}

class _HistoriqueAchatPage extends State<HistoriqueAchatPage> {
  HistoriqueAchat? historiqueAchat;
  Profile? profile;
  bool _isLoading = false;
  String textAffiche = "";

  get token => null;

  /*************************** HISTORIQUE DES ACHATS ******************************************* */
//Pour afficher l'historique des achats il faut faire une requete get avec l'id du collecteur

  HistoriquePersonnel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("token")!;
    //final IdCollecteur = sharedPreferences.getString("IdCollecteur");
    var response = await http.get(
      Uri.parse('$urlApi/historique/achats/collecteur'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var obj = jsonDecode(response.body) as Map<String, dynamic>;
    var message = obj["message"];

    return message;
    /*setState(() {
      historiqueAchat = HistoriqueAchat.fromJson(jsonDecode(response.body));
    });*/
  }

  void initStates() {
    super.initState();
    HistoriquePersonnel();
  }

  /**************************************************************************************************** */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          title: Text("Historique des achats"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Get.off(AchatPage());
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: (token != '')
                  ? FutureBuilder<dynamic>(
                      future: HistoriquePersonnel(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        "DATE ACHAT",
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        'ARTICLE',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        'MONTANT TOTAL',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: GetDataRow(snapshot.data),
                            ),
                          );
                        } else {
                          return Center(
                            child: Text("Chargement en cours..."),
                          );
                        }
                      })
                  : Center(
                      child: Text("Chargement en cours..."),
                    )),
        ));
  }

  List<DataRow> GetDataRow(dynamic donnee) {
    //List<Widget> list = new List<Widget>();
    List<DataRow> dataRow = [];
    for (var i = 0; i < donnee.length; i++) {
      print("**************************************** -------- ${donnee[i]}");
      dataRow.add(DataRow(cells: [
        DataCell(Text('${donnee[i]["date"]}')),
        DataCell(Text('${donnee[i]["nom"]}')),
        DataCell(Text('${donnee[i]["montant"]}')),
      ]));
    }
    return dataRow;
  }
}
