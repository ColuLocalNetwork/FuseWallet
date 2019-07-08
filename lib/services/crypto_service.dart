import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';

String generateMnemonic() {
  return bip39.generateMnemonic();
}

Future getPublickKey(privateKey) async {
  if (privateKey == null) {
    return "";
  }
  var credentials = Credentials.fromPrivateKeyHex(privateKey);
  return credentials.address.hex;
}

String getPrivateKeyFromMnemonic(mnemonic) {
  String seed = bip39.mnemonicToSeedHex(mnemonic);
  bip32.BIP32 root = bip32.BIP32.fromSeed(HEX.decode(seed));
  bip32.BIP32 child = root.derivePath("m/44'/60'/0'/0/0");
  String privateKey = HEX.encode(child.privateKey);
  return privateKey;
}