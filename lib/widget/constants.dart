import 'package:flutter/material.dart';


const DefaultPaddin = 20.0;
const myGreen = Color(0xFF1e8b0c);
const myBlue = Color(0xFF1DABC5);
const myOrange = Color(0xFFef7102);
const myPolice = "Helvetica Neue";

const kTextColor = Colors.red;

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Entrez votre email s'il vous plait";
const String kPassNullError = "Entrez votre mot de passe s'il vous plait";
const String kShortPassError = "le mot de passe est trop court";
const String kMatchPassError = "Passwords don't match";
const String kPhoneNumberNullError = "Entrez un numéro de téléphone s'il vous plait";


OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}


var inputDecoration= (String label_text)=>
  InputDecoration(
    fillColor: Colors.white,
    filled: true,
    labelText: label_text,
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
  );


//  l'url de notre API
const String urlApi = 'http://178.128.149.185:33036/api';