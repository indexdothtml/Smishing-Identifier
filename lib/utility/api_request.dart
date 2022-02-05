import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smishing_identifier_application/utility/storage_handler.dart';

AppDataStorageManager appDataStorageManager = AppDataStorageManager();

Future<String> makeRequest(requestedUrl) async {
  final url = Uri.parse(
      "https://safebrowsing.googleapis.com/v4/threatMatches:find?key=AIzaSyAvPztv_OzAJojxmHvNyi1De20qzubMLaY");
  final header = {"Content-Type": "application/json"};
  final body = jsonEncode({
    "client": {"clientId": "SmishingIdentifier", "clientVersion": "1.0.0"},
    "threatInfo": {
      "threatTypes": ["MALWARE", "SOCIAL_ENGINEERING"],
      "platformTypes": ["ANDROID", "IOS"],
      "threatEntryTypes": ["URL"],
      "threatEntries": [
        {"url": "$requestedUrl"}
      ]
    }
  });

  final response = await http.post(url, headers: header, body: body);
  final jsonData = jsonDecode(response.body);
  if (jsonData.toString() == '{}') {
    return "SAFE";
  } else {
    appDataStorageManager.writeToFile(requestedUrl);
    return jsonData["matches"][0]["threatType"];
  }
}
