import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/utility/utility_controller.dart';

UtilityController utilityController = UtilityController();

//If Process ends then progress indicator stops and result is passed here in showSMSDialog function.
//which display the result in both condtion of safe and unsafe.
showSMSDialog(context, messages, String responseResult, index) {
  if (responseResult == "UNSAFE") {
    int flag = 0;
  
    for(int i = 0; i < utilityController.harmfulMessages.length; i++) {
      if(utilityController.harmfulMessages[i].body == messages[index].body) {
        flag = 1;
      }
    }
  
    if(flag != 1) {
      utilityController.harmfulMessages.add(messages[index]);
    }
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.redAccent,
                      size: 35,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      messages[index].address,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      messages[index].body,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ));
        });
  } else {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green,
                      size: 35,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      messages[index].address,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      messages[index].body,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ));
        });
  }
}
