import 'package:bip39_mnemonic/exports.dart';
import 'package:test/test.dart';
import 'package:convert/convert.dart';

import 'vectors.dart';

void main() async {
  group('english', () {
    var vector = vectors['english']!;
    var language = Language.english;
    test('Mnemonic.fromSentence', () {
      for (var i = 0; i < vector.length; i++) {
        var mnemonic = Mnemonic.fromSentence(
          vector[i]['mnemonic']!,
          language,
        );
        expect(hex.encode(mnemonic.entropy), equals(vector[i]['entropy']!));
      }
    });

    test('Mnemonic.toSeed', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var seed = mnemonic.toSeed(passphrase: "TREZOR");
        expect(hex.encode(seed), equals(vector[i]['seed']!));
      }
    });

    test('Mnemonic.toSentence', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var sentence = mnemonic.toSentence();
        expect(sentence, equals(vector[i]['mnemonic']!));
      }
    });
  });

  group('french', () {
    var vector = vectors['french']!;
    var language = Language.french;
    test('Mnemonic.fromSentence', () {
      for (var i = 0; i < vector.length; i++) {
        var mnemonic = Mnemonic.fromSentence(
          vector[i]['mnemonic']!,
          language,
        );
        expect(hex.encode(mnemonic.entropy), equals(vector[i]['entropy']!));
      }
    });

    test('Mnemonic.toSeed', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var seed = mnemonic.toSeed(passphrase: "TREZOR");
        expect(hex.encode(seed), equals(vector[i]['seed']!));
      }
    });

    test('Mnemonic.toSentence', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var sentence = mnemonic.toSentence();
        expect(sentence, equals(vector[i]['mnemonic']!));
      }
    });
  });

  group('spanish', () {
    var vector = vectors['spanish']!;
    var language = Language.spanish;
    test('Mnemonic.fromSentence', () {
      for (var i = 0; i < vector.length; i++) {
        var mnemonic = Mnemonic.fromSentence(
          vector[i]['mnemonic']!,
          language,
        );
        expect(hex.encode(mnemonic.entropy), equals(vector[i]['entropy']!));
      }
    });

    test('Mnemonic.toSeed', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var seed = mnemonic.toSeed(passphrase: "TREZOR");
        expect(hex.encode(seed), equals(vector[i]['seed']!));
      }
    });

    test('Mnemonic.toSentence', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var sentence = mnemonic.toSentence();
        expect(sentence, equals(vector[i]['mnemonic']!));
      }
    });
  });

  group('italian', () {
    var vector = vectors['italian']!;
    var language = Language.italian;
    test('Mnemonic.fromSentence', () {
      for (var i = 0; i < vector.length; i++) {
        var mnemonic = Mnemonic.fromSentence(
          vector[i]['mnemonic']!,
          language,
        );
        expect(hex.encode(mnemonic.entropy), equals(vector[i]['entropy']!));
      }
    });

    test('Mnemonic.toSeed', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var seed = mnemonic.toSeed(passphrase: "TREZOR");
        expect(hex.encode(seed), equals(vector[i]['seed']!));
      }
    });

    test('Mnemonic.toSentence', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var sentence = mnemonic.toSentence();
        expect(sentence, equals(vector[i]['mnemonic']!));
      }
    });
  });

  group('chinese traditional', () {
    var vector = vectors['chinese_traditional']!;
    var language = Language.traditionalChinese;
    test('Mnemonic.fromSentence', () {
      for (var i = 0; i < vector.length; i++) {
        var mnemonic = Mnemonic.fromSentence(
          vector[i]['mnemonic']!,
          language,
        );
        expect(hex.encode(mnemonic.entropy), equals(vector[i]['entropy']!));
      }
    });

    test('Mnemonic.toSeed', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var seed = mnemonic.toSeed(passphrase: "TREZOR");
        expect(hex.encode(seed), equals(vector[i]['seed']!));
      }
    });

    test('Mnemonic.toSentence', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var sentence = mnemonic.toSentence();
        expect(sentence, equals(vector[i]['mnemonic']!));
      }
    });
  });

  group('chinese simplified', () {
    var vector = vectors['chinese_simplified']!;
    var language = Language.simplifiedChinese;
    test('Mnemonic.fromSentence', () {
      for (var i = 0; i < vector.length; i++) {
        var mnemonic = Mnemonic.fromSentence(
          vector[i]['mnemonic']!,
          language,
        );
        expect(hex.encode(mnemonic.entropy), equals(vector[i]['entropy']!));
      }
    });

    test('Mnemonic.toSeed', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var seed = mnemonic.toSeed(passphrase: "TREZOR");
        expect(hex.encode(seed), equals(vector[i]['seed']!));
      }
    });

    test('Mnemonic.toSentence', () {
      for (var i = 0; i < vector.length; i++) {
        List<int> bytes = hex.decode(vector[i]['entropy']!);
        var mnemonic = Mnemonic(bytes, language);
        var sentence = mnemonic.toSentence();
        expect(sentence, equals(vector[i]['mnemonic']!));
      }
    });
  });
}
