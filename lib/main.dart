import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wow/blocs/QouteBloc.dart';
import 'package:wow/blocs/app_bloc.dart';
import 'package:wow/blocs/bloc_provider.dart';
import 'package:wow/blocs/forum_bloc.dart';
import 'package:wow/bottom_navigation.dart';
import 'package:wow/screen/forum_detail_screen.dart';
import 'package:wow/screen/forum_screen.dart';
import 'package:wow/screen/home_screen.dart';
import 'package:wow/screen/quote_detail_screen.dart';
import 'package:wow/screen/quote_screen.dart';
import 'package:wow/screen/send_private_message.dart';
import 'package:wow/utils.dart';

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
  runApp(BlocProvider(
    bloc: AppBloc(),
    child: BlocProvider(
      bloc: QuoteBloc(),
      child: BlocProvider(
        bloc: ForumBloc(),
        child: MyApp(),
      ),
    ),
  ));
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: '/',
      routes: {
        //'/': (context) => MyApp(),
        HomeScreenTopPart.id: (context) => HomeScreenTopPart(),
        QuoteScreen.id: (context) => QuoteScreen(),
        ForumScreen.id: (context) => ForumScreen(),
        Nav.id: (context) => Nav(),
        ForumDetailScreen.id: (context) => ForumDetailScreen(),
        QuoteDetailScreen.id: (context) => QuoteDetailScreen(),
        SendPrivateMessage.id: (context) => SendPrivateMessage(),
      },
      home: Nav(),
      theme: appTheme,
    );
  }
}
