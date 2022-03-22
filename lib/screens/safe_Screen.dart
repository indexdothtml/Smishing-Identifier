import 'package:flutter/material.dart';
import 'package:smishing_identifier_application/screens/sms_dialog.dart';

class SafeScreen extends StatefulWidget {
  const SafeScreen({ Key? key }) : super(key: key);

  @override
  _SafeScreenState createState() => _SafeScreenState();
}

class _SafeScreenState extends State<SafeScreen> {
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
              itemCount: utilityController.safeMessages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green,
                    ),
                    title: Text(
                        utilityController.safeMessages[index].address.toString()),
                    subtitle: Text(
                      utilityController.safeMessages[index].body.toString(),
                    ),
                    style: ListTileStyle.drawer,
                  ),
                );
              },
            );
          });
  }
}