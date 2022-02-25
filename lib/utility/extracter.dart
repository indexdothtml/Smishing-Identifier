import 'package:smishing_identifier_application/utility/check_redirection.dart';

Future<String> extractLink(String givenbody) async {
  String url = "";

  givenbody = givenbody.replaceAll("\n", ' ');
  givenbody = givenbody.replaceAll("\t", ' ');

  List<String> keywords = givenbody.split(' ');

  for (int i = 0; i < keywords.length; i++) {
    if (keywords[i].contains('.a') ||
        keywords[i].contains('.b') ||
        keywords[i].contains('.c') ||
        keywords[i].contains('.d') ||
        keywords[i].contains('.e') ||
        keywords[i].contains('.f') ||
        keywords[i].contains('.g') ||
        keywords[i].contains('.h') ||
        keywords[i].contains('.i') ||
        keywords[i].contains('.j') ||
        keywords[i].contains('.k') ||
        keywords[i].contains('.l') ||
        keywords[i].contains('.m') ||
        keywords[i].contains('.n') ||
        keywords[i].contains('.o') ||
        keywords[i].contains('.p') ||
        keywords[i].contains('.q') ||
        keywords[i].contains('.r') ||
        keywords[i].contains('.s') ||
        keywords[i].contains('.t') ||
        keywords[i].contains('.u') ||
        keywords[i].contains('.v') ||
        keywords[i].contains('.w') ||
        keywords[i].contains('.x') ||
        keywords[i].contains('.y') ||
        keywords[i].contains('.z')) {
      url = keywords[i];
      break;
    }
  }
  if (url.isNotEmpty) {
    String result = await redirectDetective(url);
    return result;
  } else {
    return "No Link Found";
  }
}
