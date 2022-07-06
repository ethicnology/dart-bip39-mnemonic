import 'package:bip39_mnemonic/src/language.dart';
import 'package:bip39_mnemonic/src/word.dart';
import 'package:test/test.dart';

void main() {
  group('Word', () {
    test('check if word exists in a list', () {
      expect(Word.isValidWord('admit', Language.english), true);
    });

    test('check if word doesn\'t exist in a wrong list', () {
      expect(Word.isValidWord('admit', Language.simplifiedChinese), false);
    });

    test('check if word doesn\'t exist in a list', () {
      expect(Word.isValidWord('hey', Language.english), false);
    });
  });
}
