import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:smishing_identifier_application/utility/api_request.dart';

class AppDataStorageManager {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localUnsafeFile async {
    final path = await _localPath;
    return File('$path/threatURLs.txt');
  }

  Future<File> get _localSafeFile async {
    final path = await _localPath;
    return File('$path/safeURLs.txt');
  }

  void writeToThreatFile(String unsafeURL) async {
    final file = await _localUnsafeFile;
    final fileobj = await file.open(mode: FileMode.append);

    await fileobj.writeString(unsafeURL);
    await fileobj.close();
  }

  void writeToSafeFile(String unsafeURL) async {
    final file = await _localSafeFile;
    final fileobj = await file.open(mode: FileMode.append);

    await fileobj.writeString(unsafeURL);
    await fileobj.close();
  }

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
        if (result == "MALWARE" || result == "SOCIAL_ENGINEERING") {
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
