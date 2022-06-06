import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/screens/connexion/connexionForm.dart';
import 'package:gue_dans_gue_mobile/screens/inscription/sign_up_form.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';

class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var _formKey = GlobalKey<FormState>();

    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 75),
      //margin: EdgeInsets.all(30),
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: [myBlue.withOpacity(.2), Colors.white])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Text('Mot de passe oublie',style: TextStyle(color: ,fontSize: size.width*25/iphoneWidth,fontWeight: FontWeight.bold),),
          SizedBox(
            height: 500,
          ),
          CustomElevatedButton(
            titre: "S'INSCRIRE",
          ),
          SizedBox(
            height: 29,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnexionForm()),
              );
            },
            child: Text(
              "SE CONNECTER",
              style: TextStyle(
                fontFamily: myPolice,
                fontSize: 25,
                color: myBlue,
              ),
            ),
          ),
        ],
      ),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String? titre;
  const CustomElevatedButton({
    Key? key,
    this.titre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpForm()),
        );
      },
      child: Text(
        titre!,
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
          primary: myBlue),
    );
  }
}
