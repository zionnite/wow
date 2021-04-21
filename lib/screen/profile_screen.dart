import 'package:flutter/material.dart';
import 'package:wow/CustomShapeClipper.dart';
import 'package:wow/bottom_navigation.dart';
import 'package:wow/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // var center_val = media / 50;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn(
        // scopes: <String>[
        //   'profile',
        //   'email',
        //   'https://www.googleapis.com/auth/contacts.readonly',
        // ],
        );

    Future<UserCredential> _signInWithGoogle() async {
      print('Google Clicked');
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

      print(gSA.idToken);
      print(gSA.accessToken);
      if (googleSignInAccount != null) {
        if (gSA.idToken != null) {
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: gSA.accessToken,
            idToken: gSA.idToken,
          );

          final UserCredential user =
              await _auth.signInWithCredential(credential);

          print("signed in " + user.user.displayName);
          return user;
        }
      } else {
        throw FirebaseAuthException(
            code: "ERROR_ABORTED_BY_USER", message: "SignIn Aborted by User");
      }

      // final User user = (await _auth.signInWithCredential(credential)) as User;
    }

    Future<String> refreshToken() async {
      print("Token Refresh");
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signInSilently();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      return googleSignInAuthentication.accessToken; // New refreshed token
    }

    void _googleSignOut() {
      final Future<bool> isGoogleSigIN = googleSignIn.isSignedIn();

      googleSignIn.signOut();
      print('signOut');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 20.0,
                    ),
                    height: 350.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [firstColor, secondColor],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(context, Nav.id);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 300.0,
                    ),
                    child: CircleAvatar(
                      radius: 50.0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/splash.png',
                        ),
                        radius: 45.0,
                      ),
                      backgroundColor: firstColor,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                right: 15.0,
                left: 15.0,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 25.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Username',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'zionnite',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: 12.0,
                    ),
                    child: Divider(
                      // color: Colors.grey,
                      height: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 25.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Full Name',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Nosakhare Atekha Endurance',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: 12.0,
                    ),
                    child: Divider(
                      height: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 25.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Age',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '55yrs',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: null,
                    child: Card(
                      elevation: 4.0,
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 5.0,
                          ),
                          height: 30.0,
                          width: double.infinity,
                          child: Text(
                            'Login with FaceBook!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _signInWithGoogle()
                      //     .then((UserCredential _user) => print(_user))
                      //     .catchError((onError) => print(onError));

                      _signInWithGoogle();
                    },
                    child: Card(
                      elevation: 4.0,
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 5.0,
                          ),
                          height: 30.0,
                          width: double.infinity,
                          child: Text(
                            'Login with Google!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _googleSignOut();
                    },
                    child: Card(
                      elevation: 4.0,
                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 5.0,
                          ),
                          height: 30.0,
                          width: double.infinity,
                          child: Text(
                            'SignOut Google!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: null,
                    child: Card(
                      elevation: 4.0,
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 5.0,
                          ),
                          height: 30.0,
                          width: double.infinity,
                          child: Text(
                            'Login with Apple!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: null,
                    child: Card(
                      elevation: 4.0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 5.0,
                          ),
                          height: 30.0,
                          width: double.infinity,
                          child: Text(
                            'Logout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: null,
                    child: Card(
                      elevation: 4.0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 5.0,
                          ),
                          height: 30.0,
                          width: double.infinity,
                          child: Text(
                            'Delete Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontFamily: 'Raleway',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
