import 'package:doctorji/enum/user_state.dart';
import 'package:doctorji/models/entity_model/user.dart';
import 'package:doctorji/provider/user_provider.dart';
import 'package:doctorji/resources/auth_methods.dart';

import 'package:doctorji/screens/chatscreens/widgets/cached_image.dart';
import 'package:doctorji/screens/pages/login_screen.dart';
import 'package:doctorji/screens/pageviews/chats/widgets/mobile_no.dart';
import 'package:doctorji/screens/pageviews/chats/widgets/shimmering_logo.dart';
import 'package:doctorji/screens/pageviews/chats/widgets/user_image_change.dart';

import 'package:doctorji/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsContainer extends StatelessWidget {
  final AuthMethods authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    signOut() async {
      final bool isLoggedOut = await AuthMethods().signOut();
      if (isLoggedOut) {
        // set userState to offline as the user logs out'
        authMethods.setUserState(
          userId: userProvider.getUser.uid,
          userState: UserState.Offline,
        );

        // move the user to login screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
        );
      }
    }

    return Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(children: [
          CustomAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
              centerTitle: true,
              title: ShimmeringLogo(),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => signOut(),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ]),
          UserDetailsBody(),
        ]));
  }
}

class UserDetailsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final User user = userProvider.getUser;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ImageChange()));
                },
                child: CachedImage(
                  user.profilePhoto,
                  isRound: true,
                  radius: 50,
                  //height: 100.0,
                  //width: 100.0,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user.email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(children: <Widget>[
            Icon(Icons.phone, color: Colors.white, size: 30.0),
            SizedBox(width: 10.0),
            RaisedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MobileNo()));
              },
              child: Text("Click Me",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  )),
            )
          ])
        ],
      ),
    );
  }
}
