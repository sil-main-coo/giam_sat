// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/export.dart';

void main() {
  test("test AES", () async {
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

    String aesKey = hex.encode(aesKeyBytes);
    String aesIVKey = hex.encode(aesIVBytes);

    final key = encrypt.Key.fromBase16(aesKey);
    final iv = encrypt.IV.fromBase16(aesIVKey);

    print('Key: ${key.base16}');
    print('iv: ${iv.base16}');

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final plainText = 'off1\$';

    final encrypted = encrypter.encrypt(
        plainText,
        iv: iv);
    final encryptText = encrypted.base64;
    print(encryptText);

    final encrypter11 = Encrypter(AES(key, mode: AESMode.cbc, padding: null));
    final decrypted = encrypter11.decrypt64(encryptText, iv: iv);
    // print(decrypted.codeUnits);
    print(decrypted);
    final value = decrypted.split('\$');
    print(value[0]);
    // print(hex.decode(aesKeyBytes));

    // final arduinoEncrypted = 'bkGYcphTyuT8q0RM9ZEYr2246PemZffBwSotkEvep4psoGeC9NceTqSpA3Z8zHozPFDGQ1eZqXSbXlTp7y3Xrg';
    // final encrypter1 = Encrypter(AES(key, mode: AESMode.cbc, ));
    //
    // final decrypted1 = encrypter1.decrypt64(arduinoEncrypted, iv: iv);
    //
    // print(decrypted1);
  });
}
