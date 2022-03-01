import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/screens/sms_dialog.dart';

//The below function display progress indicator until process on message gets finished. 
waitASecond(context, isWaiting, messages, String responseResult, index) {
  //show progress indicator if some process is happening else display result.
  if (isWaiting == true) {
    return showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
            elevation: 0,
            insetPadding: EdgeInsets.symmetric(horizontal: 178),
            backgroundColor: Colors.transparent,
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          );
        });
  } else {
    //Removing progress indicator using Navigator and finally passing final result for displaying inside dialog box.
    Navigator.pop(context);
    showSMSDialog(context, messages, responseResult, index);
  }
}
