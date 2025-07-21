import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:test/test.dart';

Map<String, List<Map<String, String>>> vectors = {
  "czech": [
    {
      "entropy": "00000000000000000000000000000000",
      "mnemonic":
      "abdikace abdikace abdikace abdikace abdikace abdikace abdikace abdikace abdikace abdikace abdikace agrese",
      "passphrase": "TREZOR",
      "seed":
      "872501bed75c98fbf943a67907bf394995f337e9adfa23687282d1135c262421715a0bcccfe2d3f5f8b72c8e2fa12a7a7267f8047b744557f4a9d49d11ccc75f"
    },
  ],
  "korean": [
    {
      "entropy": "00000000000000000000000000000000",
      "mnemonic":
      "가격 가격 가격 가격 가격 가격 가격 가격 가격 가격 가격 가능",
      "passphrase": "TREZOR",
      "seed":
      "a253d07f616223e337b6fa257632a2cc37e1ba36ff0bc7cf5a943366fa1b9ef02d6aa0333da51c17902951634b8aa81b6692a194b07f4f8c542335d73c96aad3"
    },
  ],
  "portuguese": [
    {
      "entropy": "00000000000000000000000000000000",
      "mnemonic":
      "abacate abacate abacate abacate abacate abacate abacate abacate abacate abacate abacate abater",
      "passphrase": "TREZOR",
      "seed":
      "ab9742b024a1e8bd241b76f8b3a157e9d442da60277bc8f36b8b23afe163de79414fb49fd1a8dd26f4ea7f0dc965c760b3b80727557bdca61e1f0b0f069952f2"
    },
  ]
};

void main() {
  group('Mnemonic constructors', () {
    test('Mnemonic default constructor', () {
      expect(() => Mnemonic([0], Language.french),
          throwsA(isA<MnemonicUnexpectedInitialEntropyLengthException>()));
    });

    test('Mnemonic.generate', () {
      var mnemonic = Mnemonic.generate(Language.french);
      expect(
        mnemonic.entropy.length,
        equals(32), // 256 bits
      );
    });

    test('Mnemonic.generate from invalid entropy length', () {
      expect(
            () => Mnemonic.generate(Language.french, entropyLength: 64),
        throwsA(isA<MnemonicUnexpectedEntropyLengthException>()),
      );
    });

    test('Mnemonic.fromSentence foreign word', () {
      String sentence =
          "esperanto 가격 가격 가격 가격 가격 가격 가격 가격 가격 가격 가능";
      expect(
            () => Mnemonic.fromSentence(sentence, Language.korean),
        throwsA(isA<MnemonicWordNotFoundException>()),
      );
    });

    test('Mnemonic.fromSentence unexpected sentence length', () {
      String sentence =
          "가격 가격 가격 가격 가격 가격 가격 가격 가격 가격 가격 가격 가능";
      expect(
            () => Mnemonic.fromSentence(sentence, Language.korean),
        throwsA(isA<MnemonicUnexpectedSentenceLengthException>()),
      );
    });

    test('Mnemonic.fromSentence invalid checksum', () {
      String sentence =
          "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon";
      expect(
            () => Mnemonic.fromSentence(sentence, Language.english),
        throwsA(isA<MnemonicInvalidChecksumException>()),
      );
    });

    test(
        'Mnemonic.fromSentence with non NFKD words will format them anyway, fougère',
            () {
          String sentence =
              "insecte pirogue tamiser goudron torpille rejouer essieu lactose bouquin humble service dauphin gendarme fougère visqueux essence projeter thème éruption chausson incliner plastron bambin boiser";
          var mnemonic = Mnemonic.fromSentence(sentence, Language.french);
          expect(mnemonic.words[13] == 'fougère', false);
        });
  });
}

