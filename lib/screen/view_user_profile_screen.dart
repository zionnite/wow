import 'package:flutter/material.dart';
import 'package:wow/blocs/FollowBloc.dart';
import 'package:wow/screen/view_dis_user_follower.dart';
import 'package:wow/screen/view_dis_user_following.dart';
import 'package:wow/widget/bio_detail_widget.dart';

class ViewUserProfileScreen extends StatefulWidget {
  static const String id = 'view_user_profile_screen';
  String user_id;
  String user_name;
  String my_id;
  String full_name;
  String age;
  String sex;
  String phone_no;
  String email;
  int follower_count;
  int following_count;
  bool iFollow;
  String user_img;

  ViewUserProfileScreen({
    this.user_id,
    this.user_name,
    this.my_id,
    this.full_name,
    this.age,
    this.sex,
    this.phone_no,
    this.email,
    this.follower_count,
    this.following_count,
    this.iFollow,
    this.user_img,
  });

  // ViewUserProfileScreen({
  //   this.user_id,
  //   this.user_name,
  // });

  @override
  _ViewUserProfileScreenState createState() => _ViewUserProfileScreenState();
}

class _ViewUserProfileScreenState extends State<ViewUserProfileScreen> {
  final followBloc = FollowBloc();

  int follower_counter;
  int following_counter;
  //TODO: //check for status
  bool follow_status = true;

  countUserFollower(String user_id) async {
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        follower_counter = widget.follower_count;
        follow_status = false;
      });
    });
  }

  countUserFollowing(String user_id) async {
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        following_counter = widget.following_count;
        follow_status = false;
      });
    });

    //print('Following ${follow_status}');
  }

  @override
  void initState() {
    super.initState();
    countUserFollower(widget.user_id);
    countUserFollowing(widget.user_id);
  }

  @override
  Widget build(BuildContext context) {
    String result;
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
                        image: new NetworkImage('${widget.user_img}'),
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
                          Navigator.pop(context);
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ViewDisUserFollowers(
                                    dis_full_name: widget.full_name,
                                    dis_user_id: widget.user_id,
                                  );
                                },
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                'Followers',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 25.0),
                                  child: (follow_status)
                                      ? Text(
                                          'Loading...',
                                          style: TextStyle(fontSize: 10),
                                        )
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ViewDisUserFollowing(
                                    dis_full_name: widget.full_name,
                                    dis_user_id: widget.user_id,
                                  );
                                },
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                'Following',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 28.0),
                                  child: (follow_status)
                                      ? Text(
                                          'Loading...',
                                          style: TextStyle(fontSize: 10),
                                        )
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
            (widget.iFollow == false)
                ? InkWell(
                    onTap: () async {
                      result = await followBloc.handleFollowUser(
                          my_id: widget.my_id,
                          user_id: widget.user_id,
                          context: context);
                      //print(result);
                      if (result == 'following_true') {
                        //print(result);
                        setState(() {
                          widget.iFollow = true;
                          follower_counter++;
                          //print(_iFollow);
                        });
                      }

                      if (result == 'unfollowing_true') {
                        setState(() {
                          widget.iFollow = false;
                          follower_counter--;
                        });
                      }
                    },
                    child: (follow_status)
                        ? Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 15.0,
                            ),
                            padding: EdgeInsets.all(
                              15.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 5.5), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Loading...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'NerkoOne',
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 15.0,
                            ),
                            padding: EdgeInsets.all(
                              15.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 5.5), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'Follow User',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  )
                : InkWell(
                    onTap: () async {
                      result = await followBloc.handleFollowUser(
                          my_id: widget.my_id,
                          user_id: widget.user_id,
                          context: context);

                      //print(result);
                      if (result == 'following_true') {
                        setState(() {
                          widget.iFollow = true;
                          follower_counter++;
                        });
                      }

                      if (result == 'unfollowing_true') {
                        setState(() {
                          widget.iFollow = false;
                          follower_counter--;
                        });
                      }
                    },
                    child: (follow_status)
                        ? Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 15.0,
                            ),
                            padding: EdgeInsets.all(
                              15.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 5.5), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Loading...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'NerkoOne',
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 15.0,
                            ),
                            padding: EdgeInsets.all(
                              15.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 5.5), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.thumb_down,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    'UnFollow User',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'User Bio',
                  style: TextStyle(
                    fontSize: 25,
                    //fontWeight: FontWeight.w600,
                    fontFamily: 'NerkoOne',
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            //TODO: // CHANGE USER NAME
            BioDetailWidget(
              user_name: 'wowApp${widget.user_id}',
              user_full_name: '${widget.full_name}',
              age: '${widget.age}',
            ),
          ],
        ),
      ),
    );
  }
}
