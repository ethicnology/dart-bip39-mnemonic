import 'package:bip39_mnemonic/exports.dart';
import 'package:test/test.dart';
import 'package:convert/convert.dart';

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
  group('czech', () {
    var vector = vectors['czech']!;
    var language = Language.czech;
    test('Mnemonic.fromSentence', () {
      var mnemonic = Mnemonic.fromSentence(
        vector[0]['mnemonic']!,
        language,
      );
      expect(hex.encode(mnemonic.entropy), equals(vector[0]['entropy']!));
    });

    test('Mnemonic.toSeed', () {
      var mnemonic = Mnemonic(hex.decode(vector[0]['entropy']!), language);
      expect(
        hex.encode(mnemonic.toSeed(passphrase: "TREZOR")),
        equals(vector[0]['seed']!),
      );
    });

    test('Mnemonic.toSentence', () {
      List<int> bytes = hex.decode(vector[0]['entropy']!);
      var mnemonic = Mnemonic(bytes, language);
      var sentence = mnemonic.toSentence();
      expect(sentence, equals(vector[0]['mnemonic']!));
    });
  });

  group('korean', () {
    var vector = vectors['korean']!;
    var language = Language.korean;
    test('Mnemonic.fromSentence', () {
      var mnemonic = Mnemonic.fromSentence(
        vector[0]['mnemonic']!,
        language,
      );
      expect(hex.encode(mnemonic.entropy), equals(vector[0]['entropy']!));
    });

    test('Mnemonic.toSeed', () {
      var mnemonic = Mnemonic(hex.decode(vector[0]['entropy']!), language);
      expect(
        hex.encode(mnemonic.toSeed(passphrase: "TREZOR")),
        equals(vector[0]['seed']!),
      );
    });

    test('Mnemonic.toSentence', () {
      List<int> bytes = hex.decode(vector[0]['entropy']!);
      var mnemonic = Mnemonic(bytes, language);
      var sentence = mnemonic.toSentence();
      expect(sentence, equals(vector[0]['mnemonic']!));
    });
  });

  group('portuguese', () {
    var vector = vectors['portuguese']!;
    var language = Language.portuguese;
    test('Mnemonic.fromSentence', () {
      var mnemonic = Mnemonic.fromSentence(
        vector[0]['mnemonic']!,
        language,
      );
      expect(hex.encode(mnemonic.entropy), equals(vector[0]['entropy']!));
    });

    test('Mnemonic.toSeed', () {
      var mnemonic = Mnemonic(hex.decode(vector[0]['entropy']!), language);
      expect(
        hex.encode(mnemonic.toSeed(passphrase: "TREZOR")),
        equals(vector[0]['seed']!),
      );
    });

    test('Mnemonic.toSentence', () {
      List<int> bytes = hex.decode(vector[0]['entropy']!);
      var mnemonic = Mnemonic(bytes, language);
      var sentence = mnemonic.toSentence();
      expect(sentence, equals(vector[0]['mnemonic']!));
    });
  });
}
