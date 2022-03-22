import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/screens/harmful_screen.dart';
import 'package:smishing_identifier_application/screens/my_inbox.dart';
import 'package:smishing_identifier_application/screens/safe_Screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Smishing Identifier",
          style: TextStyle(
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),

        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "INBOX",),
            Tab(text: "SAFE",),
            Tab(text: "UNSAFE",)
          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController, 
        children: const [
          SMSInbox(),
          SafeScreen(),
          HarmfulScreen()
        ],
        ),
    );
  }
}