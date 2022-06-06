import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  var _formKey = GlobalKey<FormState>();
  String? password;
  String? username;
  bool remember = false;
  final List<String> errors = [];
  final List<String> errors_username = [];
  bool _isLoading = false;

  // controller pour recuperer les valeurs saisies dans les inputs des formulaire
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // Représente le message affiché lorqu'un collecteur deja inscrit veut s'inscrire à nouveau
  FToast fToast = new FToast();

/**
 * signin // Fonction de consommation de l'API pour l'authentification (Connexion)
 * 
 * **/

  signIn(String username, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse = null;

    // reponse apres le post
    var response = await http.post(
      Uri.parse('url de ton api'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //
      body: jsonEncode(<String, String>{
        'username': username,
        'password': pass,
      }),
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => AccueilPage()),
            (Route<dynamic> route) => false);*/
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

/**
 * 
 *   Les méthodes d'ajout et d'erreur dans les listes d'erreurs
 * **/
  void addErrorUsername({String? error}) {
    if (!errors_username.contains(error))
      setState(() {
        errors_username.add(error!);
      });
  }

  void removeErrorUsername({String? error}) {
    if (errors_username.contains(error))
      setState(() {
        errors_username.remove(error);
      });
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 35,
          color: Colors.grey,
          onPressed: () {
            /*
            MaterialPageRoute(builder: (BuildContext context) => HomePage());*/
          },
          icon: Icon(Icons.cancel),
        ),
        /*title: Text(
          'CONNEXION',
          style: TextStyle(
            fontFamily: "Helvetica Neue",
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color(0xFF1DABC5),
          ),
        ),*/
        //centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
          width: size.width,
          height: size.height,
          /*decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft,
                  colors: [Colors.blue.withOpacity(.1), Colors.white])),*/
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: [
                //buildusernameFormField(),
                Text(
                  "CONNECTEZ VOUS AVEC VOTRE NOM D'UTILISATEUR",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 80,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildUsernameFormField(),
                      FormErrorUsername(errors_username: errors_username),
                      SizedBox(
                        height: 50,
                      ),
                      buildPasswordFormField(),
                      FormError(errors: errors),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      signIn(usernameController.text, passwordController.text);
                    }
                  },
                  child: Text(
                    "Valider",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                      fontFamily: "Helvetica Neue",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 15,
                      shape: new RoundedRectangleBorder(
                          //borderRadius: new BorderRadius.circular(30.0),
                          //side: BorderSide(color: Colors.blue),
                          ),
                      primary: Colors.lightGreen[200]
                      // backgroundColor:
                      //   MaterialStateProperty.all<Color>(myBlue),
                      //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      ),
                ),
                SizedBox(
                  height: 50,
                ),

                InkWell(
                  onTap: () {
                    /*
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EntrerNum()),
                          );*/
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mot de passe oublié",
                        style: TextStyle(
                          fontFamily: "Helvetica Neue",
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ), /*
                      Icon(
                        Icons.help_rounded,
                        color: Colors.blue.withOpacity(.7),
                      )*/
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Les fonctions de création des champs du formulaire
  TextFormField buildUsernameFormField() {
    return TextFormField(
      //keyboardType: TextInputType.name,
      controller: usernameController,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeErrorNumTel(error: kUsernameNullError);
        // }
        // return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addErrorUsername(
              error: "Entrez votre nom d'utilisateur s'il vous plait");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "Nom d'utilisateur",
        labelStyle: TextStyle(
            fontFamily: "Helvetica Neue",
            fontSize: 20,
            color: Colors.black.withOpacity(.5)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(11),
        ),
        errorBorder: OutlineInputBorder(
          // borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(11),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(11)),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      //keyboardType: TextInputType.number,
      controller: passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Entrez votre nom d'utilisateur s'il vous plait");
        } else if (value.length >= 4) {
          removeError(error: "le mot de passe est trop court");
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: "Entrez votre mot de passe s'il vous plait");
          return "";
        } else if (value.length < 4) {
          addError(error: "le mot de passe est trop court");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "Mot de passe",
        labelStyle: TextStyle(
            fontFamily: "Helvetica Neue",
            fontSize: 20,
            color: Colors.black.withOpacity(.5)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(11),
        ),
        errorBorder: OutlineInputBorder(
          // borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(11),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(11)),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? labelTitle;
  const CustomTextField({
    Key? key,
    @required this.labelTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {},
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        labelText: labelTitle,
        labelStyle: TextStyle(
            fontFamily: "Helvetica Neue",
            fontSize: 20,
            color: Colors.black.withOpacity(.5)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(11),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(11),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(11)),
      ),
    );
  }
}

class FormErrorUsername extends StatelessWidget {
  final List<String>? errors_username;
  const FormErrorUsername({
    Key? key,
    @required this.errors_username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(errors_username!.length,
          (index) => formErrorText(error: errors_username![index])),
    );
  }

  Text formErrorText({String? error}) {
    return Text(error!);
  }
}

class FormError extends StatelessWidget {
  final List<String>? errors;
  const FormError({
    Key? key,
    @required this.errors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors!.length, (index) => formErrorText(error: errors![index])),
    );
  }

  Text formErrorText({String? error}) {
    return Text(error!);
  }
}

class FormErrorConformPwd extends StatelessWidget {
  final List<String>? errors_confirm_pwd;
  const FormErrorConformPwd({
    Key? key,
    @required this.errors_confirm_pwd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(errors_confirm_pwd!.length,
          (index) => formErrorText(error: errors_confirm_pwd![index])),
    );
  }

  Text formErrorText({String? error}) {
    return Text(error!);
  }
}
