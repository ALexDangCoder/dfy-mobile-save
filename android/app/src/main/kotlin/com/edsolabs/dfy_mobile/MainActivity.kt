package com.edsolabs.dfy_mobile

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import wallet.core.jni.AnyAddress
import wallet.core.jni.CoinType
import wallet.core.jni.HDWallet
import kotlin.experimental.and

class MainActivity : FlutterFragmentActivity() {
    init {
        System.loadLibrary("TrustWalletCore")
    }

    private val TYPE_WALLET_SEED_PHRASE = "PASS_PHRASE"
    private val TYPE_WALLET_PRIVATE_KEY = "PRIVATE_KEY"
    private val CHANNEL_TRUST_WALLET = "flutter/trust_wallet"
    private var channel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_TRUST_WALLET)
        channel?.setMethodCallHandler { call, _ ->
            when (call.method) {
                "checkPassword" -> {
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    checkPassWordWallet(password)

                }
                "getConfig" -> {
                    getConfigWallet()
                }
                //todo 1
                "importWallet" -> {
                    val type = call.argument<String>("type") ?: return@setMethodCallHandler
                    val content = call.argument<String>("content")
                        ?: return@setMethodCallHandler
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    importWallet(type, content, password)
                }
                "getListWallets" -> {
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    getListWallets(password)
                }
                "generateWallet" -> {
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    generateWallet(password)
                }
                "storeWallet" -> {
                    val seedPhrase =
                        call.argument<String>("seedPhrase") ?: return@setMethodCallHandler
                    val walletName =
                        call.argument<String>("walletName") ?: return@setMethodCallHandler
                    val storeWallet =
                        call.argument<String>("storeWallet") ?: return@setMethodCallHandler
                    storeWallet(seedPhrase, walletName, storeWallet)
                }
                "setConfig" -> {
                    val isAppLock =
                        call.argument<Boolean>("isAppLock") ?: return@setMethodCallHandler
                    val isFaceID =
                        call.argument<Boolean>("isFaceID") ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: return@setMethodCallHandler
                    setConfig(isAppLock, isFaceID, password)
                }
                "getListShowedToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: return@setMethodCallHandler
                    getListShowedToken(walletAddress, password)
                }
                "getListShowedNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: return@setMethodCallHandler
                    getListShowedNft(walletAddress, password)
                }
                "importToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress") ?: return@setMethodCallHandler
                    val symbol =
                        call.argument<String>("symbol") ?: return@setMethodCallHandler
                    val decimal =
                        call.argument<Int>("decimal") ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: return@setMethodCallHandler
                    importToken(walletAddress, tokenAddress, symbol, decimal, password)
                }
                "getListSupportedToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: return@setMethodCallHandler
                    getListSupportedToken(walletAddress, password)
                }
                "sendToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val receiveAddress =
                        call.argument<String>("receiveAddress") ?: return@setMethodCallHandler
                    val tokenID =
                        call.argument<Int>("tokenID") ?: return@setMethodCallHandler
                    val amount =
                        call.argument<Int>("amount") ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: return@setMethodCallHandler
                    sendToken(walletAddress, receiveAddress, tokenID, amount, password)
                }

                "sendNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val receiveAddress =
                        call.argument<String>("receiveAddress") ?: return@setMethodCallHandler
                    val nftID =
                        call.argument<Int>("nftID") ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: return@setMethodCallHandler
                    sendNft(walletAddress, receiveAddress, nftID, password)
                }
            }
        }
    }

    private fun checkPassWordWallet(password: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        hasMap["isCorrect"] = password.isNotEmpty()
        channel?.invokeMethod("checkPasswordCallback", hasMap)
    }

    private fun getConfigWallet() {
        //todo
        val hasMap = HashMap<String, Boolean>()
        hasMap["isAppLock"] = true
        hasMap["isFaceID"] = true
        channel?.invokeMethod("getConfigCallback", hasMap)
    }

    private fun importWallet(type: String, content: String, password: String) {
        val hasMap = HashMap<String, String>()
        //todo validate content
        if (type == TYPE_WALLET_SEED_PHRASE) {
            //todo content is seed phrase
            val wallet = HDWallet(content, "")
            val coinType: CoinType = CoinType.SMARTCHAIN
            val address = wallet.getAddressForCoin(coinType)
            hasMap["walletAddress"] = address
        } else if (type == TYPE_WALLET_PRIVATE_KEY) {
            //todo content is private key
            val wallet = HDWallet(content, "")
            val privateKey = wallet.getKeyForCoin(CoinType.SMARTCHAIN)
            val publicKeyFalse = privateKey.getPublicKeySecp256k1(false)
            val anyAddress = AnyAddress(publicKeyFalse, CoinType.SMARTCHAIN)
            val address = anyAddress.data().toHexString()
            hasMap["walletAddress"] = address
// address = 0xa3dcd899c0f3832dfdfed9479a9d828c6a4eb2a7    it does not has EIP55 address
        } else {
            return
        }
        //todo check count wallet -> walletName = wallet count + 1
        hasMap["walletName"] = "walletName"
        channel?.invokeMethod("importWalletCallback", hasMap)
    }

    private fun getListWallets(password: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        channel?.invokeMethod("getListWalletsCallback", hasMap)
    }

    private fun generateWallet(password: String) {
        //todo
        val hasMap = HashMap<String, String>()
        hasMap["walletAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        hasMap["privateKey"] = "e507e499158b5b6e1a89ad1e65250f6c38a28d455c37cf23c41f4bdd82436e5a"
        hasMap["passPhrase"] =
            "party response give dove tooth master flip video permit game expire token"
        channel?.invokeMethod("generateWalletCallback", hasMap)
    }

    private fun storeWallet(seedPhrase: String, walletName: String, storeWallet: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("storeWalletCallback", hasMap)
    }

    private fun setConfig(appLock: Boolean, faceID: Boolean, password: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("setConfigCallback", hasMap)
    }

    private fun getListShowedToken(walletAddress: String, password: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        channel?.invokeMethod("getListShowedTokenCallback", hasMap)
    }

    private fun getListShowedNft(walletAddress: String, password: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        channel?.invokeMethod("getListShowedNftCallback", hasMap)
    }

    private fun importToken(
        walletAddress: String,
        tokenAddress: String,
        symbol: String,
        decimal: Int,
        password: String
    ) {
        //todo
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("importTokenCallback", hasMap)
    }

    private fun getListSupportedToken(walletAddress: String, password: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        channel?.invokeMethod("getListSupportedTokenCallback", hasMap)
    }

    private fun sendToken(
        walletAddress: String,
        receiveAddress: String,
        tokenID: Int,
        amount: Int,
        password: String
    ) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("sendTokenCallback", hasMap)
    }

    private fun sendNft(
        walletAddress: String,
        receiveAddress: String,
        nftID: Int,
        password: String
    ) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("sendNftCallback", hasMap)
    }

    private fun genAddressBySeedPhrase(seedPhrase: String, coinType: CoinType): String {
        val wallet = HDWallet(seedPhrase, "")
        return wallet.getAddressForCoin(coinType)
    }

    private fun genAddressByPrivateKey(privateKey: String, coinType: CoinType): String {
        return ""
    }
}

fun ByteArray.toHexString(withPrefix: Boolean = true): String {
    val stringBuilder = StringBuilder()
    if (withPrefix) {
        stringBuilder.append("0x")
    }
    for (element in this) {
        stringBuilder.append(String.format("%02x", element and 0xFF.toByte()))
    }
    return stringBuilder.toString()
}