import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:gue_dans_gue_mobile/screens/HomePage/HomePage.dart';
import 'package:gue_dans_gue_mobile/screens/forgot_pwd/entrerNum.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:gue_dans_gue_mobile/widget/form_error.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? conform_password;
  String? phoneNumber;

  //Les listes contenants l'ensemble des erreurs
  final List<String> errors = [];
  final List<String> errors_confirm_pwd = [];
  final List<String> errors_num_tel = [];

  // Représente le message affiché lorqu'un collecteur deja inscrit veut s'inscrire à nouveau
  FToast fToast = new FToast();

  bool _isLoading = false;

  // controller pour recuperer les valeurs saisies dans les inputs des formulaires
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nomController = new TextEditingController();
  final TextEditingController prenomController = new TextEditingController();

  // Fonction de consommation de l'API pour l'authentification (Connexion)
  signIn(String telephone, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse = null;

    // reponse apres le post
    try {
      var response = await http.post(
        Uri.parse('http://178.128.149.185:33036/api/login/collecteur'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        //
        body: jsonEncode(<String, String>{
          'telephone': telephone,
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
          if (jsonResponse["token"] != null) {
            sharedPreferences.setString("token", jsonResponse['token']);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => AccueilPage()),
                (Route<dynamic> route) => false);
          } else {
            final scaffold = ScaffoldMessenger.of(context);
            scaffold.showSnackBar(SnackBar(
              content: Text("Ce compte n'existe pas. Veuillez vous inscrire!"),
              //action: SnackBarAction(La)
            ));
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Impossible de se connecter. "),
        ));
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text("Impossible de se connecter. Veuillez réessayer plus tard."),
      ));
    }
  }

  // Fonction de consommation de l'API pour l'inscription
  SignUp(String nom, String prenom, String telephone, pass) async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //var token = sharedPreferences.getString("token");
    var jsonResponse = null;

    Map data = {
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'password': pass,
      'password_confirmation': pass
    };

    String body = json.encode(data);
    //print("body");
    //print(body);

    http.Response response = await http.post(
      Uri.parse('$urlApi/collecteurs'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',

        //Autorisation d'un autre collecteur authentifié demandée, ce qui n'est pas normal
        //'Authorization': 'Bearer ${token}',
      },
      body: body,
    );
    dynamic reponse = jsonDecode(response.body);
    print('Response status: ${response.statusCode}');
    print("response ----> ${reponse}");
    if (reponse['result'] == 200) {
      jsonResponse = json.decode(response.body);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (jsonResponse != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text("Felicitation!!! Vous venez de créer votre compte.")));
        setState(() {
          _isLoading = false;
        });
        signIn(telephone, pass);
      }
    } else if (reponse['result'] == 500) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ce compte existe deja. Veuillez vous connecter")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //content: Text("Ce compte existe deja. Veuillez vous connecter")));
          content: Text("Une erreur s'est produite. Veuillez réessayer")));
      setState(() {
        _isLoading = false;
      });
      //print("Reponse body 1 ----->" + response.body);
    }
    // print("response ");
    //print("Reponse body 2 ----->" + response.body);

    //print(reponse.statusCode);
  }

  // Les méthodes d'ajout et d'erreur dans les listes d'erreurs
  void addErrorNumTel({String? error}) {
    if (!errors_num_tel.contains(error))
      setState(() {
        errors_num_tel.add(error!);
      });
  }

  void removeErrorNumTel({String? error}) {
    if (errors_num_tel.contains(error))
      setState(() {
        errors_num_tel.remove(error);
      });
  }

  // ***Pour le mot de passe
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

  void addErrorConfirmPwd({String? error}) {
    if (!errors_confirm_pwd.contains(error))
      setState(() {
        errors_confirm_pwd.add(error!);
      });
  }

  void removeErrorConfirmPwd({String? error}) {
    if (errors_confirm_pwd.contains(error))
      setState(() {
        errors_confirm_pwd.remove(error);
      });
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(String toastText) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(toastText),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'INSCRIPTION',
          style: TextStyle(
            fontFamily: myPolice,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: myBlue,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topLeft,
                    colors: [myBlue.withOpacity(.1), Colors.white])),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildNameFormField(),
                      SizedBox(
                        height: 18,
                      ),
                      buildPrenomFormField(),
                      SizedBox(
                        height: 18,
                      ),
                      buildPhoneNumberFormField(),
                      FormErrorNumTel(errors_num_tel: errors_num_tel),
                      SizedBox(
                        height: 18,
                      ),
                      buildPasswordFormField(),
                      FormError(errors: errors),
                      SizedBox(
                        height: 18,
                      ),
                      buildConformPassFormField(),
                      FormErrorConformPwd(
                          errors_confirm_pwd: errors_confirm_pwd),
                      SizedBox(
                        height: 18,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EntrerNum()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Mot de passe oublié",
                              style: TextStyle(
                                fontFamily: myPolice,
                                fontSize: 20,
                                color: myBlue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.help_rounded,
                              color: myBlue.withOpacity(.7),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 100,),
                ElevatedButton(
                  onPressed: () {
                    //_showToast();
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      SignUp(nomController.text, prenomController.text,
                          phoneController.text, passwordController.text);
                    }
                  },
                  child: Text(
                    "Valider",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: myPolice,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 15,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: myBlue),
                      ),
                      primary: myBlue
                      // backgroundColor:
                      //   MaterialStateProperty.all<Color>(myBlue),
                      //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Vous recevrez un code de validation",
                  style: TextStyle(
                    color: myBlue,
                    fontSize: 15,
                    fontFamily: myPolice,
                  ),
                ),
                Text(
                  "Via SMS sur votre numéro !",
                  style: TextStyle(
                    color: myBlue,
                    fontSize: 15,
                    fontFamily: myPolice,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Les fonctions de création des champs du formulaire
  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeErrorNumTel(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addErrorNumTel(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: inputDecoration("Téléphone"),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      keyboardType: TextInputType.number,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 4) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: inputDecoration("Mot de passe"),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeErrorConfirmPwd(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeErrorConfirmPwd(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addErrorConfirmPwd(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addErrorConfirmPwd(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: inputDecoration("Confirmez Mot de Passe"),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      controller: nomController,
      keyboardType: TextInputType.name,
      // obscureText: true,
      // onSaved: (newValue) => conform_password = newValue,
      validator: (value) {
//         // if(value == null || value.isEmpty){
//         //   if(labelTitle =='Téléphone'|| labelTitle =='Mot de passe'|| labelTitle =='Nom'|| labelTitle =='Prenom(s)'|| labelTitle =='Mail'){
//         //     return "*champ obligatoire";
//         //   }

//         //   }
//         // return null;
      },
      decoration: inputDecoration("Nom"),
    );
  }

  TextFormField buildPrenomFormField() {
    return TextFormField(
      controller: prenomController,
      keyboardType: TextInputType.name,
      // obscureText: true,
      // onSaved: (newValue) => conform_password = newValue,
      validator: (value) {
//         // if(value == null || value.isEmpty){
//         //   if(labelTitle =='Téléphone'|| labelTitle =='Mot de passe'|| labelTitle =='Nom'|| labelTitle =='Prenom(s)'|| labelTitle =='Mail'){
//         //     return "*champ obligatoire";
//         //   }

//         //   }
//         // return null;
      },
      decoration: inputDecoration("Prénom"),
    );
  }
}
