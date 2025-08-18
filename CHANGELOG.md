## 4.0.1

- refactor: use hyphens in chinese labels instead of spaces to align with rust bip39 names in bip85

## 4.0.0

- the `entropyLength` parameter was replaced with the `length` parameter in `Mnemonic.generate()`.

**Before**
```dart
final mnemonic = Mnemonic.generate(
  Language.french,
  passphrase: "SomethingR0bùst", 
  entropyLength: 256,  // ❌ This parameter no longer exists
);
```

**After**
```dart
final mnemonic = Mnemonic.generate(
  Language.french,
  passphrase: "SomethingR0bùst",
  length: MnemonicLength.words24,  // ✅ New enum-based parameter
);
```

## 3.0.10

- feat: add mnemonic exception classes for better error handling

## 3.0.9

- Allow pointycastle v3 as well

## 3.0.8

- Mnemonic.fromWords with unit tests
- Update documentation
- Upgrade pointycastle v4.0.0
- Switch License GPL to MIT

## 3.0.7

- Upgrade dependencies

## 3.0.6

- Update Pointycastle dependency

## 3.0.5

- Mnemonic.generate has a new entropyLength params
- Update dependencies
- Update github actions

## 3.0.4

- Mnemonic.fromSentence formats (NFKD) each words before checking their validity

## 3.0.3

- isValid function formats input (NFKD)

## 3.0.2

- Add a method to validate a specific mnemonic word

## 3.0.1

- README update

## 3.0.0

-  Language enum reorder, english on top to encourage users to use english mnemonic. 
- label is no longer private (in case user want to change language label)
- passphrase is now a attribute of Mnemonic class Mnemonic.
- seed replace Mnemonic.toSeed(passphrase)
- tests update -> 100% coverage

## 2.2.0

- Revert "refactor: language enum enhanced, wordlists .dart -> .txt" from 2.1.0
- refactor: language enum is still enhanced but file based wordlist are removed in favor of RAM loaded. 
- Introducing label attribute for Language enum.  

## 2.1.0

- Upgrade dart SDK 2.17.0
- refactor: language enum enhanced, wordlists .dart -> .txt
- fix: Enhanced enum with field 'name' causes segfault
- Thanks to this refactoring this package consume less RAM by loading only needed worlist. 

## 2.0.2

- Downgrad dart SDK 2.17.1 -> 2.16.1

## 2.0.1

- Upgrade dependencies
- Upgrade dart SDK 2.17.1
- Reverted language enum refactoring (file based wordlists introduce async with too much edge effect).

## 2.0.0

- Japanese supports (ideographic space, NKDF normalization)
- Mnemonic.toSentence -> Mnemonic.sentence 

## 1.0.1

- Rename exports.dart -> bip39_mnemonic.dart.

## 1.0.0

- Initial version.
