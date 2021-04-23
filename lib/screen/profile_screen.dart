import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wow/CustomShapeClipper.dart';
import 'package:wow/bottom_navigation.dart';
import 'package:wow/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wow/widget/bio_detail_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // var center_val = media / 50;
  final String user_id = '1';

  final String user_name = 'zionnite';
  final String full_name = 'Nosakhare Atekha Endurance';
  final String age = '50';
  final String user_img =
      'https://static0.srcdn.com/wordpress/wp-content/uploads/2016/11/Hercules-Dwayne-Johnson.jpg';
  String follower_counter;
  String following_counter;
  bool follow_status = true;

  @override
  void initState() {
    count_followers(user_id);
    count_following(user_id);
  }

  count_followers(String user_id) async {
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        follow_status = false;
        follower_counter = '200';
      });
    });
  }

  count_following(String user_id) async {
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        follow_status = false;
        following_counter = '12';
      });
    });
  }

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
                    height: 350.0,
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: [firstColor, secondColor],
                      // ),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken),
                        image: new NetworkImage(
                          user_img,
                        ),
                      ),
                    ),
                    // child: CachedNetworkImage(
                    //   imageUrl:
                    //       'https://static0.srcdn.com/wordpress/wp-content/uploads/2016/11/Hercules-Dwayne-Johnson.jpg',
                    //   fit: BoxFit.cover,
                    //   height: 200,
                    //   fadeInDuration: Duration(milliseconds: 500),
                    //   fadeInCurve: Curves.easeIn,
                    //   placeholder: (context, progressText) => Center(
                    //     child: CircularProgressIndicator(),
                    //   ),
                    // ),
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
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Container(
                //     margin: EdgeInsets.only(
                //       top: 300.0,
                //     ),
                //     child: CircleAvatar(
                //       radius: 50.0,
                //       child: CircleAvatar(
                //         backgroundImage: AssetImage(
                //           'assets/images/splash.png',
                //         ),
                //         radius: 45.0,
                //       ),
                //       backgroundColor: firstColor,
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(
                    top: 350.0,
                  ),
                  padding: EdgeInsets.all(
                    20.0,
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              var i = '2';
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Followers',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: (follow_status)
                                      ? Text('Loading...')
                                      : Text(
                                          '${follower_counter}',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 10.0,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            setState(() {
                              var i = '2';
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Following',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 28.0),
                                  child: (follow_status)
                                      ? Text('Loading...')
                                      : Text(
                                          '${following_counter}',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Your Bio',
                  style: TextStyle(
                    fontSize: 25,
                    //fontWeight: FontWeight.w600,
                    fontFamily: 'NerkoOne',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            BioDetailWidget(
                user_name: user_name, user_full_name: full_name, age: age),
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
              onTap: () {},
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
              onTap: () {},
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
    );
  }
}
