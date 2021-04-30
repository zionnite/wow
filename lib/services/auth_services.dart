// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:wow/bottom_navigation.dart';
// import 'package:wow/screen/login_screen.dart';
// import 'package:wow/services/error_handler.dart';
//
// /*Firebase Authication service*/
// class AuthService {
//   // FirebaseAuth auth = FirebaseAuth.instance;
//   // handleAuth() {
//     return StreamBuilder(
//       stream: auth.authStateChanges(),
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.hasData) {
//           return Nav();
//         } else {
//           return LoginScreen();
//         }
//       },
//     );
//   }
//
//   signOut() {
//     auth.signOut();
//     print('signout');
//   }
//
//   signIn(String email, String password, BuildContext context) {
//     auth
//         .signInWithEmailAndPassword(email: email, password: password)
//         .then((value) {
//       //print(value);
//     }).catchError((onError) {
//       print(onError);
//       ErrorHandler().errorDialog(context, onError);
//     });
//   }
//
//   fbSignIn() {}
//
//   //Signup a new user
//   signUp(String email, String password) {
//     return FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//   }
//
//   //Reset Password
//   resetPasswordLink(String email) {
//     FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//   }
// }
