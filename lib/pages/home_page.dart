import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final Telephony telephony = Telephony.instance;
  bool? permissionsGranted;
  List<SmsMessage> messages = [];

  @override
  void initState() {
    super.initState();
    sendSms();
  }

  sendSms() async{
    permissionsGranted = await telephony.requestPhoneAndSmsPermissions;

    if(permissionsGranted != null && permissionsGranted != false){
      //Below line is for sending sms.
      // telephony.sendSms(to: "7219015102", message: "Smishing Identifier testing", statusListener: listener);

      //Below lines is for Displaying all messages.
      messages = await telephony.getInboxSms(
		    columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
		    sortOrder: [OrderBy(SmsColumn.ADDRESS, sort: Sort.DESC),
			    OrderBy(SmsColumn.BODY)]
		    );
      // Map<SmsMessage, int> map = Map.fromIterables(messages, 0);
      setState((){});
      
    }
  }
  
  //Below listener is for listening the status message send or not.
  // final SmsSendStatusListener listener = (SendStatus status) {
  //   print(status.index);
  // };

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Smishing Identifier"),
        ),

        body: SingleChildScrollView(

          child: Column(
            children : [
              // Card(
              //   child: ,
              // ),
              for(var sms in messages) Card(child : Text(sms.body.toString()))
              
              
          
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {}
          ),
          
      );
  }
}