import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wow/blocs/UserBloc.dart';
import 'package:wow/screen/profile_screen.dart';
import 'package:wow/screen/reset_password.dart';
import 'package:wow/screen/signup_screen.dart';
import 'package:wow/services/ApiService.dart';

import '../bottom_navigation.dart';
import '../utils.dart';

class UpdateUserProfile extends StatefulWidget {
  static const String id = 'update_user_profile';
  @override
  _UpdateUserProfileState createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  final userBloc = UserBloc();
  final formKey = new GlobalKey<FormState>();

  String email, password;
  String status_msg = '';
  bool status = false;
  bool isLoading = false;

  Color greenColor = Color(0xFF00AF19);

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  File profileImg;
  final profilePiker = ImagePicker();

  Future choiceProfileImg() async {
    var pickedProfileImg =
        await profilePiker.getImage(source: ImageSource.gallery);
    setState(() {
      profileImg = File(pickedProfileImg.path);
    });
    //foumBloc.mkpPostImage.sink.add(profileImg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.popAndPushNamed(context, ProfileScreen.id);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Update Your Detail',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: _buildLoginForm(),
          ),
        ),
      ),
    );
  }

  _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView(
        children: [
          (status)
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.warning_rounded,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Attention!',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                status_msg,
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            status = false;
                            status_msg = '';
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
          SizedBox(height: 50.0),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
            obscureText: false,
            onChanged: (value) {
              //this.password = value;
              userBloc.uFullnameSink.add(value);
            },
            validator: (value) =>
                value.isEmpty ? 'Full Name is required' : null,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Age',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
            obscureText: false,
            onChanged: (value) {
              //this.password = value;
              userBloc.uAgeSink.add(value);
            },
            validator: (value) => value.isEmpty ? 'Age is required' : null,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(
                    fontFamily: 'Trueno',
                    fontSize: 12.0,
                    color: Colors.grey.withOpacity(0.5)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greenColor),
                )),
            obscureText: false,
            onChanged: (value) {
              //this.password = value;
              userBloc.uPhoneSink.add(value);
            },
            validator: (value) =>
                value.isEmpty ? 'Phone Number is required' : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
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
                        'Select Profile Image',
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
                ? Text(
                    'No Image Selected',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    child: Image.file(profileImg),
                  ),
          ),
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: () {
              //TODO: //TERMS and CONDITION
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ResetPassword()));
            },
            child: Container(
              alignment: Alignment(1.0, 0.0),
              padding: EdgeInsets.only(top: 15.0, left: 20.0),
              child: InkWell(
                child: Text(
                  'View Term & Condition',
                  style: TextStyle(
                      color: greenColor,
                      fontFamily: 'Trueno',
                      fontSize: 11.0,
                      decoration: TextDecoration.underline),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () async {
              //AuthService().signOut();
              if (checkFields() && !isLoading && profileImg != null) {
                setState(() {
                  isLoading = true;
                });
                // var result = await userAuthLogin(this.email, this.password);
                var result = await userBloc.handleProfileUpdate(profileImg);

                if (result) {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg =
                        'Your Profile details has been updated successfully';
                  });
                } else {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg =
                        'Something happen, could not update your profile, please try later!';
                  });
                }
              }
            },
            child: Container(
              height: 50.0,
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                shadowColor: firstColor,
                color: secondColor,
                elevation: 7.0,
                child: Center(
                  child: (isLoading)
                      ? CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 3,
                        )
                      : Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Trueno',
                          ),
                        ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
