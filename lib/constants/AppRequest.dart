import 'package:flutter/foundation.dart';
import 'package:gue_dans_gue_mobile/Collecteur/Collecteur.dart';
import 'package:gue_dans_gue_mobile/Collecteur/message_collecteur.dart';
import 'package:gue_dans_gue_mobile/Modeles/Article.dart';
import 'package:gue_dans_gue_mobile/Profile/Profile.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppRequest {
  static Future<Collecteur> getprofile(String token) async {
    var response = await http.get(
      Uri.parse('$urlApi/profile/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    return Collecteur.fromJson(jsonDecode(response.body));
  }

  static Future<MessageCollecteur> getCollecteur(
      String token, int userId) async {
    var response = await http.get(
      Uri.parse('$urlApi/collecteurs/getCollecteurByUserId/$userId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    return MessageCollecteur.fromJson(jsonDecode(response.body));
  }

  static Future<List<Article>> getArticle(String token) async {
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

  static ChangePassword(String password, String passwordconfirmation) async {
    String message = "";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String IdCollecteur = sharedPreferences.getString("IdCollecteur")!;
    final String token = sharedPreferences.getString("token")!;

    if (password == passwordconfirmation) {
      var response = await http.post(
        Uri.parse('$urlApi/collecteurs/${IdCollecteur}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          //'id': (user?.message?.id).toString(),
          'password': password,
          'passwordconfirmation': passwordconfirmation
        }),
      );

      var jsonResponse = jsonDecode(response.body) as Map<dynamic, dynamic>;
      print("Le code est bon");
      print(jsonResponse);
      print(jsonResponse["message"]);
      if (jsonResponse["result"] == 200) {
        print("Ok, mot de passe mis a jour");
        message = "Ok, mot de passe mis a jour";
      } else {
        print("Une erreur s'est produite");
        message = "Une erreur s'est produite";
      }
    } else {
      print("Le mot de passe ne correspond pas");
      message = "Le mot de passe ne correspond pas";
    }
    return message;
  }

  SupprimerCompte() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token")!;
    var IdCollecteur = sharedPreferences.getString("IdCollecteur");
    var response = await http
        .delete(Uri.parse("$urlApi/collecteurs/"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });

    var jsonreponse = jsonDecode(response.body) as Map<dynamic, dynamic>;
    if (jsonreponse["result"] == 200) {
      print("Suppression effectuée avec succes");
    } else {
      print("une erreur s'est produite");
    }
  }
}
