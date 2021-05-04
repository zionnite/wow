import 'package:flutter/material.dart';
import 'package:wow/blocs/UserAuthBloc.dart';
import 'package:wow/screen/reset_password.dart';
import 'package:wow/screen/terms_n_condition.dart';
import 'package:wow/services/ApiService.dart';
import 'package:wow/services/auth_services.dart';
import 'package:wow/services/error_handler.dart';
import 'package:wow/utils.dart';

import '../bottom_navigation.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'signup_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final userAuthBloc = UserAuthBloc();
  final formKey = new GlobalKey<FormState>();

  String email, password;

  Color greenColor = Color(0xFF00AF19);
  String status_msg = '';
  bool status = false;
  bool isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: formKey,
          child: _buildSignupForm(),
        ),
      ),
    );
  }

  _buildSignupForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('Signup',
                      style: TextStyle(fontFamily: 'NerkoOne', fontSize: 60.0)),
                  //Dot placement
                  Positioned(
                      top: 52.0,
                      left: 150.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: firstColor)))
                ],
              )),
          (status)
              ? Container(
                  margin: EdgeInsets.only(top: 20),
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
          SizedBox(height: 25.0),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'EMAIL',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              onChanged: (value) {
                this.email = value;
                userAuthBloc.emailAuthSignupSink.add(value);
              },
              validator: (value) =>
                  value.isEmpty ? 'Email is required' : validateEmail(value)),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: TextStyle(
                      fontFamily: 'Trueno',
                      fontSize: 12.0,
                      color: Colors.grey.withOpacity(0.5)),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greenColor),
                  )),
              obscureText: true,
              onChanged: (value) {
                this.password = value;
                userAuthBloc.passwordAuthSignupSink.add(value);
              },
              validator: (value) =>
                  value.isEmpty ? 'Password is required' : null),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () async {
              if (checkFields() && !isLoading) {
                setState(() {
                  isLoading = true;
                });
                //userAuthBloc.handleUserAuthenticationSignUp();
                var result = await userAuthSignup(this.email, this.password);
                if (result == 'success') {
                  setState(() {
                    isLoading = false;
                  });

                  //Navigator.pushReplacementNamed(context, Nav.id);

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Nav.id, (Route<dynamic> route) => false);
                } else if (result == 'fail_01') {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg =
                        'Registration successful, but could not automatic redirect to the Home, Please click the GO Back but to Login into App';
                  });
                } else if (result == 'fail_2') {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg =
                        'Registration not successful, please try after some time';
                  });
                } else if (result == 'fail_03') {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg = 'Email or Password can not be empty';
                  });
                } else if (result == 'fail_04') {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg =
                        'Someone with this email address already exist on our platform';
                  });
                }
              }
            },
            child: Column(
              children: [
                SizedBox(height: 5.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Terms_N_Conditions()));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 23.0),
                    alignment: Alignment(1.0, 0.0),
                    padding: EdgeInsets.only(top: 15.0, left: 50.0),
                    child: InkWell(
                      child: Text(
                        'By clicking on the SignUp Button you agree to our Term & Condition',
                        style: TextStyle(
                            color: greenColor,
                            fontFamily: 'Trueno',
                            fontSize: 11.0,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Container(
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
                              'SIGN UP',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Trueno',
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go back',
                    style: TextStyle(
                        color: greenColor,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])
        ]));
  }
}
