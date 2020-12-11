import 'package:flutter/material.dart';
import 'package:wow/bottom_navigation.dart';
import 'package:wow/logic/bloc_provider.dart';
import 'package:wow/logic/forum_bloc.dart';
import 'package:wow/logic/home_bloc.dart';
import 'package:wow/logic/quote_bloc.dart';

Future<void> main() async {
  runApp(BlocProvider(
    bloc: HomescreenBloc(),
    child: MaterialApp(
      home: BlocProvider(
        bloc: QuteBloc(),
        child: BlocProvider(
          bloc: ForumBloc(),
          child: MyApp(),
        ),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Nav(),
    );
  }
}
