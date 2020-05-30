import 'package:doctorji/provider/image_upload_provider.dart';
import 'package:doctorji/resources/auth_methods.dart';

import 'package:doctorji/screens/pages/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctorji/provider/user_provider.dart';
import 'package:doctorji/screens/pages/home_screen.dart';
import 'package:doctorji/screens/pages/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ImageUploadProvider())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Doctor ji',
            initialRoute: '/',
            routes: {
              '/search_screen': (context) => SearchScreen(),
            },
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: FutureBuilder(
              future: _authMethods.getCurrentUser(),
              builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
                if (snapshot.hasData) {
                  return HomeScreen();
                } else {
                  return LoginScreen();
                }
              },
            )));
  }
}
