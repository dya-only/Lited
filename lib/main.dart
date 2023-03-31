import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Lite'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (
        child: Column(
          children: <Widget>[
            Container (
              width: double.infinity,
              height: 350,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              decoration: BoxDecoration (
                borderRadius: const BorderRadius.only (
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: Colors.blue,
              ),
              child: Center (
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text ('Lite',
                      style: TextStyle (
                        fontSize: 40,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ),
            ),
            Center (
              child: Column (
                children: <Widget>[
                  for (int i = 0; i < 6; i++)
                    Container (
                      width: 320,
                      height: 250,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Card (
                        shape: RoundedRectangleBorder (
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: const Center (
                          child: Text('This is Card',
                            style: TextStyle (
                                fontSize: 30,
                                fontFamily: 'Lexend,'
                            ),
                          ),
                        )
                      ),
                    )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
