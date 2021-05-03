import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/CustomShapeClipper.dart';
import 'package:wow/blocs/FollowBloc.dart';
import 'package:wow/bottom_navigation.dart';
import 'package:wow/screen/delete_my_account.dart';
import 'package:wow/screen/login_screen.dart';
import 'package:wow/screen/update_user_profile.dart';
import 'package:wow/screen/view_followers.dart';
import 'package:wow/screen/view_following.dart';
import 'package:wow/services/auth_services.dart';
import 'package:wow/utils.dart';
import 'package:wow/widget/bio_detail_widget.dart';
import '../services/ApiService.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final followBloc = FollowBloc();
  bool delete_status = false;

  var follower_counter;
  var following_counter;
  bool follow_status = true;

  String my_id,
      my_full_name,
      my_email,
      my_image,
      user_id,
      user_img,
      full_name,
      user_name,
      age;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserLogin = prefs.getBool('isUserLogin');
    var user_id1 = prefs.getString('user_id');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img1 = prefs.getString('user_img');
    var user_age = prefs.getString('age');

    setState(() {
      my_id = user_id1;
      user_name = user_id1;
      full_name = user_full_name;
      my_email = user_email;
      user_img = user_img1;
      age = user_age;
    });
  }

  @override
  void initState() {
    count_followers();
    count_following();
    _initUserDetail();
  }

  count_followers() async {
    var flo_counter = await followBloc.handleMyFollowerCounter(user_id);
    new Future.delayed(new Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          follow_status = false;
          follower_counter = flo_counter;
        });
      }
    });
  }

  count_following() async {
    var fl_counter = await followBloc.handleMyFollowingCounter(user_id);
    new Future.delayed(new Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          follow_status = false;
          following_counter = fl_counter;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        image: (user_img == null)
                            ? AssetImage('assets/images/splash.png')
                            : new NetworkImage(
                                '${user_img}',
                              ),
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
                Positioned(
                  top: 45,
                  right: 10.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, UpdateUserProfile.id);
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 40,
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
                              Navigator.pushNamed(context, ViewFollowers.id);
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Followers',
                                style: TextStyle(
                                  fontSize: 15.0,
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
                      // Expanded(
                      //   child: SizedBox(
                      //     width: 10.0,
                      //   ),
                      // ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(context, ViewFollowing.id);
                          },
                          child: Column(
                            children: [
                              Text(
                                'Following',
                                style: TextStyle(
                                  fontSize: 15.0,
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
                                          textAlign: TextAlign.center,
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
            //Padding(
            //   padding: const EdgeInsets.only(left: 15.0),
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: Text(
            //       'Your Bio',
            //       style: TextStyle(
            //         fontSize: 25,
            //         //fontWeight: FontWeight.w600,
            //         fontFamily: 'NerkoOne',
            //       ),
            //       textAlign: TextAlign.left,
            //     ),
            //   ),
            // ),
            BioDetailWidget(
              user_name: '${user_name}',
              user_full_name: '${full_name}',
              age: '${age}',
            ),

            InkWell(
              onTap: () {
                logoutUser();
              },
              child: Card(
                elevation: 4.0,
                color: Colors.red,
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
              onTap: () async {
                setState(() {
                  delete_status = true;
                });
                var result = await deleteMyAccount(my_id);
                if (result) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove("isUserLogin");

                  new Future.delayed(new Duration(seconds: 4), () {
                    setState(() {
                      delete_status = false;
                    });

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        DeleteMyAccountScreen.id,
                        (Route<dynamic> route) => false);
                  });
                } else {
                  setState(() {
                    delete_status = false;
                  });

                  final snacksBar = SnackBar(
                    content: Text(
                      'Could not perform operation, please try later!',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    //action: SnackBarAction(),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snacksBar);
                }
              },
              child: Card(
                elevation: 4.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (delete_status)
                      ? CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Colors.red,
                        )
                      : Container(
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

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isUserLogin");
    //prefs?.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
        LoginScreen.id, (Route<dynamic> route) => false);
  }
}
