import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gue_dans_gue_mobile/screens/otp/validationSignPwd.dart';
import 'package:gue_dans_gue_mobile/screens/sideBar/sideBar.dart';
import 'package:gue_dans_gue_mobile/widget/constants.dart';
import 'package:gue_dans_gue_mobile/widget/form_error.dart';

class EntrerNum extends StatefulWidget {
  const EntrerNum({Key? key}) : super(key: key);

  @override
  _EntrerNumState createState() => _EntrerNumState();
}

class _EntrerNumState extends State<EntrerNum> {
  var _formKey = GlobalKey<FormState>();
  String? password;
  String? phoneNumber;
  bool remember = false;
  final List<String> errors = [];
  final List<String> errors_num_tel = [];

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
      drawer: BuildDrawer(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                'Veuillez entrer votre ',
                style: TextStyle(
                  fontFamily: myPolice,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: myBlue,
                ),
              ),
              Text(
                'numéro de téléphone',
                style: TextStyle(
                  fontFamily: myPolice,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: myBlue,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildPhoneNumberFormField(),
                    FormErrorNumTel(errors_num_tel: errors_num_tel),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ValidationSignPwd()),
                    );
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
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
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
}
