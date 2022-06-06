import 'dart:convert';
/*
flutter_map: any
  google_maps_flutter: ^0.2.0+2
*/
import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/Modeles/Position.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:gue_dans_gue_mobile/screens/Machine/DonneeMachine.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:flutter_map/plugin_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmplacementMachine extends StatefulWidget {
  EmplacementMachine({Key? key}) : super(key: key);
  @override
  _EmplacementMachine createState() => _EmplacementMachine();
}

class _EmplacementMachine extends State<EmplacementMachine> {
  get token => null;

  getMachineListe() async {
    //entrer la route de l'api, et l'id de celui qui est connecté
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token")!;
    var response = await http.get(
      Uri.parse('$urlApi/machines/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var ensemble = jsonDecode(response.body) as List<dynamic>;
    for (var i = 0; i < ensemble.length; i++) {
      print("**************************************** -------- ${ensemble[i]}");
    }
    return ensemble;
  }

  void initState() {
    super.initState();
    getMachineListe();
  }

  List<DataRow> ListPosition(dynamic donnee) {
    //List<Widget> list = new List<Widget>();
    List<DataRow> dataRow = [];
    for (var i = 0; i < donnee.length; i++) {
      //print("**************************************** -------- ${donnee[i]}");
      dataRow.add(DataRow(cells: [
        DataCell(
            Text(
              '${donnee[i]["nom"]}',
              //textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ), onTap: () {
          print("Longitude ******---> ${donnee[i]["longitude"]}");
          print("Latitude ******---> ${donnee[i]["latitude"]}");
          Get.to(() => DonneeMachine(
              latitude: donnee[i]["latitude"],
              longitude: donnee[i]["longitude"],
              nom: donnee[i]["nom"]));
        }),
        /*DataCell(
            //Text('${donnee[i]["statut"]}'),
            Text("Localiser ->"), onTap: () {
          print("Longitude ******---> ${donnee[i]["longitude"]}");
          print("Latitude ******---> ${donnee[i]["latitude"]}");
          Get.to(() => DonneeMachine(
              latitude: donnee[i]["latitude"],
              longitude: donnee[i]["longitude"],
              nom: donnee[i]["nom"]));
        }),*/
      ]));
    }
    return dataRow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        title: Text("EMPLACEMENT DES MACHINES"),
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
                    future: getMachineListe(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Center(
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        "Cliquez sur une machine pour la localiser",
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                                /*DataColumn(
                                  label: Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        'ETAT DE LA MACHINE',
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),*/
                              ],
                              rows: ListPosition(snapshot.data),
                            ),
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
      ),
    );
    /*return FlutterMap(
      options: MapOptions(
        //center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
        markers: [
          Marker(
            width: 80.0,
            height: 80.0,
            //point: LatLng(51.5, -0.09),
            builder: (ctx) =>
            Container(
              child: FlutterLogo(),
            ),
          ),
        ],
      )
      ],
    );*/
  }
}
