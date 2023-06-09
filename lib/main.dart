import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './info.dart';

String URL = 'https://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=ttbentrydia76910913001&QueryType=ItemNewAll&MaxResults=30&start=1&CategoryId=50927&Cover=Big&output=js&Version=20131101';
String INFO_URL = 'http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbentrydia76910913001&Query=%EC%98%86%EC%A7%91%EC%B2%9C%EC%82%AC%EB%8B%98&QueryType=Title&Cover=Big&MaxResults=5&start=1&SearchTarget=Book&output=js&Version=20131101';
var Books = [];
var InfoBooks = [];

Future<String> fetchGet() async {
  final response = await http.get(Uri.parse(URL));

  if (response.statusCode == 200) {
    if (kDebugMode) print('Loading...');
    Books = await jsonDecode(response.body)['item'];
    if (kDebugMode) {
      print(Books);
    }
    return 'true';
  } else {
    throw Exception('Failed to load data.');
  }
}

Future<String> fetchInfo (String title) async {
  INFO_URL = 'http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbentrydia76910913001&Query=$title&QueryType=Title&Cover=Big&MaxResults=5&start=1&SearchTarget=Book&output=js&Version=20131101';
  final response = await http.get(Uri.parse(INFO_URL));

  if (response.statusCode == 200) {
    if (kDebugMode) print('Searching...');
    InfoBooks = await jsonDecode(response.body)['item'];
    if (kDebugMode) {
      print(InfoBooks);
    }
    return 'true';
  } else {
    throw Exception('Failed to load data.');
  }
}

void main() async {
  await fetchGet();

  if (kDebugMode) {
    print("Loading End");
  }

  runApp(const MyApp());
}

class InfoData {
  var data;
  InfoData({ this.data });
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ super.key });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchPost();
  // }

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
                  for (int i = 0; i < Books.length; i++)
                    GestureDetector (
                      onTap: () async {
                        await fetchInfo(Books[i]['title']);

                        if (context.mounted) {
                          Navigator.push (
                              context,
                              MaterialPageRoute(builder: (context) => InfoPage( info: InfoData( data: InfoBooks )))
                          );
                        }
                      },
                      child: Container (
                        width: 320,
                        height: 250,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: Card (
                          shape: RoundedRectangleBorder (
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 4,
                          child: Row (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipRRect (
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(Books[i]['cover'],
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column (
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container (
                                    width: 100,
                                    // height: 63,
                                    margin: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                                    child: Center (
                                      child: Text (Books[i]['title'].toString(),
                                        style: const TextStyle (
                                          fontSize: 20,
                                          fontFamily: 'Noto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ),
                                  Container (
                                    width: 100,
                                    margin: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                                    child: Text (Books[i]['author'].toString(),
                                      style: const TextStyle (
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'Noto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ),
                      )
                    ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
