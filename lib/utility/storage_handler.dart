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
      if (fileContents.contains(url)) {
        return "UNSAFE";
      } else {
        final apiResponse = await makeRequest(url);

        if (apiResponse == "MALWARE" || apiResponse == "SOCIAL_ENGINEERING") {
          return "UNSAFE";
        } else {
          return "SAFE";
        }
      }
    } else {
      await file.create();
      return readFromFile(url);
    }
  }
}
