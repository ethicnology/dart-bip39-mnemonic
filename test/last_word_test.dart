import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:test/test.dart';

/// Brute force reference: keeps every word of the wordlist rebuilding a valid
/// sentence once appended to [words].
List<String> bruteForce(List<String> words, Language language) {
  List<String> result = [];
  for (final word in language.list) {
    try {
      Mnemonic.fromWords(words: [...words, word], language: language);
      result.add(word);
    } on MnemonicInvalidChecksumException {
      continue;
    }
  }
  return result;
}

void main() {
  group('Mnemonic.lastWordCandidates', () {
    test('returns 2^(11 - CS) distinct words for every length', () {
      for (final length in MnemonicLength.values) {
        final mnemonic = Mnemonic.generate(Language.english, length: length);
        final partial = mnemonic.words.sublist(0, length.words - 1);
        final candidates = Mnemonic.lastWordCandidates(words: partial);

        expect(candidates.length, equals(1 << (11 - length.checksum)));
        expect(candidates.toSet().length, equals(candidates.length));
      }
    });

    test('always contains the word of the original sentence', () {
      for (final length in MnemonicLength.values) {
        for (var i = 0; i < 10; i++) {
          final mnemonic = Mnemonic.generate(Language.english, length: length);
          final partial = mnemonic.words.sublist(0, length.words - 1);
          expect(
            Mnemonic.lastWordCandidates(words: partial),
            contains(mnemonic.words.last),
          );
        }
      }
    });

    test('every candidate rebuilds a sentence with a valid checksum', () {
      for (final length in MnemonicLength.values) {
        final mnemonic = Mnemonic.generate(Language.english, length: length);
        final partial = mnemonic.words.sublist(0, length.words - 1);
        for (final word in Mnemonic.lastWordCandidates(words: partial)) {
          expect(
            Mnemonic.fromWords(words: [...partial, word]).words.last,
            equals(word),
          );
        }
      }
    });

    test('matches an exhaustive search over the wordlist, 12 words', () {
      final partial =
          Mnemonic.generate(Language.english, length: MnemonicLength.words12)
              .words
              .sublist(0, 11);
      expect(
        Mnemonic.lastWordCandidates(words: partial),
        unorderedEquals(bruteForce(partial, Language.english)),
      );
    });

    test('matches an exhaustive search over the wordlist, 24 words', () {
      final partial =
          Mnemonic.generate(Language.english, length: MnemonicLength.words24)
              .words
              .sublist(0, 23);
      expect(
        Mnemonic.lastWordCandidates(words: partial),
        unorderedEquals(bruteForce(partial, Language.english)),
      );
    });

    test('zero entropy vector, 12 words', () {
      final candidates = Mnemonic.lastWordCandidates(
        words: List.filled(11, 'abandon'),
      );
      expect(candidates.length, equals(128));
      expect(candidates.first, equals('about'));
      expect(
        Mnemonic.fromWords(words: [...List.filled(11, 'abandon'), 'about'])
            .entropy,
        equals(List.filled(16, 0)),
      );
    });

    test('zero entropy vector, 24 words', () {
      final candidates = Mnemonic.lastWordCandidates(
        words: List.filled(23, 'abandon'),
      );
      expect(candidates.length, equals(8));
      expect(candidates.first, equals('art'));
      expect(
        Mnemonic.fromWords(words: [...List.filled(23, 'abandon'), 'art'])
            .entropy,
        equals(List.filled(32, 0)),
      );
    });

    test('supports every language', () {
      for (final language in Language.values) {
        final mnemonic =
            Mnemonic.generate(language, length: MnemonicLength.words24);
        final partial = mnemonic.words.sublist(0, 23);
        final candidates =
            Mnemonic.lastWordCandidates(words: partial, language: language);

        expect(candidates.length, equals(8));
        expect(candidates, contains(mnemonic.words.last));
      }
    });

    test('normalizes non NFKD words', () {
      const partial = [
        "insecte", "pirogue", "tamiser", "goudron", "torpille", "rejouer", //
        "essieu", "lactose", "bouquin", "humble", "service", "dauphin",
        "gendarme", "fougère", "visqueux", "essence", "projeter", "thème",
        "éruption", "chausson", "incliner", "plastron", "bambin",
      ];
      final candidates = Mnemonic.lastWordCandidates(
        words: partial,
        language: Language.french,
      );
      expect(candidates.length, equals(8));
      expect(candidates, contains('boiser'));
    });

    test('accepts a supported length minus one word only', () {
      final supported = MnemonicLength.availablePartialWords;
      expect(supported, equals([11, 14, 17, 20, 23]));

      for (var count = 0; count <= 32; count++) {
        final words = List.filled(count, 'abandon');
        if (supported.contains(count)) {
          expect(
            Mnemonic.lastWordCandidates(words: words),
            isNotEmpty,
            reason: '$count words should be accepted',
          );
        } else {
          expect(
            () => Mnemonic.lastWordCandidates(words: words),
            throwsA(isA<MnemonicUnexpectedPartialSentenceLengthException>()),
            reason: '$count words should be rejected',
          );
        }
      }
    });

    test('reports the received word count in the error message', () {
      expect(
        () => Mnemonic.lastWordCandidates(words: List.filled(12, 'abandon')),
        throwsA(
          isA<MnemonicUnexpectedPartialSentenceLengthException>().having(
            (e) => e.message,
            'message',
            allOf(contains('11, 14, 17, 20, 23'), contains('got 12')),
          ),
        ),
      );
    });

    test('rejects a foreign word', () {
      expect(
        () => Mnemonic.lastWordCandidates(
          words: [...List.filled(10, 'abandon'), 'esperanto'],
        ),
        throwsA(isA<MnemonicWordNotFoundException>()),
      );
    });
  });
}
