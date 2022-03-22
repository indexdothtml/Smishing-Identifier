import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/screens/sms_dialog.dart';

class HarmfulScreen extends StatefulWidget {
  const HarmfulScreen({ Key? key }) : super(key: key);

  @override
  _HarmfulScreenState createState() => _HarmfulScreenState();
}

class _HarmfulScreenState extends State<HarmfulScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          //Future builder contains the future which contains function call that helps in to generate message list.
          // future: utilityController.harmfulMessages,
          //Builder which is used to build the ListView, contains the input from future.
          builder: (context, snapshot) {
            //Builder returns the ListView which is able to print the list of messages.
            //The whole below part is for displaying messages in the form of list.
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
              itemCount: utilityController.harmfulMessages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.redAccent,
                    ),
                    title: Text(
                        utilityController.harmfulMessages[index].address.toString()),
                    subtitle: Text(
                      utilityController.harmfulMessages[index].body.toString(),
                    ),
                    style: ListTileStyle.drawer,
                  ),
                );
              },
            );
          });
  }
}