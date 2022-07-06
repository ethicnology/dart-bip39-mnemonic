import 'package:bip39_mnemonic/src/language.dart';

class Word {
  /// Validate a specific menmonic word
  static bool isValidWord(String word, Language language) {
    List<String> wordlist = language.list;
    return wordlist.contains(word);
  }
}
