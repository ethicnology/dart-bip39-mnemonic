import 'exceptions.dart';

enum MnemonicLength {
  words12(entropy: 128, words: 12, checksum: 4),
  words15(entropy: 160, words: 15, checksum: 5),
  words18(entropy: 192, words: 18, checksum: 6),
  words21(entropy: 224, words: 21, checksum: 7),
  words24(entropy: 256, words: 24, checksum: 8);

  const MnemonicLength(
      {required this.entropy, required this.words, required this.checksum});

  final int entropy;
  final int words;
  final int checksum;

  int get bytes => entropy ~/ 8;
  static List<int> get availableBits => values.map((e) => e.entropy).toList();
  static List<int> get availableWords => values.map((e) => e.words).toList();

  static MnemonicLength fromEntropy(int entropy) {
    try {
      return values.firstWhere((e) => e.entropy == entropy);
    } catch (e) {
      throw MnemonicUnexpectedEntropyLengthException(entropy);
    }
  }

  static MnemonicLength fromWords(int wordCount) {
    try {
      return values.firstWhere((e) => e.words == wordCount);
    } catch (e) {
      throw MnemonicUnexpectedSentenceLengthException(wordCount);
    }
  }
}
