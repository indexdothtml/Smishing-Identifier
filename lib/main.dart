import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/pages/my_inbox.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home : SMSInbox(),
    );
  }
}


