import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:smishing_identifier_application/utility/api_request.dart';

class AppDataStorageManager {

  //Following method is used to find the extract path inside android to store the application files. 
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //Following method is used to create the files at finded path.
  Future<File> get _localUnsafeFile async {
    final path = await _localPath;
    return File('$path/threatURLs.txt');
  }

  Future<File> get _localSafeFile async {
    final path = await _localPath;
    return File('$path/safeURLs.txt');
  }

  //After the final result from API response. If URL is unsafe then written inside the unsafeURL file.
  void writeToThreatFile(String unsafeURL) async {
    final file = await _localUnsafeFile;
    final fileobj = await file.open(mode: FileMode.append);

    await fileobj.writeString(unsafeURL);
    await fileobj.close();
  }

  //After the final result from API response. If URL is safe then written inside the safeURL file.
  void writeToSafeFile(String safeURL) async {
    final file = await _localSafeFile;
    final fileobj = await file.open(mode: FileMode.append);

    await fileobj.writeString(safeURL);
    await fileobj.close();
  }

  //After redirecting URL process, next step is to check URL inside local dataset.
  //Local dataset contains two normal text file unsafeURL file and safeURL file.
  //The URL is check within both the files. If the URL found in safeURL file then URL is safe and vise-versa.
  Future<String> readFromFile(String url) async {
    final threatFile = await _localUnsafeFile;
    final safeFile = await _localSafeFile;

    var isThreatFileExist = await threatFile.exists();
    var isSafeFileExist = await safeFile.exists();

    if (isThreatFileExist && isSafeFileExist) {
      final threatFileContents = await threatFile.readAsString();
      final safeFileContents = await safeFile.readAsString();

      if (threatFileContents.contains(url)) {
        return "UNSAFE";
      } else if (safeFileContents.contains(url)) {
        return "SAFE";
      } else {
        final result = await makeRequest(url);
        if (result != "SAFE") {
          return "UNSAFE";
        } else {
          return "SAFE";
        }
      }
    } else {
      await threatFile.create();
      await safeFile.create();
      return readFromFile(url);
    }
  }
}
