abstract class MnemonicException implements Exception {
  final String message;

  MnemonicException(this.message);

  @override
  String toString() => 'MnemonicException: $message';
}

class MnemonicIndexesLengthException extends MnemonicException {
  MnemonicIndexesLengthException(int length)
      : super("MnemonicException: indexes length $length is not valid");
}

class MnemonicUnexpectedInitialEntropyLengthException
    extends MnemonicException {
  MnemonicUnexpectedInitialEntropyLengthException(int length)
      : super("MnemonicException: unexpected initial entropy length $length");
}

class MnemonicUnexpectedEntropyLengthException extends MnemonicException {
  MnemonicUnexpectedEntropyLengthException(int length)
      : super(
      "MnemonicException: unexpected entropy length, choose one of: [128, 160, 192, 224, 256] but got $length");
}

class MnemonicWordNotFoundException extends MnemonicException {
  MnemonicWordNotFoundException(String word, String language)
      : super('mnemonic: "$word" does not exist in $language');
}

class MnemonicUnexpectedSentenceLengthException extends MnemonicException {
  MnemonicUnexpectedSentenceLengthException(int length)
      : super("mnemonic: unexpected sentence length: $length");
}

class MnemonicInvalidChecksumException extends MnemonicException {
  MnemonicInvalidChecksumException(String sentence)
      : super('mnemonic: invalid checksum for sentence: "$sentence"');
}