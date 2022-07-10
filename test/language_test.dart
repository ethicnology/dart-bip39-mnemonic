import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:test/test.dart';

List<String> languages = [
  'english',
  'french',
  'spanish',
  'italian',
  'portuguese',
  'czech',
  'korean',
  'chinese simplified',
  'chinese traditional',
  'japanese'
];

void main() {
  group('Language', () {
    test('labels', () {
      expect(Language.values.length, equals(languages.length));
      for (var i = 0; i < languages.length; i++) {
        expect(Language.values[i].label, equals(languages[i]));
      }
    });
  });

  group('isValid', () {
    test('check if word exists in a list', () {
      expect(Language.english.isValid('admit'), true);
    });

    test('check if word doesn\'t exist in a wrong list', () {
      expect(Language.simplifiedChinese.isValid('admit'), false);
    });

    test('check if word doesn\'t exist in a list', () {
      expect(Language.english.isValid('hey'), false);
    });

    // https://github.com/flutter/flutter/issues/104927#issuecomment-1141319254
    test('non NFKD formatted', () {
      expect(Language.french.isValid('échelle'), true); // non NFKD
    });

    test('NFKD formatted', () {
      expect(Language.french.isValid('échelle'), true); // NFKD
    });
  });
}
