import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Receiver object initialized.
  SmsReceiver receiver = new SmsReceiver();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Smishing Identifier"),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {}
          ),
      );
  }
}