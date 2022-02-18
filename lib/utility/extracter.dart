import 'package:smishing_identifier_application/utility/storage_handler.dart';

AppDataStorageManager appDataStorageManager = AppDataStorageManager();

Future<String> extractLink(String givenbody) async {
  String url = "";

  givenbody = givenbody.replaceAll("\n", ' ');
  givenbody = givenbody.replaceAll("\t", ' ');

  List<String> keywords = givenbody.split(' ');

  for (int i = 0; i < keywords.length; i++) {
    if (keywords[i].contains('.com') ||
        keywords[i].contains('.in') ||
        keywords[i].contains('.org') ||
        keywords[i].contains('.ly') ||
        keywords[i].contains('.at') ||
        keywords[i].contains('http://') ||
        keywords[i].contains('https://') ||
        keywords[i].contains('.xyz')) {
      url = keywords[i];
      break;
    }
  }
  if (url.isNotEmpty) {
    String resultFromStorage = await appDataStorageManager.readFromFile(url);
    return resultFromStorage;
  } else {
    return "No Link Found";
  }
}
