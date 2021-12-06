package com.edsolabs.dfy_mobile

import com.edsolabs.dfy_mobile.data.local.prefs.AppPreference
import com.edsolabs.dfy_mobile.data.model.WalletModel
import com.google.protobuf.ByteString
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import wallet.core.java.AnySigner
import wallet.core.jni.AnyAddress
import wallet.core.jni.CoinType
import wallet.core.jni.HDWallet
import wallet.core.jni.PrivateKey
import wallet.core.jni.proto.Binance
import java.math.BigInteger
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
    private val appPreference = AppPreference(context = this)
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
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    earseWallet(walletAddress)
                }
                "earseAllWallet" -> {
                    val type = call.argument<String>("type") ?: return@setMethodCallHandler
                    earseAllWallet(type)
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
                "getTokens" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    getTokens(walletAddress)
                }
                "getNFT" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    getNFT(walletAddress)
                }
                "signTransaction" -> {
                    val fromAddress =
                        call.argument<String>("fromAddress")
                            ?: return@setMethodCallHandler
                    val toAddress =
                        call.argument<String>("toAddress")
                            ?: return@setMethodCallHandler
                    val chainId =
                        call.argument<String>("chainId")
                            ?: return@setMethodCallHandler
                    val gasPrice =
                        call.argument<Double>("gasPrice")
                            ?: return@setMethodCallHandler
                    val price =
                        call.argument<Double>("price")
                            ?: return@setMethodCallHandler
                    val maxGas =
                        call.argument<Double>("maxGas")
                            ?: return@setMethodCallHandler
                    signTransaction(
                        fromAddress,
                        toAddress,
                        chainId,
                        gasPrice,
                        price,
                        maxGas
                    )
                }
                "exportWallet" -> {
                    val password =
                        call.argument<String>("password")
                            ?: return@setMethodCallHandler
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    exportWallet(
                        password,
                        walletAddress
                    )
                }
            }
        }
    }

    private fun exportWallet(password: String, walletAddress: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = password.isNotEmpty()
        channel?.invokeMethod("exportWalletCallBack", hasMap)
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

    private fun earseAllWallet(type: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        hasMap["type"] = type
        channel?.invokeMethod("earseAllWalletCallback", hasMap)
    }

    private fun earseWallet(walletAddress: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        channel?.invokeMethod("earseWalletCallback", hasMap)
    }

    private fun importWallet(type: String, content: String, password: String) {
        //todo check password
        val hasMap = HashMap<String, Any>()
        val sttWallet = appPreference.sttWallet
        var address = ""
        //todo validate content
        if (type == TYPE_WALLET_SEED_PHRASE) {
            //todo content is seed phrase
            val wallet = HDWallet(content, "")
            val coinType: CoinType = CoinType.SMARTCHAIN
            address = wallet.getAddressForCoin(coinType)
            hasMap["walletAddress"] = address
        } else if (type == TYPE_WALLET_PRIVATE_KEY) {
            //todo content is private key
            val wallet = HDWallet(content, "")
            val privateKey = wallet.getKeyForCoin(CoinType.SMARTCHAIN)
            val publicKeyFalse = privateKey.getPublicKeySecp256k1(false)
            val anyAddress = AnyAddress(publicKeyFalse, CoinType.SMARTCHAIN)
            address = anyAddress.data().toHexString()
            hasMap["walletAddress"] = address
        } else {
            return
        }
        val walletName = "Account ${sttWallet + 1}"
        appPreference.setSttWallet(sttWallet + 1)
        hasMap["walletName"] = walletName
        val listWallet = ArrayList<WalletModel>()
        listWallet.addAll(appPreference.getListWallet())
        listWallet.add(WalletModel(walletName, address))
        appPreference.saveListWallet(listWallet)
        channel?.invokeMethod("importWalletCallback", hasMap)
    }

    private fun getListWallets(password: String) {
        //todo check password
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        appPreference.getListWallet().forEach {
            val data = HashMap<String, Any>()
            data["walletName"] = it.walletName
            data["walletAddress"] = it.walletAddress
            hasMap.add(data)
        }
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

    private fun getTokens(
        walletAddress: String
    ) {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        val data1 = HashMap<String, Any>()

        data1["tokenFullName"] = "BitCoin"
        data1["tokenShortName"] = "BTC"
        data1["tokenAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        data1["iconToken"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15".toByteArray()
        hasMap.add(data1)
        val data2 = HashMap<String, Any>()
        data2["tokenFullName"] = "Binance"
        data2["tokenShortName"] = "BNB"
        data2["tokenAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        data2["iconToken"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15".toByteArray()
        hasMap.add(data2)
        channel?.invokeMethod("getTokensCallback", hasMap)
    }

    private fun getNFT(
        walletAddress: String
    ) {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        val data1 = HashMap<String, Any>()
        data1["nftName"] = "Defi for you"
        data1["nftAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        data1["iconNFT"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15".toByteArray()
        hasMap.add(data1)
        val data2 = HashMap<String, Any>()
        data2["nftName"] = "Defi for you"
        data2["nftAddress"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15"
        data2["iconNFT"] = "0x753EE7D5FdBD248fED37add0C951211E03a7DA15".toByteArray()
        hasMap.add(data2)
        channel?.invokeMethod("getNFTCallback", hasMap)
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

    private fun signTransaction(
        fromAddress: String,
        toAddress: String,
        chainId: String,
        gasPrice: Double,
        price: Double,
        maxGas: Double
    ) {
        val privateKey =
            PrivateKey("c6183448b911c04db9dc0863018fca4e8fe19bbb7469342eb34b31c76232dee0".toHexBytes())
        val publicKey = privateKey.getPublicKeySecp256k1(true)

        val token = Binance.SendOrder.Token.newBuilder().apply {
            this.denom = "BNB"
            this.amount = 1
        }.build()

        val input = Binance.SendOrder.Input.newBuilder().apply {
            this.address = ByteString.copyFromUtf8(
                fromAddress
            )
            this.addAllCoins(listOf(token))
        }

        val output = Binance.SendOrder.Output.newBuilder().apply {
            this.address = ByteString.copyFromUtf8(
                toAddress
            )
            this.addAllCoins(listOf(token))
        }

        val signingInput = Binance.SigningInput.newBuilder().apply {
            this.chainId = chainId
            this.accountNumber = 0
            this.sequence = 1
            this.source = 0
            this.privateKey = ByteString.copyFrom(privateKey.data())
            this.memo = ""
            this.sendOrder = Binance.SendOrder.newBuilder().apply {
                this.addInputs(input)
                this.addOutputs(output)
            }.build()
        }.build()

        val sign: Binance.SigningOutput = AnySigner.sign(
            signingInput,
            CoinType.BINANCE, Binance.SigningOutput.parser()
        )
        val signBytes = sign.encoded.toByteArray()

        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        hasMap["signedTransaction"] = signBytes
        channel?.invokeMethod("signTransactionCallback", hasMap)
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

private fun BigInteger.toByteString(): ByteString {
    return ByteString.copyFrom(this.toByteArray())
}

fun String.toHexBytes(): ByteArray {
    return Numeric.hexStringToByteArray(this)
}
