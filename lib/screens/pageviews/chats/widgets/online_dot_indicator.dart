import 'package:doctorji/enum/user_state.dart';
import 'package:doctorji/models/entity_model/user.dart';
import 'package:doctorji/resources/auth_methods.dart';
import 'package:doctorji/utils/utilities.dart';
import 'package:flutter/material.dart';

class OnlineDotIndicator extends StatelessWidget {
   final String uid;
   final AuthMethods _authMethods =AuthMethods();

   OnlineDotIndicator({this.uid});



  @override
  Widget build(BuildContext context) {
    getColor(int state) {
      switch (Utils.numToState(state)) {
        case UserState.Offline:
          return Colors.red;
        case UserState.Online:
          return Colors.green;
        default:
          return Colors.orange;
      }
    }
    return Align(

      alignment: Alignment.topRight,
      child: StreamBuilder(
        stream: _authMethods.getUserStream(uid: uid),
        builder: (context,snapshot){
          User user;
          if(snapshot.hasData && snapshot.data.data != null)
          {
            user= User.fromMap(snapshot.data.data);
          }
          return Container(
            height: 10.0,
            width: 10.0,
            margin: EdgeInsets.only(right:5,top:5),
            decoration: BoxDecoration(
              shape:BoxShape.circle,
              color:getColor(user?.state)
            ),
          );

        }),
      
    );
  }
}