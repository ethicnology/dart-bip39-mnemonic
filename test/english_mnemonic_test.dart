import 'package:bip39_mnemonic/exports.dart';
import 'package:test/test.dart';
import 'package:convert/convert.dart';
import 'vectors.dart';

void main() async {
  group('english', () {
    test('Mnemonic.fromSentence', () {
      var english = vectors['english']!;
      for (var i = 0; i < english.length; i++) {
        var mnemonic = Mnemonic.fromSentence(
          english[i]['mnemonic']!,
          Language.english,
        );
        expect(hex.encode(mnemonic.entropy), equals(english[i]['entropy']!));
      }
    });

    test('Mnemonic.toSeed', () {
      var english = vectors['english']!;
      for (var i = 0; i < english.length; i++) {
        List<int> bytes = hex.decode(english[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, Language.english);
        var seed = mnemonic.toSeed(passphrase: "TREZOR");
        expect(hex.encode(seed), equals(english[i]['seed']!));
      }
    });

    test('Mnemonic.toSentence', () {
      var english = vectors['english']!;
      for (var i = 0; i < english.length; i++) {
        List<int> bytes = hex.decode(english[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, Language.english);
        var sentence = mnemonic.toSentence();
        expect(sentence, equals(english[i]['mnemonic']!));
      }
    });
  });
}
