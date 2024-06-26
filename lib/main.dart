import 'package:flutter/material.dart';
import 'package:red/pages/first_page.dart';
import 'package:red/pages/index_page.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IndexPage(),
    );
  }
}
