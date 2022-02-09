import 'package:smishing_identifier_application/utility/storage_handler.dart';

AppDataStorageManager appDataStorageManager = AppDataStorageManager();

Future<String> extractLink(String givenbody) async {
  print("1) I GOT THIS BODY : $givenbody");
  String url = "";

  givenbody = givenbody.replaceAll("\n", ' ');
  givenbody = givenbody.replaceAll("\t", ' ');

  List<String> keywords = givenbody.split(' ');
  
  for (int i = 0; i < keywords.length; i++) {
    if (keywords[i].contains('.com') ||
        keywords[i].contains('.in') ||
        keywords[i].contains('.org') ||
        keywords[i].contains('.xyz')) {
      url = keywords[i];
      break;
    }
  }
  if (url.isNotEmpty) {
    print("2) I AM EXTRACTER, I GOT THE URL INSIDE BODY : $url");
    print("3) I AM EXTRACTER, NOW I AM SENDING THIS URL TO STORAGE READER : $url");
    String resultFromStorage = await appDataStorageManager.readFromFile(url);
    print("4) I AM EXTRACTER, I GOT THE RESULT FROM STORAGE : $resultFromStorage FOR URL $url");
    return resultFromStorage;
  } else {
    print("2) I AM EXTRACTER, NOT FOUND ANY URL INSIDE BODY");
    return "No Link Found";
  }
}
