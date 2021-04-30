import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/bottom_navigation.dart';
import 'package:wow/screen/login_screen.dart';

class LoginChecker {
  handleLoginChecker() async {
    bool isLogin = await isLgoin();
    if (isLogin) {
      return Nav();
    } else {
      return LoginScreen();
    }
  }

  isLgoin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = prefs.getBool('isUserLogin');
    return result;
  }
}
