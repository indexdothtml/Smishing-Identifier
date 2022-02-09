import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/pages/sms_dialog.dart';
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

  Map<int, String> safeUnsafeData = {};

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
                    leading: Icon(
                      Icons.textsms,
                      color: Colors.deepPurple,
                    ),
                    title: Text(
                        utilityController.messages[index].address.toString()),
                    subtitle: Text(
                      utilityController.messages[index].body.toString(),
                      maxLines: 3,
                    ),
                    style: ListTileStyle.drawer,
                    onTap: () async {
                      String responseResult =
                          await utilityController.fromExtracter(index);
                      showSMSDialog(context, utilityController.messages,
                          responseResult, index);
                      // callFromExtracterFunction(index) async {

                      // }
                    },
                  ),
                );
              },
            );
          }),

      // body: ListView.separated(
      //   separatorBuilder: (context, index) => const Divider(
      //     color: Colors.black,
      //   ),
      //   itemCount: utilityController.messages.length,
      //   itemBuilder: (context, index) {
      //     // callFromExtracterFunction(messages, index);

      //     print(
      //         "2) I AM INBOX, AND I GOT THE FINAL RESULT FROM EXTRACTER : ${safeUnsafeData[index]} FOR INDEX $index"); //DEBUG
      //     if (safeUnsafeData[index] == "UNSAFE") {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ListTile(
      //           leading: const Icon(
      //             Icons.warning,
      //             color: Colors.redAccent,
      //           ),
      //           title:
      //               Text(utilityController.messages[index].address.toString()),
      //           subtitle: Text(
      //             utilityController.messages[index].body.toString(),
      //           ),
      //           trailing: Text(index.toString()),
      //           style: ListTileStyle.drawer,
      //         ),
      //       );
      //     } else {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: ListTile(
      //           leading: const Icon(
      //             Icons.textsms,
      //             color: Colors.deepPurple,
      //           ),
      //           title:
      //               Text(utilityController.messages[index].address.toString()),
      //           subtitle: Text(
      //             utilityController.messages[index].body.toString(),
      //           ),
      //           trailing: Text(index.toString()),
      //           style: ListTileStyle.drawer,
      //         ),
      //       );
      //     }
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     print(
      //         "CALLING SICONTROLLER FUNCTION INSIDE UTILITY CONTROLLER CLASS");
      //     safeUnsafeData = utilityController.siController();
      //   },
      // ),
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
