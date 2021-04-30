import 'package:flutter/material.dart';
import 'package:wow/blocs/UserAuthBloc.dart';
import 'package:wow/services/auth_services.dart';

class ResetPassword extends StatefulWidget {
  static const String id = 'reset_screen';
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final userAuthBloc = UserAuthBloc();
  final formKey = new GlobalKey<FormState>();

  String email;
  Color greenColor = Color(0xFF00AF19);

  String status_msg = '';
  bool status = true;
  bool isLoading = false;
  String result;

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
            child: Form(key: formKey, child: _buildResetForm())));
  }

  _buildResetForm() {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          SizedBox(height: 75.0),
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                  Text('reset',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
                  //Dot placement
                  Positioned(
                      top: 47.0,
                      left: 160.0,
                      child: Container(
                          height: 10.0,
                          width: 10.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: greenColor)))
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
                userAuthBloc.restAuthSink.add(value);
              },
              validator: (value) =>
                  value.isEmpty ? 'Email is required' : validateEmail(value)),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () async {
              if (checkFields()) {
                setState(() {
                  isLoading = true;
                });
                result = await userAuthBloc.handleUserAuthenticationReset();
                if (result == 'success') {
                  setState(() {
                    isLoading = false;
                  });
                } else if (result == 'fail') {
                  setState(() {
                    isLoading = false;
                    status_msg = result;
                  });
                }
                var b = userAuthBloc.restResultController.value;
                print(b);
                //AuthService().resetPasswordLink(email);
              }
            },
            child: Container(
                height: 50.0,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: greenColor,
                    elevation: 7.0,
                    child: Center(
                        child: (isLoading)
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                strokeWidth: 3,
                              )
                            : Text('RESET',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Trueno'))))),
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
