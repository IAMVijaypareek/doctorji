import 'package:doctorji/resources/auth_methods.dart';
import 'package:doctorji/screens/pages/home_screen.dart';
import 'package:doctorji/utils/universal_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginPressed = false;
  AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: Stack(children: <Widget>[
                  Positioned(top: 110.0, left: 110.0, child: loginName()),
                  Positioned(
                      top: 170.0,
                      left: 110.0,
                      child: Container(
                          child: Shimmer.fromColors(
                              baseColor: Colors.green,
                              highlightColor: Colors.pink,
                              child: Container(
                                height: 10.0,
                                width: 200.0,
                                color: Colors.green,
                              )))),
                  Positioned(
                    top: 130.0,
                    left: 10.0,
                    child: Container(
                        child: Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: UniversalVariables.senderColor,
                            child: Image(
                                image: AssetImage("images/stethoscope.png"))),
                        //color: Colors.orange,
                        height: 200.0),
                  ),
                  Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      right: 10.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.teal,
                                onPressed: () {
                                  performLogin();
                                },
                                child: Text(
                                  "Login Here with Google",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2)),
                                ))),
                      ))
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginName() {
    return Row(
      children: [
        Text('Beckup',
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                  color: Colors.green,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.3),
            )),
        SizedBox(width: 10.0),
        Text('Bull',
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            )),
      ],
    );
  }

  void performLogin() async {
    setState(() {
      isLoginPressed = true;
    });

    FirebaseUser user = await _authMethods.signIn();

    if (user != null) {
      authenticateUser(user);
    }
    setState(() {
      isLoginPressed = false;
    });
  }

  void authenticateUser(FirebaseUser user) {
    _authMethods.authenticateUser(user).then((isNewUser) {
      setState(() {
        isLoginPressed = false;
      });

      if (isNewUser) {
        _authMethods.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return HomeScreen(
              
            );
          }));
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return HomeScreen(
            
          );
        }));
      }
    });
  }
}
