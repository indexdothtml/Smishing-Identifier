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
  //Constant app head part, contains app name and constant style.
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

      //Starting app body part from here, contains the future builder which creates the list of sms in runtime.
      body: FutureBuilder(
          //Future builder contains the future which contains function call that helps in to generate message list.
          future: utilityController.chkInbox(),
          //Builder which is used to build the ListView, contains the input from future.
          builder: (context, snapshot) {
            //Builder returns the ListView which is able to print the list of messages.
            //The whole below part is for displaying messages in the form of list.
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

                    //onTap contains one anonymous function which get's called after the user clicks on one perticular message.
                    onTap: () async {
                      //waitASecond function calls before sending message to extracter.
                      //waitASecond gives the user a progress indicator until user gets the result after processing. 
                      isWaiting = true;
                      waitASecond(context, isWaiting, null, "", index);

                      //After clicking on one perticular message the whole message is sends for further process.
                      //In this stage the message get sends to utility controller file which contains the control of extracter.
                      String responseResult = await utilityController.fromExtracter(index);

                      //waitASecond function stop after getting result.
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

  //onMessage function calls after new message arrived.
  //And make changes in list of messages.
  onMessage(SmsMessage newMessage) async {
    setState(() {});
  }

  //initListerIncomingSMS function listens for new incoming message.
  Future<void> initListenIncomingSMS() async {
    telephony.listenIncomingSms(
        onNewMessage: onMessage, listenInBackground: false);
  }
}
