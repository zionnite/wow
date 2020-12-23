import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
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

  @override
  void initState() {}

  @override
  void dispose() {
    foumBloc.dispose();
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
    request.fields['name'] = fullNameController.text;
    request.fields['email'] = emailAddressController.text;
    request.fields['comment'] = commentController.text;
    request.fields['forum_id'] = widget.pick_id;

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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: TextField(
                      controller: fullNameController,
                      onChanged: foumBloc.mkcNameSink,
                      style: dropDownMenuItemStyle,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        border: InputBorder.none,
                        hintText: 'Your Name',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: TextField(
                      controller: emailAddressController,
                      onChanged: foumBloc.mkcEmailSink,
                      style: dropDownMenuItemStyle,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        border: InputBorder.none,
                        hintText: 'Your Email',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
                  child: Container(
                    height: 500,
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: TextField(
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
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      //submitComment();

                      setState(() {
                        _isLoading = true;
                      });

                      _showCommentStatus =
                          await foumBloc.postToComment(widget.pick_id);
                      if (_showCommentStatus) {
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
