import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/utils.dart';
import 'package:http/http.dart' as http;

class ForumMakeComment extends StatefulWidget {
  final String pick_id;
  ForumMakeComment({this.pick_id});

  @override
  _ForumMakeCommentState createState() => _ForumMakeCommentState();
}

class _ForumMakeCommentState extends State<ForumMakeComment> {
  final foumBloc = ForumBloc();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  bool _isLoading = false;
  bool _showStatus = false;
  bool _showCommentStatus;
  String _statusMsg;

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
    var user_id = prefs.getString('user_id');
    var user_full_name = prefs.getString('full_name');
    var user_email = prefs.getString('email');
    var user_img1 = prefs.getString('user_img');
    var user_age = prefs.getString('age');

    setState(() {
      my_id = user_id;
      my_full_name = user_full_name;
      my_email = user_email;
      my_image = user_img1;
      age = user_age;
    });
  }

  @override
  void initState() {
    super.initState();
    _initUserDetail();
  }

  @override
  void dispose() {
    //foumBloc.dispose();
    super.dispose();
    fullNameController.dispose();
    emailAddressController.dispose();
    commentController.dispose();
  }

  Future submitComment() async {
    setState(() {
      _isLoading = true;
    });
    final uri = Uri.parse('http://wow.joons-me.com/Api/make_comment');
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = my_full_name;
    request.fields['email'] = my_email;
    request.fields['comment'] = commentController.text;
    request.fields['forum_id'] = widget.pick_id;
    request.fields['user_id'] = my_id;

    var respond = await request.send();
    if (respond.statusCode == 200) {
      setState(() {
        new Future.delayed(new Duration(seconds: 4), () {
          _showStatus = true;
          _statusMsg = 'Comment has been Added successfully!';
        });
      });
    } else {
      setState(() {
        new Future.delayed(new Duration(seconds: 4), () {
          _showStatus = true;
          _statusMsg =
              'Could not add Comment, please try again later or contact admin if issue persist!';
        });
      });
    }
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        _isLoading = false;
        fullNameController.text = '';
        emailAddressController.text = '';
        commentController.text = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        leading: InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.popAndPushNamed(context, null);
            }
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        progressIndicator: CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Make Comment',
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
                (my_full_name?.isEmpty ?? true)
                    ? Text(
                        'You need to update your Information before you can make Comment!',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Container(),
                (_showStatus == true)
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        child: Text(
                          _statusMsg,
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : Container(),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                //   child: Material(
                //     elevation: 5.0,
                //     color: Colors.white,
                //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     child: StreamBuilder<String>(
                //       stream: foumBloc.mkcNameSinkVal,
                //       builder: (context, snapshot) => TextField(
                //         controller: fullNameController,
                //         onChanged: foumBloc.mkcNameSink,
                //         style: dropDownMenuItemStyle,
                //         cursorColor: Colors.black,
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.symmetric(
                //               horizontal: 32.0, vertical: 14.0),
                //           border: InputBorder.none,
                //           hintText: 'Your Name',
                //           errorText: snapshot.error,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                //   child: Material(
                //     elevation: 5.0,
                //     color: Colors.white,
                //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     child: StreamBuilder<String>(
                //       stream: foumBloc.mkcEmailSinkVal,
                //       builder: (context, snapshot) => TextField(
                //         keyboardType: TextInputType.emailAddress,
                //         controller: emailAddressController,
                //         onChanged: foumBloc.mkcEmailSink,
                //         style: dropDownMenuItemStyle,
                //         cursorColor: Colors.black,
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.symmetric(
                //               horizontal: 32.0, vertical: 14.0),
                //           border: InputBorder.none,
                //           hintText: 'Your Email',
                //           errorText: snapshot.error,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Container(
                    height: 500,
                    child: Material(
                      elevation: 5.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: StreamBuilder<String>(
                        stream: foumBloc.mkcCommentStinkVal,
                        builder: (context, snapshot) => TextField(
                          controller: commentController,
                          maxLines: null,
                          onChanged: foumBloc.mkcCommentSink,
                          style: dropDownMenuItemStyle,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 14.0),
                            border: InputBorder.none,
                            hintText: 'Enter Comment Details',
                            errorText: snapshot.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: InkWell(
                    onTap: () async {
                      if (!my_full_name?.isEmpty ?? true) {
                        //submitComment();

                        setState(() {
                          _isLoading = true;
                        });

                        if (commentController.text.length > 10) {
                          _showCommentStatus = await foumBloc.postToComment(
                            id: widget.pick_id,
                            my_id: my_id,
                            name: my_full_name,
                            email: my_email,
                          );
                          if (_showCommentStatus) {
                            setState(() {
                              new Future.delayed(new Duration(seconds: 4), () {
                                _showStatus = true;
                                _statusMsg =
                                    'Comment has been Added successfully!';
                              });
                            });
                          } else {
                            setState(() {
                              new Future.delayed(new Duration(seconds: 4), () {
                                _showStatus = true;
                                _statusMsg =
                                    'Could not add Comment, please try again later or contact admin if issue persist!';
                              });
                            });
                          }

                          new Future.delayed(new Duration(seconds: 4), () {
                            setState(() {
                              _isLoading = false;
                              fullNameController.text = '';
                              emailAddressController.text = '';
                              commentController.text = '';
                            });
                          });
                        } else {
                          setState(() {
                            _isLoading = false;
                            _showStatus = true;
                            _statusMsg =
                                'All Information is needed, Please fill the form';
                          });
                        }
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(250),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18.0, horizontal: 50),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      elevation: 5.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
