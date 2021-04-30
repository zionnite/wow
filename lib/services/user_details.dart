import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString('user_id');
    print('result ${result}');
    return result;
  }

  getUserFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString('full_name');
    return result;
  }

  getUserAge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString('age');
    return result;
  }

  getUserSex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString('sex');
    return result;
  }

  getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString('email');
    return result;
  }

  getUserPhoneNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString('phone_no');
    return result;
  }

  getUserUserImg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String result = prefs.getString('user_img');
    return result;
  }
}
