import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';

//import '../../widget/form_error.dart';
import '../home.dart';

class ChangePwd extends StatefulWidget {
  const ChangePwd({Key? key}) : super(key: key);

  @override
  _ChangePwdState createState() => _ChangePwdState();
}

class _ChangePwdState extends State<ChangePwd> {
  var _formKey = GlobalKey<FormState>();

  String? new_password;
  String? conform_password;

  bool remember = false;
  final List<String> errors = [];
  final List<String> errors_confirm_pwd = [];

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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 150, 20, 0),
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
                Text(
                  'MODIFICATION DU MOT ',
                  style: TextStyle(
                    fontFamily: myPolice,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: myBlue,
                  ),
                ),
                Text(
                  'DE PASSE',
                  style: TextStyle(
                    fontFamily: myPolice,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: myBlue,
                  ),
                ),
                SizedBox(
                  height: 43,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );*/
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      obscureText: true,
      onSaved: (newValue) => new_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        new_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
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

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeErrorConfirmPwd(error: kPassNullError);
        } else if (value.isNotEmpty && new_password == conform_password) {
          removeErrorConfirmPwd(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addErrorConfirmPwd(error: kPassNullError);
          return "";
        } else if ((new_password != value)) {
          addErrorConfirmPwd(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: "Confirmer code",
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

// class ChangePwd extends StatefulWidget {
//   const ChangePwd({Key? key}) : super(key: key);

//   @override
//   _ChangePwdState createState() => _ChangePwdState();
// }

// class _ChangePwdState extends State<ChangePwd> {
//   var _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {

//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child:
//           Container(
//             padding: EdgeInsets.fromLTRB(20, 200, 20, 0),
//             width: size.width,
//             height: size.height,
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     begin: Alignment.bottomLeft,
//                     end: Alignment.topLeft,
//                     colors: [myBlue.withOpacity(.1),Colors.white]
//                 )
//             ),
//             child: Column(
//               // mainAxisAlignment: MainAxisAlignment.center,

//               children: [
//                 Text(
//                   'Modification du mot de passe',
//                   style: TextStyle(
//                   fontFamily: myPolice,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                   color: myBlue,
//                   ),

//                 ),
//                 SizedBox(height: 100,),
//                 Form(
//                   key: _formKey = GlobalKey<FormState>(),
//                   child: Column(
//                     children: [
//                       CustomTextField(labelTitle: "Nouveau mot de passe",),
//                       SizedBox(height: 18,),
//                       CustomTextField(labelTitle: "Confirmez",),
//                       SizedBox(height: 18,),

//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 200,),
//                 ElevatedButton(
//                   onPressed: (){
//                     if (_formKey.currentState!.validate()){
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Home()),
//                       );
//                     }

//                   },
//                   child: Text(
//                     "Valider",
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontFamily: myPolice,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     elevation: 15,
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(30.0),
//                       side: BorderSide(color: myBlue),
//                     ),
//                     primary: myBlue
//                     // backgroundColor:
//                     //   MaterialStateProperty.all<Color>(myBlue),
//                     //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
//                   ),

//                 ),
//                 SizedBox(height: 25,),
//                 Text(
//                   "Vous recevrez un code de validation",
//                   style: TextStyle(
//                     color: myBlue,
//                     fontSize: 15,
//                     fontFamily: myPolice,
//                   ),
//                 ),
//                 Text(
//                   "Via SMS sur votre numéro !",
//                   style: TextStyle(
//                     color: myBlue,
//                     fontSize: 15,
//                     fontFamily: myPolice,
//                   ),
//                 ),

//               ],
//             ),
//           ),
//       ),
//     );

//   }
// }
