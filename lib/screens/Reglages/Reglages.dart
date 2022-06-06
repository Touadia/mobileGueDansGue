import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/Couleurs/AppColors.dart';
import 'package:gue_dans_gue_mobile/constants/AppRequest.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';
import 'package:get/get.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reglages extends StatefulWidget {
  Reglages({Key? key}) : super(key: key);
  @override
  _Reglages createState() => _Reglages();
}

class _Reglages extends State<Reglages> {
  final TextEditingController passwordController = new TextEditingController();
  String? password;
  final List<String> errors = [];
  bool _isLoading = false;
  final TextEditingController passwordconfirmationController =
      new TextEditingController();
  String? passwordconfirmation;
  bool _checkBoxVal = false;
  String TextGris = "Passer au mode sombre";
  String TextBlue = "Mode clair activé";

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
    var _formKey = GlobalKey<FormState>();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          //title: Text("Réglages"),
          backgroundColor: Colors.grey[200],
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.off(AccueilPage());
            },
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: queryData.size.width,
          //height: queryData.size.height,
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text("Une mise à jour logicielle est disponble",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 35)),
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: queryData.size.width / 3,
                          margin:
                              EdgeInsets.only(left: queryData.size.width / 10),
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
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[300]),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Plus tard",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: queryData.size.width / 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin:
                              EdgeInsets.only(right: queryData.size.width / 10),
                          width: queryData.size.width / 3,
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
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey[300]),
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Mettre à jour",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50),
              Container(
                padding:
                    EdgeInsets.fromLTRB(queryData.size.width / 1.2, 0, 0, 0),
                child: IconButton(
                  iconSize: 30,
                  color: Colors.black87,
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 10.0,
                        blurRadius: 20.0,
                        offset: Offset(10.0, 10.0),
                        // shadow direction: bottom right
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              width: 40,
                              child: Icon(
                                Icons.security,
                                color: Colors.grey[600],
                                size: 30,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                          child: TextButton(
                        onPressed: () {
                          showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title:
                                        const Text("Changer de mot de passe"),
                                    content: Form(
                                      key: _formKey,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          width: queryData.size.width - 30,
                                          height: queryData.size.height / 4,
                                          child: Column(
                                            children: [
                                              buildPasswordFormField(),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              buildPasswordconfirmationFormField()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Retour'),
                                        child: const Text(
                                          'Retour',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          String message = "";

                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            Navigator.pop(context);

                                            message = AppRequest.ChangePassword(
                                                passwordController.text,
                                                passwordconfirmationController
                                                    .text);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              message,
                                              style: TextStyle(fontSize: 20),
                                              //action: SnackBarAction(La)
                                            )));
                                          } else {
                                            //ScaffoldMessenger scaffoldMessenger;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Le mot de passe ne correspond pas. Réessayez!",
                                                      style: TextStyle(
                                                          fontSize: 20))),
                                              //action: SnackBarAction(La)
                                            );
                                          }
                                        },
                                        child: const Text('Valider'),
                                      ),
                                    ],
                                  ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Changer de mot de passe",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: "Helvetica"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Mettez à jour votre mot de passe. Déconnectez-vous puis reconnectez-vous avec le nouveau.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontFamily: "Helvetica"),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 10.0,
                        blurRadius: 20.0,
                        offset: Offset(10.0, 10.0),
                        // shadow direction: bottom right
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Checkbox(
                          onChanged: (bool? value) {
                            if (value != null) {
                              //TextBlue = "Mode sombre activé";
                              //TextGris = "Passer au mode clair";
                              setState(() => {
                                    this._checkBoxVal = value,
                                  });
                            }
                          },
                          value: this._checkBoxVal,
                        )),
                    Expanded(
                      flex: 4,
                      child: Container(
                          child: TextButton(
                        onPressed: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Activer le mode sombre",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: "Helvetica"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Activez le monde sombre quand il fait nuit pour une navigation plus fluide.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontFamily: "Helvetica"),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              /*Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 10.0,
                    blurRadius: 20.0,
                    offset: Offset(10.0, 10.0),
                    // shadow direction: bottom right
                  )
                ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  TextBlue,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontFamily: "Helvetica"
                                      //fontWeight: FontWeight.bold
                                      ),
                                ),
                                Text(
                                  TextGris,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontFamily: "Helvetica"),
                                ),
                              ],
                            ),
                            onChanged: (bool? value) {
                              if (value != null) {
                                TextBlue = "Mode sombre activé";
                                TextGris = "Passer au mode clair";
                                setState(() => {
                                      this._checkBoxVal = value,
                                    });
                              }
                            },
                            value: this._checkBoxVal,
                          )),
                    ),
                    /*Expanded(
                      flex: 3,
                      child: Container(
                          //color: Colors.amber,
                          child: TextButton(
                        onPressed: () {},
                        child: ()
                      )),
                    ),*/
                  ],
                ),
              ),*/
              SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 10.0,
                        blurRadius: 20.0,
                        offset: Offset(10.0, 10.0),
                        // shadow direction: bottom right
                      )
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0)),
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  //color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              width: 40,
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey[800],
                                size: 30,
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                          child: TextButton(
                        onPressed: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Supprimer mon compte",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontFamily: "Helvetica"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Toutes vos informations y compris votre solde seront perdues.",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                  fontFamily: "Helvetica"),
                            ),
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      //initialValue: " ",
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
        labelText: "Nouveau mot de passe",
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

  TextFormField buildPasswordconfirmationFormField() {
    return TextFormField(
      //initialValue: " ",
      keyboardType: TextInputType.number,
      controller: passwordconfirmationController,
      obscureText: true,
      onSaved: (newValue) => passwordconfirmation = newValue,
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
        labelText: "Confirmer",
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
