// import 'package:smishing_identifier_application/utils/check_permissions.dart';
// import 'package:telephony/telephony.dart';

// class ListenSms {

//   Telephony telephony = Telephony.instance;

//   String fromAddress = "";

//   IsPermissionGranted chkPermission = IsPermissionGranted();

//   void listenForIncoming(){

//     if(chkPermission.permissionGranted != null && chkPermission.permissionGranted != false)
//     {
//       telephony.listenIncomingSms(onNewMessage: (SmsMessage message) {
//       fromAddress = message.address.toString();
//       },
//       listenInBackground: false,
//       );
//     }
//     else
//     {
//       fromAddress = "SMS Permission Required";
//     }

//   }
    
// }