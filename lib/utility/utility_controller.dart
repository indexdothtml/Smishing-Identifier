import 'package:smishing_identifier_application/utility/extracter.dart';
import 'package:telephony/telephony.dart';

class UtilityController {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> messages = [];

  chkInbox() async {
    messages = await telephony.getInboxSms(columns: [
      SmsColumn.ADDRESS,
      SmsColumn.BODY,
    ], sortOrder: [
      OrderBy(SmsColumn.ID, sort: Sort.DESC),
    ]);
  }

  Future<String> fromExtracter(index) async {
    print("1) I AM INBOX, AND I AM SENDING SMS OF INDEX TO EXTRACTER : $index");
    String responseResult =
        await extractLink((messages[index].body).toString());
    return responseResult;
  }

} // UtilityController class
