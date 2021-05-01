import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/model/Profile.dart';
import 'package:wow/model/authModel.dart';
import 'package:wow/services/ApiService.dart';

class UserAuthBloc implements BlocBase {
  final emailAuthController = BehaviorSubject<String>();
  StreamSink<String> get eamilAuthSink => emailAuthController.sink;
  Stream<String> get emailAuthStream => emailAuthController.stream;

  final passwordAuthController = BehaviorSubject<String>();
  StreamSink<String> get passwordAuthSink => passwordAuthController.sink;
  Stream<String> get passwordAuthStream => passwordAuthController.stream;

  final emailAuthSignupController = BehaviorSubject<String>();
  StreamSink<String> get emailAuthSignupSink => emailAuthSignupController.sink;
  Stream<String> get emailAuthSignupStream => emailAuthSignupController.stream;

  final passwordAuthSignupController = BehaviorSubject<String>();
  StreamSink<String> get passwordAuthSignupSink =>
      passwordAuthSignupController.sink;
  Stream<String> get passwordAuthSignupStream =>
      passwordAuthSignupController.stream;

  final restAuthController = BehaviorSubject<String>();
  StreamSink<String> get restAuthSink => restAuthController.sink;
  Stream<String> get restAuthStream => restAuthController.stream;

  final restResultController = BehaviorSubject<String>();
  StreamSink<String> get restResultSink => restResultController.sink;
  Stream<String> get restResultStream => restResultController.stream;

  final profileController = BehaviorSubject<AuthModel>();
  StreamSink<AuthModel> get pfSink => profileController.sink;
  Stream<AuthModel> get pfStream => profileController.stream;

  String result;
  AuthModel data;
  handleUserAuthenticationLogin() async {
    // print('Email ${emailAuthController.value}');
    // print('Password ${passwordAuthController.value}');
    result = await userAuthLogin(
        emailAuthController.value, passwordAuthController.value);
    profileController.sink.add(data);

    return result;
  }

  handleUserAuthenticationSignUp() {
    print('Email ${emailAuthSignupController.value}');
    print('Password ${passwordAuthSignupController.value}');
  }

  Future<String> handleUserAuthenticationReset() async {
    result = await userAuthRest(restAuthController.value);
    profileController.sink.add(data);

    return result;
  }

  @override
  void dispose() {
    emailAuthController.close();
    passwordAuthController.close();
    emailAuthSignupController.close();
    passwordAuthSignupController.close();
    restAuthController.close();
    profileController.close();
  }
}
