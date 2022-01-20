import 'package:flutter_test/flutter_test.dart';

import 'package:authing_sdk/authing.dart';
import 'package:authing_sdk/client.dart';
import 'package:authing_sdk/result.dart';

void main() {
  String pool = "60caaf41da89f1954875cee1";
  String appid = "60caaf41df670b771fd08937";
  Authing.init(pool, appid);

  test('register by phone code', () async {
    // change to your testing phone number. fill code after receiving the SMS
    // NOTE: add country code prefix
    String phone = "+86xxx";
    AuthResult result = await AuthClient.registerByPhoneCode(phone, "9314", "111111");
    expect(result.code, 200);
    expect(result.user.phone, phone);

    AuthResult result2 = await AuthClient.loginByAccount(phone, "111111");
    expect(result2.code, 200);
    expect(result2.user.phone, phone);
  });

  test('login by phone code', () async {
    // change to your testing phone number. fill code after receiving the SMS
    // NOTE: add country code prefix
    String phone = "+86xxx";
    AuthResult result = await AuthClient.loginByPhoneCode(phone, "9130");
    expect(result.code, 200);
    expect(result.user.phone, phone);

    AuthResult result2 = await AuthClient.loginByPhoneCode(phone, "111111");
    expect(result2.code, 2001);
  });

  test('send sms', () async {
    String phone = "136";
    AuthResult result = await AuthClient.sendSms(phone, "+86");
    expect(result.code, 200);
  });

  test('send email', () async {
    String email = "your_email";
    AuthResult result = await AuthClient.sendEmail(email, "RESET_PASSWORD");
    expect(result.code, 200);
    result = await AuthClient.sendEmail(email, "VERIFY_EMAIL");
    expect(result.code, 200);
    result = await AuthClient.sendEmail(email, "CHANGE_EMAIL");
    expect(result.code, 200);
    result = await AuthClient.sendEmail(email, "MFA_VERIFY");
    expect(result.code, 200);
  });

  test('resetPasswordByPhoneCode', () async {
    String phone = "136";
    AuthResult result = await AuthClient.resetPasswordByPhoneCode(phone, "2613", "111111");
    expect(result.code, 200);

    AuthResult result2 = await AuthClient.loginByAccount(phone, "111111");
    expect(result2.code, 200);
    expect(result2.user.phone, phone);
  });

  test('resetPasswordByEmailCode', () async {
    String email = "x@gmail.com";
    AuthResult result = await AuthClient.resetPasswordByEmailCode(email, "6898", "111111");
    expect(result.code, 200);

    AuthResult result2 = await AuthClient.loginByAccount(email, "111111");
    expect(result2.code, 200);
    expect(result2.user.email, email);
  });
}
