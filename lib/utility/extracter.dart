import 'package:smishing_identifier_application/utility/api_request.dart';

Future<String> extractLink(String givenbody) async {
  String link = "";

  givenbody = givenbody.replaceAll("\n", ' ');
  givenbody = givenbody.replaceAll("\t", ' ');

  List<String> keywords = givenbody.split(' ');
  
  for (int i = 0; i < keywords.length; i++) {
    if (keywords[i].contains('.com') ||
        keywords[i].contains('.in') ||
        keywords[i].contains('.org') ||
        keywords[i].contains('.xyz')) {
      link = keywords[i];
    }
  }
  print(link);
  if (link.isNotEmpty) {
    return await makeRequest(link);
  } else {
    return "No Link Found";
  }
}
