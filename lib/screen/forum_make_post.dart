import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:wow/blocs/forum_bloc.dart';

import '../utils.dart';

class ForumMakePost extends StatefulWidget {
  @override
  _ForumMakePostState createState() => _ForumMakePostState();
}

class _ForumMakePostState extends State<ForumMakePost> {
  final foumBloc = ForumBloc();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  bool _isLoading = false;
  bool _showStatus = false;
  bool _showCommentStatus;
  String _statusMsg;

  File postImage, profileImg;
  final postPiker = ImagePicker();
  final profilePiker = ImagePicker();

  Future choicePostImg() async {
    var pickedPostImg = await postPiker.getImage(source: ImageSource.gallery);
    setState(() {
      postImage = File(pickedPostImg.path);
    });
    foumBloc.mkpPostImage.sink.add(postImage);
  }

  Future choiceProfileImg() async {
    var pickedProfileImg =
        await profilePiker.getImage(source: ImageSource.gallery);
    setState(() {
      profileImg = File(pickedProfileImg.path);
    });
    foumBloc.mkpPostImage.sink.add(profileImg);
  }

  @override
  void initState() {}

  @override
  void dispose() {
    foumBloc.dispose();
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    titleController.dispose();
    contentController.dispose();
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
      backgroundColor: Colors.white,
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
                    'Make Post',
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
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: StreamBuilder<String>(
                      stream: foumBloc.mkpNameSinkVal,
                      builder: (context, snapshot) => TextField(
                        controller: fullNameController,
                        maxLines: 1,
                        onChanged: foumBloc.mkpNameSink,
                        style: dropDownMenuItemStyle,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 14.0),
                          border: InputBorder.none,
                          hintText: 'Your Name',
                          errorText: snapshot.error,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: StreamBuilder<String>(
                      stream: foumBloc.mkpEmailSinkVal,
                      builder: (context, snapshot) => TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        maxLines: 1,
                        onChanged: foumBloc.mkpEmailSink,
                        style: dropDownMenuItemStyle,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 14.0),
                          border: InputBorder.none,
                          hintText: 'Your Email',
                          errorText: snapshot.error,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: StreamBuilder<String>(
                      stream: foumBloc.mkpTitleSinkVal,
                      builder: (context, snapshot) => TextField(
                        controller: titleController,
                        maxLines: null,
                        onChanged: foumBloc.mkpTitleSink,
                        style: dropDownMenuItemStyle,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 14.0),
                          border: InputBorder.none,
                          hintText: 'Post Title',
                          errorText: snapshot.error,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.0),
                  child: Card(
                    elevation: 4.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            choicePostImg();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                              bottom: 18.0,
                            ),
                            child: Text(
                              'Upload Post Image',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: (postImage == null)
                      ? Text('No Image Selected')
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3.0),
                          child: Image.file(postImage),
                        ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 400.0,
                    ),
                    height: 400,
                    child: Material(
                      elevation: 5.0,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: StreamBuilder<String>(
                        stream: foumBloc.mkpContentSinkVal,
                        builder: (context, snapshot) => TextField(
                          controller: contentController,
                          maxLines: null,
                          onChanged: foumBloc.mkpContentSink,
                          style: dropDownMenuItemStyle,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 14.0),
                            border: InputBorder.none,
                            hintText: 'Write Detail of Post Content',
                            errorText: snapshot.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.0),
                  child: Card(
                    elevation: 4.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            choiceProfileImg();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                              bottom: 18.0,
                            ),
                            child: Text(
                              'Upload Profile Image',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: (profileImg == null)
                      ? Text('No Image Selected')
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 3.0),
                          child: Image.file(profileImg),
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
                Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 80.0),
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        _isLoading = true;
                      });

                      if (postImage != null &&
                          profileImg != null &&
                          fullNameController.text.length > 5 &&
                          emailController.text.contains("@") &&
                          titleController.text.length > 10 &&
                          contentController.text.length > 50) {
                        _showCommentStatus =
                            await foumBloc.postToPost(postImage, profileImg);

                        if (_showCommentStatus) {
                          setState(() {
                            new Future.delayed(new Duration(seconds: 4), () {
                              _showStatus = true;
                              _statusMsg = 'Post has been Added successfully!';
                            });
                          });
                        } else {
                          setState(() {
                            new Future.delayed(new Duration(seconds: 4), () {
                              _showStatus = true;
                              _statusMsg =
                                  'Could not add Post, please try again later or contact admin if issue persist!';
                            });
                          });
                        }

                        new Future.delayed(new Duration(seconds: 4), () {
                          setState(() {
                            _isLoading = false;
                            fullNameController.text = '';
                            emailController.text = '';
                            titleController.text = '';
                            contentController.text = '';
                            profileImg = null;
                            postImage = null;
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
