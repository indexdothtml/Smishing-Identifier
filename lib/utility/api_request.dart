import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smishing_identifier_application/utility/storage_handler.dart';

AppDataStorageManager appDataStorageManager = AppDataStorageManager();

//makeRequest function is the final process of Identification of URL condition.
//If URL is not found inside local dataset then it is passed here in makeRequest function.
//makeRequest function make the request to Google's Safe Browsing server for final and true identification using generated API key.
Future<String> makeRequest(requestedUrl) async {
  final url = Uri.parse("https://safebrowsing.googleapis.com/v4/threatMatches:find?key=<YOUR_GOOGLE_SAFE_BROWSING_API_KEY>");
  final header = {"Content-Type": "application/json"};
  final body = jsonEncode({
    "client": {"clientId": "SmishingIdentifier", "clientVersion": "1.0.0"},
    "threatInfo": {
      "threatTypes": ["MALWARE", "SOCIAL_ENGINEERING", "THREAT_TYPE_UNSPECIFIED", "UNWANTED_SOFTWARE", "POTENTIALLY_HARMFUL_APPLICATION"],
      "platformTypes": ["ANY_PLATFORM"],
      "threatEntryTypes": ["URL"],
      "threatEntries": [
        {"url": "$requestedUrl"}
      ]
    }
  });

  try {
    final response = await http.post(url, headers: header, body: body);
    final jsonData = jsonDecode(response.body);

    //The final result is returned and also stored in local dataset for futher refering.
    //Storing result of url inside local dataset will very helpful in reducing API calls.
    if (jsonData.toString() == '{}') {
      appDataStorageManager.writeToSafeFile(" " + requestedUrl);
      return "SAFE";
    } else {
      appDataStorageManager.writeToThreatFile(" " + requestedUrl);
      return jsonData["matches"][0]["threatType"];
    }
  } catch (error) {
    return "Error While Requesting To Server \n Check Internet Connection.";
  }
}
