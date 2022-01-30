import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

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
                    maxLines: 2,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  chkInbox() async {
    messages = await telephony.getInboxSms(columns: [
      SmsColumn.ADDRESS,
      SmsColumn.BODY
    ], sortOrder: [
      OrderBy(SmsColumn.ADDRESS, sort: Sort.ASC),
      OrderBy(SmsColumn.BODY, sort: Sort.ASC)
    ]);
  }
}
