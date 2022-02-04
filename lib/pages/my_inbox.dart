import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/utility/extracter.dart';
import 'package:telephony/telephony.dart';

String responseResult = "";

class SMSInbox extends StatefulWidget {
  const SMSInbox({Key? key}) : super(key: key);

  @override
  _SMSInboxState createState() => _SMSInboxState();
}

class _SMSInboxState extends State<SMSInbox> {
  final Telephony telephony = Telephony.instance;

  List<SmsMessage> messages = [];

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
        future: chkInbox(),
        builder: (context, snapshot) {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black,
            ),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              dynamic fromExtractor() async {
                responseResult =
                    await extractLink(messages[index].body.toString());
              }

              fromExtractor();
              print(responseResult);
              if (responseResult == "MALWARE") {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.warning,
                      color: Colors.redAccent,
                    ),
                    title: Text(messages[index].address.toString()),
                    subtitle: Text(
                      messages[index].body.toString(),
                    ),
                    style: ListTileStyle.drawer,
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.textsms,
                      color: Colors.deepPurple,
                    ),
                    title: Text(messages[index].address.toString()),
                    subtitle: Text(
                      messages[index].body.toString(),
                    ),
                    style: ListTileStyle.drawer,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  chkInbox() async {
    messages = await telephony.getInboxSms(columns: [
      SmsColumn.ADDRESS,
      SmsColumn.BODY,
    ], sortOrder: [
      OrderBy(SmsColumn.ID, sort: Sort.DESC),
    ]);
  }

  onMessage(SmsMessage newMessage) async {
    setState(() {});
  }

  Future<void> initListenIncomingSMS() async {
    telephony.listenIncomingSms(
        onNewMessage: onMessage, listenInBackground: false);
  }
}
