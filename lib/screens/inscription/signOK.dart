import 'package:flutter/material.dart';
import 'package:gue_dans_gue_mobile/screens/AccueilPage/AcceuilPage.dart';

import '../../widget/constants.dart';

class SignOK extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var _formKey=GlobalKey<FormState>();
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 250, 0, 50),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft,
                  colors: [myBlue.withOpacity(.2), Colors.white])),
          child: Column(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: myBlue,
                size: 150,
              ),
              SizedBox(
                height: 29,
              ),

              Text(
                'Votre inscription a été prise',
                style: TextStyle(
                  fontFamily: myPolice,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: myBlue,
                ),
              ),
              Text(
                'en compte !',
                style: TextStyle(
                  fontFamily: myPolice,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: myBlue,
                ),
              ),
              SizedBox(
                height: 300,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccueilPage()),
                  );
                },
                child: Text(
                  "Commencer",
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
              // Container(
              //   width: 379,
              //   height: 51,
              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
              //   child: ElevatedButton(
              //       onPressed: (){
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => Home()),
              //           );

              //       },
              //       child: Text(
              //         "Commencer",
              //         style: TextStyle(
              //           fontSize: 25,
              //           fontFamily: myPolice,
              //         ),
              //       ),
              //       style: ElevatedButton.styleFrom(
              //         elevation: 15,
              //         shape: new RoundedRectangleBorder(
              //           borderRadius: new BorderRadius.circular(30.0),
              //           side: BorderSide(color: myBlue),
              //         ),
              //         primary: myBlue
              //         // backgroundColor:
              //         //   MaterialStateProperty.all<Color>(myBlue),
              //         //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
              //       ),

              //     ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
