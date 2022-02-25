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
    return await extractLink((messages[index].body).toString());
  }
} // UtilityController class
