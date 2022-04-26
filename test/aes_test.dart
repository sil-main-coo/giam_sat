// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart' as aes;

void main() {
  test("test AES 1", () async {
    final aesKeyBytes = [
      0x04,
      0x0B,
      0x04,
      0x05,
      0x05,
      0x09,
      0x04,
      0x07,
      0x05,
      0x05,
      0x05,
      0x02,
      0x05,
      0x05,
      0x01,
      0x00
    ];

    final aesIVBytes = [
      0x04,
      0x0B,
      0x04,
      0x05,
      0x05,
      0x09,
      0x04,
      0x07,
      0x05,
      0x05,
      0x05,
      0x02,
      0x05,
      0x05,
      0x01,
      0x00
    ];

    final encrypted = '2pwNL+l+gXEjJrmizNKN7f22QqDd59FdhrOBg53lgEJQnY+TGTyoSmxAV2uSAHiHPTjNqaMPBrEiYV5CKxZr91maQeJudmOqUxJMH8aulyw=';

    String aesKey = hex.encode(aesKeyBytes);
    String aesIVKey = hex.encode(aesIVBytes);

    // String data = decryptAESCryptoJS(encrypted, aesIVKey);
    //
    // print('data: $data');

    final key = aes.Key.fromBase16(aesKey);
    final iv = aes.IV.fromBase16(aesIVKey);

    final encrypter =
        aes.Encrypter(aes.AES(key, mode: aes.AESMode.cbc,
            padding: null
        ));

    final decrypted = encrypter.decrypt64(encrypted, iv: iv);
    print(decrypted.codeUnits);
    print(decrypted.trim());

    final value = decrypted.split('\$');
    print(value[0]);
  });
}