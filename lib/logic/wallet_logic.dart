import 'package:fusewallet/logic/crypto.dart';

class WalletLogic {

/*
  static init() async {

    var walletMnemonic = await getWallet();

    if ((walletMnemonic ?? "") == "") {
      walletMnemonic = generateMnemonic();
      setWallet(walletMnemonic);
    }

  }

  static Future<String> getWallet() async {
    return await storage.read(key: "walletMnemonic");
  }

  static setWallet(walletMnemonic) async {
    await storage.write(key: "walletMnemonic", value: walletMnemonic);
  }
*/

  static Future init() async {
    var pk = await getPrivateKey();
    if (pk == "" || pk == null) {
      String mnemonic = generateMnemonic();
      await setMnemonic(mnemonic);
      pk = getPrivateKeyFromMnemonic(mnemonic);

      //Call funder
      var publicKey = await getPublickKey();
      await callFunder(publicKey);
    }
    return pk;
  }

  static Future<void> setMnemonic(mnemonic) async {
    await storage.write(key: "mnemonic", value: mnemonic);
  }

  static Future<String> getMnemonic() async {
    return await storage.read(key: "mnemonic");
  }

  static isLogged() async {
    var phone = await storage.read(key: "phone") ?? "";
    if (phone.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

}
