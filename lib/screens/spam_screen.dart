import 'package:flutter/material.dart';

class SpamScreen extends StatefulWidget {
  const SpamScreen({ Key? key }) : super(key: key);

  @override
  _SpamScreenState createState() => _SpamScreenState();
}

class _SpamScreenState extends State<SpamScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Spams"),
    );
  }
}
