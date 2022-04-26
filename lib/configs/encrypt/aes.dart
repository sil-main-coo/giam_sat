import 'package:convert/convert.dart';
import 'package:encrypt/encrypt.dart';

class AESUtils {
  static const _aesKeyBytes = [
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

  static const _aesIVBytes = [
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

  static final String aesKey = hex.encode(_aesKeyBytes);
  static final String aesIVKey = hex.encode(_aesIVBytes);

  static final key = Key.fromBase16(aesKey);
  static final iv = IV.fromBase16(aesIVKey);

  static String encrypt(String plainText) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt('$plainText\$', iv: iv);
    return encrypted.base64;
  }

  static String decrypt(String encryptedText) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: null));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    final value = decrypted.split('\$');
    return value[0];
  }
}
