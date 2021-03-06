import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/blocs/UserAuthBloc.dart';
import 'package:wow/model/Profile.dart';
import 'package:wow/model/authModel.dart';
import 'package:wow/screen/signup_screen.dart';
import 'package:wow/screen/reset_password.dart';
import 'package:wow/services/auth_services.dart';
import 'package:wow/services/login_presenter.dart';
import 'package:wow/services/ApiService.dart';

import '../bottom_navigation.dart';
import '../utils.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginPresenter {
  final userAuthBloc = UserAuthBloc();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(height: 75.0),
          Container(
              height: 350.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('Hello,',
                      style: TextStyle(
                        fontFamily: 'NerkoOne',
                        fontSize: 40.0,
                      )),
                  Positioned(
                      top: 60.0,
                      child: Text('Let\'s',
                          style: TextStyle(
                              fontFamily: 'NerkoOne', fontSize: 50.0))),
                  Positioned(
                      top: 130.0,
                      child: Text('Heal',
                          style: TextStyle(
                              fontFamily: 'NerkoOne', fontSize: 55.0))),
                  Positioned(
                      top: 200.0,
                      child: Text('Together!',
                          style: TextStyle(
                              fontFamily: 'NerkoOne', fontSize: 60.0))),
                  Positioned(
                      top: 235.0,
                      left: 175.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: firstColor)))
                ],
              )),
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
          SizedBox(height: 10.0),
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
              userAuthBloc.eamilAuthSink.add(value);
            },
            validator: (value) =>
                value.isEmpty ? 'Email is required' : validateEmail(value),
          ),
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
              userAuthBloc.passwordAuthSink.add(value);
            },
            validator: (value) => value.isEmpty ? 'Password is required' : null,
          ),
          SizedBox(height: 5.0),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ResetPassword()));
            },
            child: Container(
              alignment: Alignment(1.0, 0.0),
              padding: EdgeInsets.only(top: 15.0, left: 20.0),
              child: InkWell(
                child: Text(
                  'Forgot Password',
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
              if (checkFields() && !isLoading) {
                setState(() {
                  isLoading = true;
                });
                //var result = await userAuthBloc.handleUserAuthenticationLogin();

                var result = await userAuthLogin(this.email, this.password);
                if (result == 'success') {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('isUserLogin', true);

                  setState(() {
                    isLoading = false;
                  });
                  Navigator.pushReplacementNamed(context, Nav.id);
                } else if (result == 'fail_01') {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg = 'User not found or Password is incorrect!';
                  });
                } else if (result == 'fail_2') {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg = 'Email Or Password can not be empty';
                  });
                } else if (result == 'fail_03') {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg = '';
                  });
                } else if (result == 'fail_04') {
                  setState(() {
                    isLoading = false;
                    status = true;
                    status_msg = '';
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
                          'LOGIN',
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
          Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not Register yet?'),
                SizedBox(width: 5.0),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()),
                    );
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: greenColor,
                      fontFamily: 'Trueno',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }

  // @override
  // void onSuccess(AuthModel authModel) async {
  //   print(await authModel.toJson());
  // }

  @override
  void onError(String error) {
    print('My Error ${error}');
    // TODO: implement onError
  }

  // @override
  // void onSuccess(AuthModel authModel) {
  //   // TODO: implement onSuccess
  //   print(authModel.fullName);
  // }

  @override
  void onSuccess(
      {String systemId,
      String userId,
      String fullName,
      String age,
      String sex,
      String email,
      String phoneNo,
      String userImg,
      String status,
      String status_msg}) {
    print(fullName);
    // TODO: implement onSuccess
  }

  @override
  void displayMessage(String status, String message) {
    print(status);
    print(message);
    // TODO: implement displayMessage
  }
}
