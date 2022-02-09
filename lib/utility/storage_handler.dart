import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:smishing_identifier_application/utility/api_request.dart';

class AppDataStorageManager {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/threatURLs.txt');
  }

  void writeToFile(String unsafeURL) async {
    print("I AM FILE WRITER, AND THE API WANTS TO STORE THIS URL : $unsafeURL");
    final file = await _localFile;
    final fileobj = await file.open(mode: FileMode.append);

    await fileobj.writeString(unsafeURL);
    await fileobj.close();
  }

  Future<String> readFromFile(String url) async {
    final file = await _localFile;

    var isFileExist = await file.exists();

    if (isFileExist) {
      final fileContents = await file.readAsString();
      print(
          "1) I AM STORAGE, NOW FILE CONTAINS : $fileContents CHECKING AT THE TIME OF THIS URL : $url"); //DEBUG
      if (fileContents.contains(url)) {
        print(
            "2) I AM STORAGE, AND I FOUND URL IN FILE SO IT IS UNSAFE : $url");
        return "UNSAFE";
      } else {
        print(
            "2) I AM STORAGE, URL NOT FOUND IN FILE SO REQUESTING TO API : $url");
        final apiResponse = await makeRequest(url);

        if (apiResponse == "MALWARE" || apiResponse == "SOCIAL_ENGINEERING") {
          print(
              "3) I AM STORAGE, AND I GOT URL IS UNSAFE RESULT FROM API : $url");
          return "UNSAFE";
        } else {
          print(
              "3) I AM STORAGE, AND I GOT URL IS SAFE RESULT FROM API : $url");
          return "SAFE";
        }
      }
    } else {
      print("I AM STORAGE, FILE NOT FOUND BUT CREATED SUCCESSFULLY"); //DEBUG
      await file.create();
      return readFromFile(url);
    }
  }
}
