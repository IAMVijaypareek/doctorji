import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //Handles Auth
  /* handleAuth() {
    return StreamBuilder(
        stream: Firestore.instance.collection("users").where('mobileNo',isEqualTo: user.phoneNo).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MobileNo();
          } else {
            return MobileNoVerify();
          }
        });
  }
*/
  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  // GET UID

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);

    signIn(authCreds);
  }
}
