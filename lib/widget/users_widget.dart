import 'package:flutter/material.dart';
import 'package:wow/blocs/FollowBloc.dart';
import 'package:wow/screen/view_user_profile_screen.dart';

import '../utils.dart';

class UsersWidget extends StatefulWidget {
  String dis_system_id,
      dis_user_name,
      dis_user_id,
      dis_user_img,
      dis_user_full_name,
      dis_user_age,
      dis_user_sex,
      dis_user_email,
      dis_phone_no,
      my_id;

  int dis_user_following, dis_user_follower;
  bool iFollow;

  UsersWidget({
    this.dis_system_id,
    this.dis_user_name,
    this.dis_user_id,
    this.dis_user_img,
    this.dis_user_full_name,
    this.dis_user_age,
    this.dis_user_sex,
    this.dis_user_email,
    this.dis_phone_no,
    this.dis_user_following,
    this.dis_user_follower,
    this.iFollow,
    this.my_id,
  });

  @override
  _UsersWidgetState createState() => _UsersWidgetState();
}

class _UsersWidgetState extends State<UsersWidget> {
  final followBloc = FollowBloc();

  String result;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        //TODO:// COME HERE, FIX IT
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ViewUserProfileScreen(
                                my_id: widget.my_id,
                                user_id: widget.dis_user_id,
                                user_name: widget.dis_user_name,
                                full_name: widget.dis_user_full_name,
                                sex: widget.dis_user_sex,
                                age: widget.dis_user_age,
                                follower_count: widget.dis_user_follower,
                                following_count: widget.dis_user_following,
                                iFollow: widget.iFollow,
                                email: widget.dis_user_email,
                                phone_no: widget.dis_phone_no,
                                user_img: widget.dis_user_img,
                              );
                            },
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: secondColor,
                        child: CircleAvatar(
                          radius: 49,
                          backgroundImage:
                              NetworkImage('${widget.dis_user_img}'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    (widget.dis_user_full_name?.isEmpty ?? true)
                        ? Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'New User',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                  Text(
                                    'new user',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.dis_user_full_name}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                  Text(
                                    '${widget.dis_user_age}yrs',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              (widget.my_id != widget.dis_user_id)
                  ? (widget.iFollow == false)
                      ? InkWell(
                          onTap: () async {
                            // print('my id ${widget.my_id}');
                            result = await followBloc.handleFollowUser(
                              my_id: widget.my_id,
                              user_id: widget.dis_user_id,
                              context: context,
                            );
                            //print(result);
                            if (result == 'following_true') {
                              //print(result);
                              setState(() {
                                widget.iFollow = true;
                                widget.dis_user_follower++;
                                //print(_iFollow);
                              });
                            }

                            if (result == 'unfollowing_true') {
                              setState(() {
                                widget.iFollow = false;
                                widget.dis_user_follower--;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            result = await followBloc.handleFollowUser(
                                my_id: widget.my_id,
                                user_id: widget.dis_user_id,
                                context: context);

                            //print(result);
                            if (result == 'following_true') {
                              setState(() {
                                widget.iFollow = true;
                                widget.dis_user_follower++;
                              });
                            }

                            if (result == 'unfollowing_true') {
                              setState(() {
                                widget.iFollow = false;
                                widget.dis_user_follower--;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Un Follow',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
