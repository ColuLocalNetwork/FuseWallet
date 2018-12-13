import 'dart:async';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import "package:web3dart/src/utils/numbers.dart" as numbers;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

const String _ABI_EXTRACT = '[ { "constant": true, "inputs": [], "name": "name", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "_spender", "type": "address" }, { "name": "_value", "type": "uint256" } ], "name": "approve", "outputs": [ { "name": "success", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "totalSupply", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "_tokenContract", "type": "address" } ], "name": "withdrawAltcoinTokens", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_from", "type": "address" }, { "name": "_to", "type": "address" }, { "name": "_amount", "type": "uint256" } ], "name": "transferFrom", "outputs": [ { "name": "success", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "decimals", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [], "name": "withdraw", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_value", "type": "uint256" } ], "name": "burn", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_participant", "type": "address" }, { "name": "_amount", "type": "uint256" } ], "name": "adminClaimAirdrop", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_addresses", "type": "address[]" }, { "name": "_amount", "type": "uint256" } ], "name": "adminClaimAirdropMultiple", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [ { "name": "_owner", "type": "address" } ], "name": "balanceOf", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "symbol", "outputs": [ { "name": "", "type": "string" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [], "name": "finishDistribution", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_tokensPerEth", "type": "uint256" } ], "name": "updateTokensPerEth", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_to", "type": "address" }, { "name": "_amount", "type": "uint256" } ], "name": "transfer", "outputs": [ { "name": "success", "type": "bool" } ], "payable": true, "stateMutability": "payable", "type": "function" }, { "constant": false, "inputs": [], "name": "getTokens", "outputs": [], "payable": true, "stateMutability": "payable", "type": "function" }, { "constant": true, "inputs": [], "name": "minContribution", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "distributionFinished", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [ { "name": "tokenAddress", "type": "address" }, { "name": "who", "type": "address" } ], "name": "getTokenBalance", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "tokensPerEth", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [ { "name": "_owner", "type": "address" }, { "name": "_spender", "type": "address" } ], "name": "allowance", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "totalDistributed", "outputs": [ { "name": "", "type": "uint256" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "newOwner", "type": "address" } ], "name": "transferOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "payable": false, "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "_from", "type": "address" }, { "indexed": true, "name": "_to", "type": "address" }, { "indexed": false, "name": "_value", "type": "uint256" } ], "name": "Transfer", "type": "event", "stateMutability": "view" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "_owner", "type": "address" }, { "indexed": true, "name": "_spender", "type": "address" }, { "indexed": false, "name": "_value", "type": "uint256" } ], "name": "Approval", "type": "event", "stateMutability": "view" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "to", "type": "address" }, { "indexed": false, "name": "amount", "type": "uint256" } ], "name": "Distr", "type": "event", "stateMutability": "view" }, { "anonymous": false, "inputs": [], "name": "DistrFinished", "type": "event", "stateMutability": "view" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "_owner", "type": "address" }, { "indexed": false, "name": "_amount", "type": "uint256" }, { "indexed": false, "name": "_balance", "type": "uint256" } ], "name": "Airdrop", "type": "event", "stateMutability": "view" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "_tokensPerEth", "type": "uint256" } ], "name": "TokensPerEthUpdated", "type": "event", "stateMutability": "view" }, { "anonymous": false, "inputs": [ { "indexed": true, "name": "burner", "type": "address" }, { "indexed": false, "name": "value", "type": "uint256" } ], "name": "Burn", "type": "event", "stateMutability": "view" } ]';
//const String _URL = "http://etheth653-dns-reg1.westeurope.cloudapp.azure.com:8540";
const String _URL = "https://rpc.fuse.io";
//const String _Asset = "0xf386d8d1dc00749e50fe5b7fae185aff42f7f30f";
const String _Asset = "0x347d72b434959208d8f82f9cdc607bd98fc6a111";
final storage = new FlutterSecureStorage();

Future getBalance(address) async {
  var httpClient = new Client();
	var ethClient = new Web3Client(_URL, httpClient);
  var privateKey = await getPrivateKey();
	var credentials = Credentials.fromPrivateKeyHex(privateKey);
	var contractABI = ContractABI.parseFromJSON(_ABI_EXTRACT, "cln");
	var contract = new DeployedContract(contractABI, new EthereumAddress(_Asset), ethClient, credentials);

	var getFn = contract.findFunctionsByName("balanceOf").first;
  address = address.toString().replaceAll("ethereum:", "");
  var n = BigInt.parse(numbers.strip0x(address), radix: 16);
	var response = await new Transaction(keys: credentials, maximumGas: 0)
			.prepareForCall(contract, getFn, [n])
			.call(ethClient);
      
      //numbers.hexToInt(response.toString()) / BigInt.from(1000000000000000000);
  return response[0] / BigInt.from(1000000000000000000);
}

Future sendNIS(address, amount) async {
  var httpClient = new Client();
	var ethClient = new Web3Client(_URL, httpClient);
  var privateKey = await getPrivateKey();
	var credentials = Credentials.fromPrivateKeyHex(privateKey);
	var contractABI = ContractABI.parseFromJSON(_ABI_EXTRACT, "cln");
	var contract = new DeployedContract(contractABI, new EthereumAddress(_Asset), ethClient, credentials);

//, EtherAmount.fromUnitAndValue(EtherUnit.gwei, 1)
  var getKittyFn = contract.findFunctionsByName("transfer").first;
  address = cleanAddress(address);
  var n = BigInt.parse(numbers.strip0x(address), radix: 16);
	var kittenResponse = await new Transaction(keys: credentials, maximumGas: 10000000, gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 2))
    .prepareForPaymentCall(contract, getKittyFn, [n, BigInt.from(amount) * BigInt.from(1000000000000000000)], EtherAmount.fromUnitAndValue(EtherUnit.gwei, 2))
			.send(ethClient);
  print(kittenResponse);

  return true;
}

String cleanAddress(address) {
  address = address.toString().replaceAll("ethereum:", "");
  return address;
}

Future initWallet() async {
  var pk = await getPrivateKey();
  if (pk == "" || pk == null) {
    pk = await generatePrivateKey();
    setPrivateKey(pk);
  }
  return pk;
}

Future generatePrivateKey() async {
  var rng = new Random.secure();
  Credentials random = Credentials.createRandom(rng);
  return numbers.toHex(random.privateKey);
}

void setPrivateKey(pk) async {
  //final prefs = await SharedPreferences.getInstance();
  //prefs.setString("pk", pk);
  await storage.write(key: "pk", value: pk);
}

Future getPrivateKey() async {
  //final prefs = await SharedPreferences.getInstance();
  //return prefs.getString('pk') ?? "";
  return await storage.read(key: "pk");
}

Future getPublickKey() async {
  var privateKey = await getPrivateKey();
  var credentials = Credentials.fromPrivateKeyHex(privateKey);
  return credentials.address.hex;
}

Future<dynamic> getBalance2() async {
      String url =
          "http://etheth653-dns-reg1.westeurope.cloudapp.azure.com:8540";

      var body ='{ "jsonrpc":"2.0", "method": "eth_call", "params":[ { "to": "0x381ac27b55e0c30ed214ab560b1f73b921080c2c", "data": "0x5d1b45b5" } ], "id": 1  }';

      return await http.post(Uri.encodeFull(url), body: body, headers: {
        "Content-Type": "application/json"
      }).then((http.Response response) {
        //      print(response.body);
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }
        Map<String, dynamic> obj = json.decode(response.body);

        return numbers.hexToInt(obj["result"].toString()) /
            BigInt.from(1000000000000000000);
      });
    }