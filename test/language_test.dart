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
}
