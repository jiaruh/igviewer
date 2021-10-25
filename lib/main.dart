import 'dart:io';

import 'package:flutter/material.dart';

import 'page/main_page.dart';

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  // gank.io API证书目前是过期状态。
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IO Reaader',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const PhotoPage(),
    );
  }
}
