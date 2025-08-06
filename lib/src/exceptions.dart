import 'mnemonic_length.dart';

abstract class MnemonicException implements Exception {
  final String message;

  MnemonicException(this.message);

  @override
  String toString() => message;
}

class MnemonicIndexesLengthException extends MnemonicException {
  MnemonicIndexesLengthException(int length)
      : super("Mnemonic indexes length $length is not valid");
}

class MnemonicUnexpectedEntropyLengthException extends MnemonicException {
  MnemonicUnexpectedEntropyLengthException(int length)
      : super(
            "Expect mnemonic [${MnemonicLength.availableBits.join(', ')}] entropy bits, got $length.");
}

class MnemonicUnexpectedSentenceLengthException extends MnemonicException {
  MnemonicUnexpectedSentenceLengthException(int length)
      : super(
            "Expect mnemonic [${MnemonicLength.availableWords.join(', ')}] words, got $length.");
}

class MnemonicWordNotFoundException extends MnemonicException {
  MnemonicWordNotFoundException(String word, String language)
      : super('Mnemonic word "$word" does not exist in $language');
}

class MnemonicInvalidChecksumException extends MnemonicException {
  MnemonicInvalidChecksumException(List<String> words)
      : super('Mnemonic checksum ${words.last} is invalid');
}
