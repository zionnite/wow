// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wow/blocs/FollowBloc.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/blocs/app_bloc.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/bottom_navigation.dart';
import 'package:wow/screen/OnBoardingScreen.dart';
import 'package:wow/screen/about_screen.dart';
import 'package:wow/screen/forum_detail_screen.dart';
import 'package:wow/screen/forum_screen.dart';
import 'package:wow/screen/home_screen.dart';
import 'package:wow/screen/login_screen.dart';
import 'package:wow/screen/profile_screen.dart';
import 'package:wow/screen/quote_detail_screen.dart';
import 'package:wow/screen/quote_screen.dart';
import 'package:wow/screen/reset_password.dart';
import 'package:wow/screen/send_private_message.dart';
import 'package:wow/screen/signup_screen.dart';
import 'package:wow/screen/story_screen.dart';
import 'package:wow/screen/update_user_profile.dart';
import 'package:wow/screen/users_screen.dart';
import 'package:wow/screen/view_dis_user_follower.dart';
import 'package:wow/screen/view_dis_user_following.dart';
import 'package:wow/screen/view_followers.dart';
import 'package:wow/screen/view_following.dart';
import 'package:wow/screen/view_user_profile_screen.dart';
import 'package:wow/services/LoginChecker.dart';
import 'package:wow/services/auth_services.dart';
import 'package:wow/utils.dart';

import 'screen/login_screen.dart';

// Future<void> main() async {
//   runApp(BlocProvider(
//     bloc: AppBloc(),
//     child: MaterialApp(
//       home: BlocProvider(
//         bloc: QuoteBloc(),
//         child: MyApp(),
//       ),
//     ),
//   ));
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isUserLogin = prefs.getBool('isUserLogin');
  var isFirstTime = prefs.getBool('isFirstTime');

  // print('User Login ${isUserLogin}');
  // print('User isFirstTime ${isFirstTime}');
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  // );

  runApp(BlocProvider(
    bloc: AppBloc(),
    child: BlocProvider(
      bloc: QuoteBloc(),
      child: BlocProvider(
        bloc: ForumBloc(),
        child: BlocProvider(
          bloc: FollowBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            routes: {
              HomeScreenTopPart.id: (context) => HomeScreenTopPart(),
              QuoteScreen.id: (context) => QuoteScreen(),
              ForumScreen.id: (context) => ForumScreen(),
              Nav.id: (context) => Nav(),
              ForumDetailScreen.id: (context) => ForumDetailScreen(),
              QuoteDetailScreen.id: (context) => QuoteDetailScreen(),
              SendPrivateMessage.id: (context) => SendPrivateMessage(),
              ProfileScreen.id: (context) => ProfileScreen(),
              StoryScreen.id: (context) => StoryScreen(),
              ViewUserProfileScreen.id: (context) => ViewUserProfileScreen(),
              UsersScreen.id: (context) => UsersScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              RegistrationScreen.id: (context) => RegistrationScreen(),
              ResetPassword.id: (context) => ResetPassword(),
              UpdateUserProfile.id: (context) => UpdateUserProfile(),
              AboutScreen.id: (context) => AboutScreen(),
              ViewFollowers.id: (context) => ViewFollowers(),
              ViewFollowing.id: (context) => ViewFollowing(),
              ViewDisUserFollowers.id: (context) => ViewDisUserFollowers(),
              ViewDisUserFollowing.id: (context) => ViewDisUserFollowing(),
            },
            home:
                isFirstTime == null ? OnBoardingScreen() : WowApp(isUserLogin),
            // home: isUserLogin == null ? LoginScreen() : Nav(),
          ),
          // child: MyApp(),
        ),
      ),
    ),
  ));
}

class WowApp extends StatefulWidget {
  var isUserLogin;

  WowApp(this.isUserLogin);
  @override
  _WowAppState createState() => _WowAppState();
}

class _WowAppState extends State<WowApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      routes: {
        HomeScreenTopPart.id: (context) => HomeScreenTopPart(),
        QuoteScreen.id: (context) => QuoteScreen(),
        ForumScreen.id: (context) => ForumScreen(),
        Nav.id: (context) => Nav(),
        ForumDetailScreen.id: (context) => ForumDetailScreen(),
        QuoteDetailScreen.id: (context) => QuoteDetailScreen(),
        SendPrivateMessage.id: (context) => SendPrivateMessage(),
        ProfileScreen.id: (context) => ProfileScreen(),
        StoryScreen.id: (context) => StoryScreen(),
        ViewUserProfileScreen.id: (context) => ViewUserProfileScreen(),
        UsersScreen.id: (context) => UsersScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ResetPassword.id: (context) => ResetPassword(),
        UpdateUserProfile.id: (context) => UpdateUserProfile(),
        AboutScreen.id: (context) => AboutScreen(),
        ViewFollowers.id: (context) => ViewFollowers(),
        ViewFollowing.id: (context) => ViewFollowing(),
        ViewDisUserFollowers.id: (context) => ViewDisUserFollowers(),
        ViewDisUserFollowing.id: (context) => ViewDisUserFollowing(),
      },
      home: widget.isUserLogin == null ? LoginScreen() : Nav(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    Future<bool> _decideNav() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var isUserLogin = prefs.getBool('isUserLogin');

      //print('UserStatus ${isUserLogin}');
      return isUserLogin;
    }

    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      // theme: appTheme,
      // routes: {
      //   HomeScreenTopPart.id: (context) => HomeScreenTopPart(),
      //   QuoteScreen.id: (context) => QuoteScreen(),
      //   ForumScreen.id: (context) => ForumScreen(),
      //   Nav.id: (context) => Nav(),
      //   ForumDetailScreen.id: (context) => ForumDetailScreen(),
      //   QuoteDetailScreen.id: (context) => QuoteDetailScreen(),
      //   SendPrivateMessage.id: (context) => SendPrivateMessage(),
      //   ProfileScreen.id: (context) => ProfileScreen(),
      //   StoryScreen.id: (context) => StoryScreen(),
      //   ViewUserProfileScreen.id: (context) => ViewUserProfileScreen(),
      //   UsersScreen.id: (context) => UsersScreen(),
      //   LoginScreen.id: (context) => LoginScreen(),
      //   RegistrationScreen.id: (context) => RegistrationScreen(),
      //   ResetPassword.id: (context) => ResetPassword(),
      //   UpdateUserProfile.id: (context) => UpdateUserProfile(),
      //   AboutScreen.id: (context) => AboutScreen(),
      //   ViewFollowers.id: (context) => ViewFollowers(),
      //   ViewFollowing.id: (context) => ViewFollowing(),
      //   ViewDisUserFollowers.id: (context) => ViewDisUserFollowers(),
      //   ViewDisUserFollowing.id: (context) => ViewDisUserFollowing(),
      // },
      home: Nav(),
    );
  }
}
