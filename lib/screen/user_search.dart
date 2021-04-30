import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/blocs/UserBloc.dart';
import 'package:wow/model/UserProfile.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/widget/users_widget.dart';

import '../bottom_navigation.dart';
import '../utils.dart';

class SearchUsers extends StatefulWidget {
  String searchTerm;

  SearchUsers({
    this.searchTerm,
  });

  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
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

    userBloc.searchUsers(widget.searchTerm, current_page, my_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void initState() {
    _initUserDetail();
  }

  void searchUsers() {
    userBloc.searchUsers(searchTerm, 1, my_id);
    _controller = ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
        current_page++;
      });

      // Future.delayed(new Duration(seconds: 4), () {
      searchUsersByPage(widget.searchTerm, current_page, my_id)
          .then((value) => {
                userBloc.handleSearchListenPerPage(value),
              });

      //});
    }
  }

  Future<void> handleRefresh() async {
    setState(() {
      current_page = 1;
    });
    await searchUsersByPage(widget.searchTerm, current_page, my_id)
        .then((value) => {
              userBloc.handleSearchListenRefresh(value),
            });
  }

  @override
  void dispose() {
    //userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'Searching User',
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
                      onPressed: () => Navigator.pop(context),
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
                                searchUsers();
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
                  stream: userBloc.searchStream,
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
        Text("Error occured: $error"),
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
