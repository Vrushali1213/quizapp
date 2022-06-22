import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/datamodel/dataview.dart';
import 'package:quizapp/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductsVM(),
          ),
        ],
        child: MaterialApp(
          title: 'Splash Screen',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: MyHomePage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SizedBox(
              width: 250.0,
              child: Text("Quiz App",
                  style: TextStyle(
                      color: Color(0xffE36DA6),
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}
