import 'package:http/http.dart' as http;
import 'package:smishing_identifier_application/utility/api_request.dart';

//After URL got from extracter the redirectDetective check for the URL redirection.
//This is important because, if we pass masked URL as it is to safe browsing server then it gives false result.
//After finding actual URL, next step is to check the URL in local url dataset before sending to safe browsing server.
Future<String> redirectDetective(String url) async {
  String localurl;

  if (url.contains("http://") || url.contains("https://")) {
    localurl = url;
  } else {
    localurl = "http://" + url;
  }
  try {
    http.Request request = http.Request("GET", Uri.parse(localurl))..followRedirects = false;
    http.Client client = http.Client();
    http.StreamedResponse response = await client.send(request);
    client.close();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return await appDataStorageManager.readFromFile(url);
    } else if (response.statusCode >= 300 && response.statusCode <= 399) {
      return redirectDetective(response.headers['location'].toString());
    } else if (response.statusCode >= 400 && response.statusCode <= 499) {
      return "Client Side Error! \n Status Code : ${response.statusCode}";
    } else {
      return "Server Side Error! Or May Be Informational Response \n Status Code : ${response.statusCode}";
    }
  } catch (error) {
    return "Error While Checking Redirection. \n Check Your Internet Connection.";
  }
}
