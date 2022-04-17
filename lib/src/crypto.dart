import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';

List<int> pbkdf2(String sentence, {String passphrase = ""}) {
  const blockLength = 128;
  const iterationCount = 2048;
  const desiredKeyLength = 64;
  final salt = Uint8List.fromList(utf8.encode("mnemonic" + passphrase));
  final derivator = PBKDF2KeyDerivator(HMac(SHA512Digest(), blockLength));
  derivator.reset();
  derivator.init(Pbkdf2Parameters(salt, iterationCount, desiredKeyLength));
  Uint8List result = derivator.process(Uint8List.fromList(sentence.codeUnits));
  return result.toList();
}

List<int> sha256(List<int> bytes) {
  final digest = SHA256Digest();
  Uint8List result = digest.process(Uint8List.fromList(bytes));
  return result.toList();
}
