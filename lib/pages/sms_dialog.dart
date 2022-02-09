import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/utility/utility_controller.dart';

UtilityController utilityController = UtilityController();

showSMSDialog(context, messages, String responseResult, index) {

  if (responseResult == "UNSAFE") {
    return showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.warning,
              color: Colors.redAccent,
            ),
          );
        });
  } else {
    return showDialog(
        context: context,
        builder: (context) {
          return const Dialog(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.check,
              color: Colors.greenAccent,
            ),
          );
        });
  }
}
