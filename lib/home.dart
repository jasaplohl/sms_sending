import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:sms_advanced/sms_advanced.dart';

class Home extends StatelessWidget {

  static const message = "This is a test message.";
  static const phoneNumber = "040618876";

  // Takes you to the sms page and you need to manually send the sms
  void sendTextFlutterSms() async {
    List<String> recipents = [phoneNumber];

    String _result = await sendSMS(
      message: message, 
      recipients: recipents
    ).catchError((onError) {
        print(onError);
      });
    print(_result);
  }

  // Uses the sms_advanced library to send the sms message
  void sendTextSmsAdvanced() async {
    SmsSender sender = SmsSender();
    
    SmsMessage sms = SmsMessage(phoneNumber, message);
    sms.onStateChanged.listen((state) {
      print(state);
      if (state == SmsMessageState.Sent) {
        print("SMS is sent!");
      } else if (state == SmsMessageState.Delivered) {
        print("SMS is delivered!");
      }
    });
    sender.sendSms(sms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Send SMS")),
      body: Center(
        child: TextButton.icon(
          onPressed: sendTextSmsAdvanced, 
          icon: const Icon(Icons.send), 
          label: const Text("Send")
        )
      )
    );
  }
}