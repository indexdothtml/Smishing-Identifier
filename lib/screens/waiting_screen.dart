import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/screens/sms_dialog.dart';

waitASecond(context, isWaiting, messages, String responseResult, index) {
  if(isWaiting == true)
  {
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

  }
  else
  {
    Navigator.pop(context);
    showSMSDialog(context, messages,
                          responseResult, index);
  }
}