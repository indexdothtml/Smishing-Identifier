import 'package:smishing_identifier_application/utility/extracter.dart';
import 'package:telephony/telephony.dart';

class UtilityController {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> messages = [];
  List<SmsMessage> harmfulMessages = [];
  
  //chkInbox function is used to fetch all list of messages from inbox.
  //chkInbox function calles after new message arrives. At that condition list view generate new list.
  chkInbox() async {
    messages = await telephony.getInboxSms(columns: [
      SmsColumn.ADDRESS,
      SmsColumn.BODY,
    ], sortOrder: [
      OrderBy(SmsColumn.ID, sort: Sort.DESC),
    ]);
  }

  //User interated message get passed to extracter for further process.
  Future<String> fromExtracter(index) async {
    return await extractLink((messages[index].body).toString());
  }
}
