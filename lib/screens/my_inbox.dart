import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/screens/waiting_screen.dart';
import 'package:smishing_identifier_application/utility/utility_controller.dart';
import 'package:telephony/telephony.dart';

class SMSInbox extends StatefulWidget {
  const SMSInbox({Key? key}) : super(key: key);

  @override
  _SMSInboxState createState() => _SMSInboxState();
}

class _SMSInboxState extends State<SMSInbox> {
  final Telephony telephony = Telephony.instance;
  UtilityController utilityController = UtilityController();
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    initListenIncomingSMS();
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
      ),
      body: FutureBuilder(
          future: utilityController.chkInbox(),
          builder: (context, snapshot) {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
              itemCount: utilityController.messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.textsms,
                      color: Colors.deepPurple,
                    ),
                    title: Text(
                        utilityController.messages[index].address.toString()),
                    subtitle: Text(
                      utilityController.messages[index].body.toString(),
                      maxLines: 2,
                    ),
                    style: ListTileStyle.drawer,
                    onTap: () async {
                      isWaiting = true;
                      waitASecond(context, isWaiting, null, "", index);
                      String responseResult = await utilityController.fromExtracter(index);
                      isWaiting = false;
                      waitASecond(context, isWaiting, utilityController.messages, responseResult, index);
                    },
                  ),
                );
              },
            );
          }),
    );
  }

  onMessage(SmsMessage newMessage) async {
    setState(() {});
  }

  Future<void> initListenIncomingSMS() async {
    telephony.listenIncomingSms(
        onNewMessage: onMessage, listenInBackground: false);
  }
}
