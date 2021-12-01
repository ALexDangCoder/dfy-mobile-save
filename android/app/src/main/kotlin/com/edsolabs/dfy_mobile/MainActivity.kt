package com.edsolabs.dfy_mobile

import com.google.protobuf.ByteString
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import wallet.core.java.AnySigner
import wallet.core.jni.CoinType
import wallet.core.jni.HDWallet
import wallet.core.jni.proto.Binance
import kotlin.experimental.and

class MainActivity : FlutterFragmentActivity() {
    init {
        System.loadLibrary("TrustWalletCore")
    }

    private val TYPE_WALLET_SEED_PHRASE = "PASS_PHRASE"
    private val TYPE_WALLET_PRIVATE_KEY = "PRIVATE_KEY"

    private val TYPE_DELETE_WALLET_IMPORT = "IMPORT"
    private val TYPE_DELETE_WALLET_CREATE = "CREATE"

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
                "earseWallet" -> {
                    val type = call.argument<String>("type") ?: return@setMethodCallHandler
                    earseWallet(type)
                }
                "importWallet" -> {
                    val type = call.argument<String>("type") ?: return@setMethodCallHandler
                    val content = call.argument<String>("content")
                        ?: return@setMethodCallHandler
                    val password = call.argument<String>("password")
                        ?: ""
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
                    val password =
                        call.argument<String>("password") ?: ""
                    storeWallet(seedPhrase, walletName, password)
                }
                "setConfig" -> {
                    val isAppLock =
                        call.argument<Boolean>("isAppLock") ?: false
                    val isFaceID =
                        call.argument<Boolean>("isFaceID") ?: false
                    val password =
                        call.argument<String>("password") ?: ""
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
                        call.argument<String>("password") ?: ""
                    importToken(walletAddress, tokenAddress, symbol, decimal, password)
                }
                "setShowedToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress")
                            ?: return@setMethodCallHandler
                    val isShow =
                        call.argument<Boolean>("isShow")
                            ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: ""
                    setShowedToken(walletAddress, tokenAddress, isShow, password)
                }
                "importNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val nftAddress =
                        call.argument<String>("nftAddress")
                            ?: return@setMethodCallHandler
                    val nftID =
                        call.argument<Int>("nftID")
                            ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: ""
                    importNft(walletAddress, nftAddress, nftID, password)
                }
                "setShowedNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val nftAddress =
                        call.argument<String>("nftAddress")
                            ?: return@setMethodCallHandler
                    val isShow =
                        call.argument<Boolean>("isShow")
                            ?: return@setMethodCallHandler
                    val password =
                        call.argument<String>("password") ?: ""
                    setShowedNft(walletAddress, nftAddress, isShow, password)
                }
            }
        }
    }

    private fun checkPassWordWallet(password: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isCorrect"] = password.isNotEmpty()
        channel?.invokeMethod("checkPasswordCallback", hasMap)
    }

    private fun getConfigWallet() {
        val hasMap = HashMap<String, Boolean>()
        hasMap["isAppLock"] = true
        hasMap["isFaceID"] = true
        hasMap["isWalletExist"] = true
        channel?.invokeMethod("getConfigCallback", hasMap)
    }

    private fun earseWallet(type: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        hasMap["type"] = type
        channel?.invokeMethod("earseWalletCallback", hasMap)
    }

    private fun importWallet(type: String, content: String, password: String) {
        val hasMap = HashMap<String, String>()
//        //todo validate content
//        if (type == TYPE_WALLET_SEED_PHRASE) {
//            //todo content is seed phrase
//            val wallet = HDWallet(content, "")
//            val coinType: CoinType = CoinType.SMARTCHAIN
//            val address = wallet.getAddressForCoin(coinType)
//            hasMap["walletAddress"] = address
//        } else if (type == TYPE_WALLET_PRIVATE_KEY) {
//            //todo content is private key
//            val wallet = HDWallet(content, "")
//            val privateKey = wallet.getKeyForCoin(CoinType.SMARTCHAIN)
//            val publicKeyFalse = privateKey.getPublicKeySecp256k1(false)
//            val anyAddress = AnyAddress(publicKeyFalse, CoinType.SMARTCHAIN)
//            val address = anyAddress.data().toHexString()
//            hasMap["walletAddress"] = address
//// address = 0xa3dcd899c0f3832dfdfed9479a9d828c6a4eb2a7    it does not has EIP55 address
//        } else {
//            return
//        }
        //todo check count wallet -> walletName = wallet count + 1
        hasMap["walletName"] = "walletName"
        hasMap["walletAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        channel?.invokeMethod("importWalletCallback", hasMap)
    }

    private fun getListWallets(password: String) {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        val data1 = HashMap<String, Any>()
        data1["walletName"] = "walletName1"
        data1["walletAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        hasMap.add(data1)
        val data2 = HashMap<String, Any>()
        data2["walletName"] = "walletName2"
        data2["walletAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        hasMap.add(data2)
        channel?.invokeMethod("getListWalletsCallback", hasMap)
    }

    private fun generateWallet(password: String) {
        val hasMap = HashMap<String, String>()
        hasMap["walletAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        hasMap["privateKey"] = "e507e499158b5b6e1a89ad1e65250f6c38a28d455c37cf23c41f4bdd82436e5a"
        hasMap["passPhrase"] =
            "party response give dove tooth master flip video permit game expire token"
        channel?.invokeMethod("generateWalletCallback", hasMap)
    }

    private fun storeWallet(seedPhrase: String, walletName: String, storeWallet: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("storeWalletCallback", hasMap)
    }

    private fun setConfig(appLock: Boolean, faceID: Boolean, password: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("setConfigCallback", hasMap)
    }

    private fun getListShowedToken(walletAddress: String, password: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        hasMap["walletAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        channel?.invokeMethod("getListShowedTokenCallback", hasMap)
    }

    private fun getListShowedNft(walletAddress: String, password: String) {
        //todo
        val hasMap = HashMap<String, Any>()
        hasMap["walletAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
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

    private fun setShowedToken(
        walletAddress: String,
        tokenAddress: String,
        show: Boolean,
        password: String
    ) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("setShowedTokenCallback", hasMap)
    }

    private fun importNft(walletAddress: String, nftAddress: String, nftID: Int, password: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("importNftCallback", hasMap)
    }

    private fun setShowedNft(
        walletAddress: String,
        nftAddress: String,
        show: Boolean,
        password: String
    ) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("setShowedNftCallback", hasMap)
    }

    private fun genAddressBySeedPhrase(seedPhrase: String, coinType: CoinType): String {
        val wallet = HDWallet(seedPhrase, "")
        return wallet.getAddressForCoin(coinType)
    }

    private fun genAddressByPrivateKey(privateKey: String, coinType: CoinType): String {
        val signerInput = Binance.SigningInput.newBuilder().apply {
            this.privateKey = ByteString.copyFrom(privateKey.hexStringToByteArray())
        }.build()
        val signerOutput =
            AnySigner.sign(signerInput, CoinType.SMARTCHAIN, Binance.SigningOutput.parser())
        return ""
    }
}

private fun String.hexStringToByteArray(): ByteArray {
    val HEX_CHARS = "0123456789ABCDEF"
    val result = ByteArray(length / 2)
    for (i in 0 until length step 2) {
        val firstIndex = HEX_CHARS.indexOf(this[i].toUpperCase());
        val secondIndex = HEX_CHARS.indexOf(this[i + 1].toUpperCase());
        val octet = firstIndex.shl(4).or(secondIndex)
        result.set(i.shr(1), octet.toByte())
    }
    return result
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