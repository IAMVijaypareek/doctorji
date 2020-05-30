import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorji/utils/universal_variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileNo extends StatefulWidget {
  @override
  _MobileNoState createState() => _MobileNoState();
}

class _MobileNoState extends State<MobileNo> {
  // String _phone;
  TextEditingController _controller;
  StreamSubscription _subscription;
 
  @override
  void initState() {
    
    
    super.initState();
    uidkliye();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_subscription != null) _subscription.cancel();
    super.dispose();
  }

  void uidkliye() async {
    final uid = (await FirebaseAuth.instance.currentUser()).uid;
    _subscription = Firestore.instance
        .collection('users')
        .document(uid)
        .snapshots()
        .listen(
            (DocumentSnapshot snapshot) => this._onDatabaseUpdate(snapshot));
  }

  void _onDatabaseUpdate(DocumentSnapshot snapshot) {
    setState(() {
      _controller.text = snapshot.data["mobileNo"];
    });
  }

  void create() async {
    try {
      print((await FirebaseAuth.instance.currentUser()).uid);
      final uid = (await FirebaseAuth.instance.currentUser()).uid;
      await Firestore.instance.collection('users').document(uid).updateData({
        'mobileNo': _controller.text,
      });
      //firestore.collection('userData').document(uid).collection('Customer Coll').
      //document('Cust Doc').snapshots().listen((DocumentSnapshot snapshot) =>
      //this._onDatabaseUpdate(snapshot) );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UniversalVariables.blackColor,
        body: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    maxLength: 10,
                    cursorColor: Colors.blue,
                    controller: _controller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        prefixIcon: Icon(Icons.phone),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter no ',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blueAccent, width: 32.0),
                            borderRadius: BorderRadius.circular(25.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 32.0),
                            borderRadius: BorderRadius.circular(25.0))),
                    onChanged: (text) {
                      print("First text field: $_controller.text");
                      _controller.text;
                    },
                  ),
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      elevation: 20,
                      //color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                        /*side: BorderSide(color: Colors.red)*/
                      ),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Center(
                                  child: Text("Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Helvetica",
                                          fontSize: 25))))),
                      onPressed: () {
                        create();
                        return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the that user has entered by using the
                                // TextEditingController.
                                content: Text("Saved Successfully"),
                              );
                            });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
