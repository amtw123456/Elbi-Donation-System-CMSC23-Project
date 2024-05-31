import 'package:flutter_sms/flutter_sms.dart';

void sendMessage(String message, List<String> recipents) async {
  String result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(result);
}
