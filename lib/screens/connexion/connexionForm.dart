import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:gue_dans_gue_mobile/screens/HomePage/HomePage.dart';
import 'package:gue_dans_gue_mobile/screens/forgot_pwd/entrerNum.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:gue_dans_gue_mobile/widget/form_error.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class ConnexionForm extends StatefulWidget {
  const ConnexionForm({Key? key}) : super(key: key);

  @override
  _ConnexionFormState createState() => _ConnexionFormState();
}

class _ConnexionFormState extends State<ConnexionForm> {
  var _formKey = GlobalKey<FormState>();
  String? password;
  String? phoneNumber;
  bool remember = false;
  final List<String> errors = [];
  final List<String> errors_num_tel = [];
  bool _isLoading = false;

  // controller pour recuperer les valeurs saisies dans les inputs des formulaire
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // Représente le message affiché lorqu'un collecteur deja inscrit veut s'inscrire à nouveau
  FToast fToast = new FToast();

/**
 * signin // Fonction de consommation de l'API pour l'authentification (Connexion)
 * 
 * **/

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

/**
 * 
 *   Les méthodes d'ajout et d'erreur dans les listes d'erreurs
 * **/
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
        leading: BackButton(
          color: AppColors.blue,
          onPressed: () {
            //MaterialPageRoute(builder: (BuildContext context) => HomePage());
            Get.to(HomePage());
          },
        ),
        title: Text(
          'CONNEXION',
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
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft,
                  colors: [myBlue.withOpacity(.1), Colors.white])),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,

              children: [
                //buildPhoneNumberFormField(),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                                fontSize: 25,
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
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      signIn(phoneController.text, passwordController.text);
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
      keyboardType: TextInputType.phone,
      controller: phoneController,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeErrorNumTel(error: kPhoneNumberNullError);
        // }
        // return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addErrorNumTel(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "Téléphone",
        labelStyle: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
            color: Colors.black.withOpacity(.5)),
        border: OutlineInputBorder(borderSide: BorderSide(color: myBlue)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: myBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: myBlue),
          borderRadius: BorderRadius.circular(11),
        ),
        errorBorder: OutlineInputBorder(
          // borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(11),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: myBlue),
            borderRadius: BorderRadius.circular(11)),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: passwordController,
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
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "Mot de passe",
        labelStyle: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
            color: Colors.black.withOpacity(.5)),
        border: OutlineInputBorder(borderSide: BorderSide(color: myBlue)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: myBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: myBlue),
          borderRadius: BorderRadius.circular(11),
        ),
        errorBorder: OutlineInputBorder(
          // borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(11),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: myBlue),
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
      validator: (value) {
        // if(value == null || value.isEmpty){
        //   if(labelTitle =='Téléphone'|| labelTitle =='Mot de passe'|| labelTitle =='Nom'|| labelTitle =='Prenom(s)'|| labelTitle =='Mail'){
        //     return "*champ obligatoire";
        //   }

        //   }
        // return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: labelTitle,
        labelStyle: TextStyle(
            fontFamily: myPolice,
            fontSize: 20,
            color: Colors.black.withOpacity(.5)),
        border: OutlineInputBorder(borderSide: BorderSide(color: myBlue)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: BorderSide(color: myBlue),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: myBlue),
          borderRadius: BorderRadius.circular(11),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(11),
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: myBlue),
            borderRadius: BorderRadius.circular(11)),
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      //action: SnackBarAction(La)
    ));
  }
}
