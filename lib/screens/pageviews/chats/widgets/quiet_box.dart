import 'package:doctorji/utils/universal_variable.dart';
import 'package:flutter/material.dart';
import 'package:doctorji/screens/pages/search_screen.dart';

class QuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          color: UniversalVariables.separatorColor,
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                                  child: Text(
                    "This is where all the contacts are listed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Flexible(
                                  child: Text(
                    "Search for your friends and family to start calling or chatting with them",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Flexible(
                                  child: FlatButton(
                    color: UniversalVariables.lightBlueColor,
                    child: Text("START SEARCHING"),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
