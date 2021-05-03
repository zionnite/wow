import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/blocs/UserBloc.dart';
import 'package:wow/model/UserProfile.dart';
import 'package:wow/screen/user_search.dart';
import 'package:wow/screen/view_user_profile_screen.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/utils.dart';
import 'package:wow/widget/users_widget.dart';

import '../bottom_navigation.dart';

class UsersScreen extends StatefulWidget {
  static const String id = 'user_screen';
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  TextEditingController searchTermController = TextEditingController();
  String searchTerm;
  bool _showStatus = false;
  String _statusMsg;

  final userBloc = UserBloc();
  ScrollController _controller;
  int current_page = 1;
  bool isLoading = false;

  String my_id, my_full_name, my_email, my_image, user;

  _initUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserLogin = prefs.getBool('isUserLogin');
    var user_id = prefs.getString('user_id');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img = prefs.getString('user_img');

    setState(() {
      my_id = user_id;
      my_full_name = user_full_name;
      my_email = user_email;
      my_image = user_img;
    });

    userBloc.userPerPage(current_page, my_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void initState() {
    _initUserDetail();
    super.initState();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      //quoteBloc.quotePerPage(1);
      setState(() {
        isLoading = true;
        current_page++;
      });

      // Future.delayed(new Duration(seconds: 4), () {
      getAllUsersByPage(current_page, my_id).then((value) => {
            userBloc.handleListenPerPage(value),
          });

      //});
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      current_page = 1;
    });
    await getAllUsersByPage(1, my_id).then((value) => {
          userBloc.handleListenRefresh(value),
        });
  }

  @override
  void dispose() {
    super.dispose();
    //quoteBloc.dispose();
    //quoteBloc.quoteCatController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 70.0),
                      child: Text(
                        'Users',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          Navigator.popAndPushNamed(context, Nav.id),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    margin: EdgeInsets.only(top: 180.0),
                    child: Material(
                      elevation: 5.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: TextField(
                        controller: searchTermController,
                        onChanged: (text) {
                          setState(() {
                            searchTerm = text;
                            //forumBloc.searchSink.add(searchTerm);
                          });
                        },
                        style: dropDownMenuItemStyle,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 14.0,
                          ),
                          border: InputBorder.none,
                          hintText: 'Search for user',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              if (!searchTermController.text.isEmpty) {
                                setState(() {
                                  searchTermController.text = '';
                                  _showStatus = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SearchUsers(
                                        searchTerm: searchTerm,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                setState(() {
                                  setState(() {
                                    _showStatus = true;
                                    _statusMsg =
                                        'Search Term Field can\'t be empty!';
                                  });
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              (_showStatus == true)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        _statusMsg,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(),
              StreamBuilder<List<UserProfile>>(
                  stream: userBloc.perPageStream,
                  builder:
                      (context, AsyncSnapshot<List<UserProfile>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.error != null && snapshot.data.length > 0) {
                        return _buildErrorWidget(snapshot.error);
                      }
                      return ListView.builder(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data[index].systemId == null ||
                              snapshot.data[index].systemId == '') {
                            //isLoading = false;
                            return Container();
                          }
                          return UsersWidget(
                            dis_system_id: snapshot.data[index].systemId,
                            dis_user_img: snapshot.data[index].userImg,
                            dis_user_full_name: snapshot.data[index].fullName,
                            dis_user_age: snapshot.data[index].age,
                            dis_user_sex: snapshot.data[index].sex,
                            dis_user_email: snapshot.data[index].email,
                            dis_phone_no: snapshot.data[index].phoneNo,
                            dis_user_follower: snapshot.data[index].followers,
                            dis_user_following: snapshot.data[index].following,
                            iFollow: snapshot.data[index].iFollow,
                            dis_user_id: snapshot.data[index].userId,
                            my_id: my_id,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return _buildErrorWidget(snapshot.error);
                    } else {
                      return _buildLoadingWidget();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occurred: $error"),
      ],
    ));
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
