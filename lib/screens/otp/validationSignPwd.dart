import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/screens/forgot_pwd/changePwd.dart';
import 'package:gue_dans_gue_mobile/screens/inscription/sign_up_form.dart';

import '../../widget/constants.dart';

class ValidationSignPwd extends StatefulWidget {
  const ValidationSignPwd({Key? key}) : super(key: key);

  @override
  _ValidationSignPwdState createState() => _ValidationSignPwdState();
}

class _ValidationSignPwdState extends State<ValidationSignPwd> {
  // var _formKey = GlobalKey<FormState>();

  // ignore: unused_field
  late String _code;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft,
                  colors: [myBlue.withOpacity(.2), Colors.white])),
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Text(
                'Vérification',
                style: TextStyle(
                  fontFamily: myPolice,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                  color: myBlue,
                ),
              ),
              Image(image: AssetImage("images/telephone.png")),
              Text(
                'Entrez votre code de validation ',
                style: TextStyle(
                  fontFamily: myPolice,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black.withOpacity(.5),
                ),
              ),
              Text(
                'envoyé sur votre numéro',
                style: TextStyle(
                  fontFamily: myPolice,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black.withOpacity(.5),
                ),
              ),
              // DecorationImage(
              //   image: AssetImage("images/tele.png"),
              //   fit: BoxFit.cover
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage("images/tele.png"),
              //       fit: BoxFit.contain
              //     )
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              OtpForm(),
              SizedBox(
                height: 20,
              ),
              Row(children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Retour à l'",
                    style: TextStyle(fontFamily: myPolice, fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpForm()),
                      );
                    },
                    child: Text(
                      "inscription",
                      style: TextStyle(
                        fontFamily: myPolice,
                        fontSize: 15,
                        color: myBlue,
                      ),
                    ),
                  ),
                ]),
                SizedBox(
                  width: 35,
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(
                    "Je n'ai reçu aucun code! ",
                    style: TextStyle(fontFamily: myPolice, fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpForm()),
                      );
                    },
                    child: Text(
                      "Renvoyer",
                      style: TextStyle(
                        fontFamily: myPolice,
                        fontSize: 15,
                        color: myBlue,
                      ),
                    ),
                  ),
                ])
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpForm extends StatefulWidget {
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  onChanged: (value) {
                    nextField(value, pin2FocusNode!);
                  },
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: myPolice,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  onChanged: (value) {
                    nextField(value, pin3FocusNode!);
                  },
                  focusNode: pin2FocusNode,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: myPolice,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  onChanged: (value) {
                    nextField(value, pin4FocusNode!);
                  },
                  focusNode: pin3FocusNode,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: myPolice,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode!.unfocus();
                    }
                  },
                  focusNode: pin4FocusNode,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: myPolice,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: myBlue)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePwd()),
              );
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
        ],
      ),
    );
  }
}
