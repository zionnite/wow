import 'package:flutter/material.dart';
import 'package:wow/screen/login_screen.dart';
import 'package:wow/screen/signup_screen.dart';

import '../utils.dart';

class DeleteMyAccountScreen extends StatefulWidget {
  static const String id = 'delete_my_account_screen';
  @override
  _DeleteMyAccountScreenState createState() => _DeleteMyAccountScreenState();
}

class _DeleteMyAccountScreenState extends State<DeleteMyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: 150,
          ),
          child: Column(
            children: [
              Text(
                'Account Deleted',
                style: TextStyle(
                  fontFamily: 'NerkoOne',
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'We hate to see you Leave!\n If you change your mind about your action, please click on the Button to register again',
                  style: TextStyle(
                    fontFamily: 'Oxygen',
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, LoginScreen.id);
                  },
                  child: Container(
                    height: 50.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(25.0),
                      shadowColor: firstColor,
                      color: secondColor,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'Click Here',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Trueno',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
