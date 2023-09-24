import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech2enrich/menu.dart';
import 'global.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _paddingPlay = 6.0;
  double _paddingExit = 6.0;


  void initState() {
    playbgm1();
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width / 2;
    double _deviceHeight = MediaQuery.of(context).size.height / 5;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/homescreen.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 160),
                child: GestureDetector(
                  onTapDown: (_) => setState(() {
                    _paddingPlay = 0.0;
                  }),
                  onTapUp: (_) => setState(() {
                    _paddingPlay = 6.0;
                  }),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => menu()));
                  },
                  child: AnimatedContainer(
                    padding: EdgeInsets.only(bottom: _paddingPlay),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    duration: Duration(milliseconds: 100),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 13, horizontal: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber,
                      ),
                      child: Text(
                        'PLAY',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 270),
                child: GestureDetector(
                  onTapDown: (_) => setState(() {
                    _paddingExit = 0.0;
                  }),
                  onTapUp: (_) => setState(() {
                    _paddingExit = 6.0;
                  }),
                  onTap: () {
                    exit(0);
                  },
                  child: AnimatedContainer(
                    padding: EdgeInsets.only(bottom: _paddingExit),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)),
                    duration: Duration(milliseconds: 100),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber,
                      ),
                      child: Text(
                        'EXIT',
                        style: TextStyle(
                          fontSize: 13,
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
    );
  }
}
