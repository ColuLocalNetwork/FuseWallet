import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
    String privatekey = await getPrivateKey();
    String mnemonic = await getMnemonic();
    if (!await hasPrivateKey()) {
      String mnemonic = generateMnemonic();
      await setMnemonic(mnemonic);

      //privatekey = getPrivateKeyFromMnemonic(mnemonic);
      privatekey = await compute(getPrivateKeyFromMnemonic, mnemonic);
      
      
      setPrivateKey(privatekey);

      //Call funder
      var publicKey = await getPublickKey();
      print('Calling funder with address: $publicKey');
      callFunder(publicKey);
    }
    return privatekey;
  }

  static Future<void> setMnemonic(mnemonic) async {
    String privatekey = await compute(getPrivateKeyFromMnemonic, mnemonic);
    setPrivateKey(privatekey);
    await storage.write(key: "mnemonic", value: mnemonic);
  }

  static Future<String> getMnemonic() async {
    return await storage.read(key: "mnemonic");
  }

  static hasPrivateKey() async {
    String privatekey = await getPrivateKey();
    String mnemonic = await getMnemonic();
    if (privatekey == null || privatekey.isEmpty || mnemonic == null || mnemonic.isEmpty) {
      return false;
    }
    return true;
  }

  static isLogged() async {
    //FirebaseUser user = await FirebaseAuth.instance.currentUser();
    //if (user == null || !await hasPrivateKey()) {
    if (!await hasPrivateKey()) {
      return false;
    } else {
      return true;
    }

    /*
    var phone = await storage.read(key: "phone") ?? "";
    if (phone.isEmpty) {
      return false;
    } else {
      return true;
    }
    */
  }

}
