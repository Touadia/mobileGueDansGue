import 'dart:convert';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/Modeles/HistoriqueDepot.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoriqueDepotPage extends StatefulWidget {
  HistoriqueDepotPage({Key? key}) : super(key: key);
  @override
  _HistoriqueDepotPage createState() => _HistoriqueDepotPage();
}

class _HistoriqueDepotPage extends State<HistoriqueDepotPage> {
  HistoriqueDepot? historiqueDepot;
  bool _isLoading = false;
  String textAffiche = "";

  get token => null;

  Depot() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String token = sharedPreferences.getString("token")!;
    //final IdCollecteur = sharedPreferences.getString("IdCollecteur");
    var response = await http.get(
      Uri.parse('$urlApi/historique/depots/collecteur'),
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
    Depot();
  }

  List<DataRow> GetDepot(dynamic donnee) {
    //List<Widget> list = new List<Widget>();
    List<DataRow> dataRow = [];
    for (var i = 0; i < donnee.length; i++) {
      print("**************************************** -------- ${donnee[i]}");
      dataRow.add(DataRow(cells: [
        DataCell(Text('${donnee[i]["date"]}')),
        DataCell(Text('${donnee[i]["nom"]}')),
        DataCell(Text('${donnee[i]["poids"]}')),
      ]));
    }
    return dataRow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          title: Text("Historique des dépots"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Get.off(AccueilPage());
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: (token != '')
                  ? FutureBuilder<dynamic>(
                      future: Depot(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return SingleChildScrollView(
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        "DATE DU DEPOT ",
                                        maxLines: 2,
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
                                        'MACHINE',
                                        maxLines: 2,
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
                                        'POIDS PLASTIQUE',
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                              rows: GetDepot(snapshot.data),
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
}
