package com.edsolabs.dfy_mobile

import com.edsolabs.dfy_mobile.data.local.prefs.AppPreference
import com.edsolabs.dfy_mobile.data.model.NftModel
import com.edsolabs.dfy_mobile.data.model.TokenModel
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
import java.security.InvalidParameterException
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
    private lateinit var appPreference: AppPreference
    private val coinType: CoinType = CoinType.SMARTCHAIN

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        appPreference = AppPreference(context = this@MainActivity)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_TRUST_WALLET)
        channel?.setMethodCallHandler { call, _ ->
            when (call.method) {
                "checkPassword" -> {
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    checkPassWordWallet(password)
                }
                "changePassword" -> {
                    val oldPassword = call.argument<String>("oldPassword")
                        ?: return@setMethodCallHandler
                    val changePassword = call.argument<String>("changePassword")
                        ?: return@setMethodCallHandler
                    changePassWordWallet(oldPassword, changePassword)
                }
                "savePassword" -> {
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    savePassWordWallet(password)
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
                    importWallet(type, content)
                }
                "getListWallets" -> {
                    val password = call.argument<String>("password")
                        ?: return@setMethodCallHandler
                    getListWallets()
                }
                "generateWallet" -> {
                    generateWallet()
                }
                "storeWallet" -> {
                    val seedPhrase =
                        call.argument<String>("seedPhrase") ?: return@setMethodCallHandler
                    val walletName =
                        call.argument<String>("walletName") ?: return@setMethodCallHandler
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    val privateKey =
                        call.argument<String>("privateKey") ?: return@setMethodCallHandler
                    storeWallet(
                        seedPhrase,
                        walletName,
                        walletAddress,
                        privateKey
                    )
                }
                "setConfig" -> {
                    val isAppLock =
                        call.argument<Boolean>("isAppLock") ?: true
                    val isFaceID =
                        call.argument<Boolean>("isFaceID") ?: false
                    setConfig(isAppLock, isFaceID)
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

                "importTokens" -> {
                    val jsonTokens =
                        call.argument<String>("jsonTokens")
                            ?: return@setMethodCallHandler
                    importToken(jsonTokens)
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
                    setShowedToken(walletAddress, tokenAddress, isShow)
                }
                "importNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val nftAddress =
                        call.argument<String>("nftAddress")
                            ?: return@setMethodCallHandler
                    val nftName =
                        call.argument<String>("nftName")
                            ?: return@setMethodCallHandler
                    val iconNFT =
                        call.argument<String>("iconNFT")
                            ?: return@setMethodCallHandler
                    val nftID =
                        call.argument<Int>("nftID")
                            ?: return@setMethodCallHandler
                    importNft(walletAddress, nftAddress, nftName, iconNFT, nftID)
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
                    setShowedNft(walletAddress, nftAddress, isShow)
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
        if (password == appPreference.password) {
            val hasMap = HashMap<String, Any>()
            appPreference.getListWallet().forEach {
                if (it.walletAddress == walletAddress) {
                    hasMap["walletAddress"] = it.walletAddress
                    hasMap["privateKey"] = it.privateKey
                    hasMap["passPhrase"] = it.seedPhrase
                }
            }
            channel?.invokeMethod("exportWalletCallBack", hasMap)
        }
    }

    private fun checkPassWordWallet(password: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isCorrect"] = password == appPreference.password
        channel?.invokeMethod("checkPasswordCallback", hasMap)
    }

    private fun savePassWordWallet(password: String) {
        if (password.isNotEmpty()) {
            val hasMap = HashMap<String, Any>()
            appPreference.password = password
            hasMap["isSuccess"] = true
            channel?.invokeMethod("savePasswordCallback", hasMap)
        }
    }

    private fun changePassWordWallet(oldPassword: String, newPassword: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = oldPassword == appPreference.password
        if (appPreference.password == oldPassword) {
            appPreference.password = newPassword
        }
        channel?.invokeMethod("changePasswordCallback", hasMap)
    }

    private fun getConfigWallet() {
        val hasMap = HashMap<String, Boolean>()
        hasMap["isAppLock"] = appPreference.isAppLock
        hasMap["isFaceID"] = appPreference.isFaceID
        hasMap["isWalletExist"] = appPreference.getListWallet().isNotEmpty()
        channel?.invokeMethod("getConfigCallback", hasMap)
    }


    private fun earseAllWallet(type: String) {
        val hasMap = HashMap<String, Any>()
        appPreference.earseAllWallet()
        hasMap["isSuccess"] = true
        hasMap["type"] = type
        channel?.invokeMethod("earseAllWalletCallback", hasMap)
    }

    private fun earseWallet(walletAddress: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        val listWallet = ArrayList<WalletModel>()
        appPreference.getListWallet().forEachIndexed { index, walletModel ->
            if (walletAddress != walletModel.walletAddress) {
                listWallet.add(walletModel)
            }
        }
        appPreference.saveListWallet(listWallet)
        channel?.invokeMethod("earseWalletCallback", hasMap)
    }

    private fun importWallet(type: String, content: String) {
        val hasMap = HashMap<String, Any>()
        try {
            when (type) {
                TYPE_WALLET_SEED_PHRASE -> {
                    val wallet = HDWallet(content, "")
                    val address = wallet.getAddressForCoin(coinType)
                    val privateKey = ByteString.copyFrom(wallet.getKeyForCoin(coinType).data())
                    val listWallet = ArrayList<WalletModel>()
                    listWallet.addAll(appPreference.getListWallet())
                    if (listWallet.firstOrNull { it.walletAddress != address } == null) {
                        val walletName = "Account ${listWallet.size + 1}"
                        hasMap["walletAddress"] = address
                        listWallet.add(
                            WalletModel(
                                walletName,
                                address,
                                content,
                                privateKey.toByteArray().toHexString(false)
                            )
                        )
                        appPreference.saveListWallet(listWallet)
                        hasMap["walletName"] = walletName
                        channel?.invokeMethod("importWalletCallback", hasMap)
                    }

                }
                TYPE_WALLET_PRIVATE_KEY -> {
                    val privateKey = PrivateKey(content.toHexBytes())
                    val publicKey = privateKey.getPublicKeySecp256k1(false)
                    val address = AnyAddress(publicKey, coinType).description()
                    val listWallet = ArrayList<WalletModel>()
                    listWallet.addAll(appPreference.getListWallet())
                    if (listWallet.firstOrNull { it.walletAddress != address } == null) {
                        val walletName = "Account ${listWallet.size + 1}"
                        hasMap["walletAddress"] = address
                        listWallet.add(
                            WalletModel(
                                walletName,
                                address,
                                "",
                                content
                            )
                        )
                        appPreference.saveListWallet(listWallet)
                        hasMap["walletName"] = walletName
                        channel?.invokeMethod("importWalletCallback", hasMap)
                    }

                    return
                }
                else -> {
                    hasMap["walletAddress"] = ""
                    hasMap["walletName"] = ""
                    channel?.invokeMethod("importWalletCallback", hasMap)
                }
            }
        } catch (e: InvalidParameterException) {
            hasMap["walletAddress"] = ""
            hasMap["walletName"] = ""
            channel?.invokeMethod("importWalletCallback", hasMap)
        }
    }

    private fun getListWallets() {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        appPreference.getListWallet().forEach {
            val data = HashMap<String, Any>()
            data["walletName"] = it.walletName
            data["walletAddress"] = it.walletAddress
            hasMap.add(data)
        }
        channel?.invokeMethod("getListWalletsCallback", hasMap)
    }

    private fun generateWallet() {
        val wallet = HDWallet(128, "")
        val seedPhrase = wallet.mnemonic()
        val address = wallet.getAddressForCoin(coinType)
        val privateKey = ByteString.copyFrom(wallet.getKeyForCoin(coinType).data())
        val walletName = "Account ${appPreference.getListWallet().size + 1}"

        val hasMap = HashMap<String, String>()
        hasMap["walletName"] = walletName
        hasMap["passPhrase"] = seedPhrase
        hasMap["walletAddress"] = address
        hasMap["privateKey"] = privateKey.toByteArray().toHexString(false)
        channel?.invokeMethod("generateWalletCallback", hasMap)
    }

    private fun storeWallet(
        seedPhrase: String,
        walletName: String,
        walletAddress: String,
        privateKey: String
    ) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        val listWallet = ArrayList<WalletModel>()
        listWallet.addAll(appPreference.getListWallet())
        listWallet.add(
            WalletModel(
                walletName,
                walletAddress,
                seedPhrase,
                privateKey
            )
        )
        appPreference.saveListWallet(listWallet)
        channel?.invokeMethod("storeWalletCallback", hasMap)
    }

    private fun setConfig(appLock: Boolean, faceID: Boolean) {
        val hasMap = HashMap<String, Any>()
        hasMap["isSuccess"] = true
        appPreference.isAppLock = appLock
        appPreference.isFaceID = faceID
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
        jsonTokens: String
    ) {
        val hasMap = HashMap<String, Any>()
//        val listToken = ArrayList<TokenModel>()
//        listToken.addAll(appPreference.getListToken())
//        listToken.add(
//            TokenModel(
//                walletAddress,
//                tokenAddress,
//                tokenFullName,
//                iconToken,
//                symbol,
//                decimal
//            )
//        )
//        appPreference.saveListToken(listToken)
        hasMap["isSuccess"] = false
        channel?.invokeMethod("importTokenCallback", hasMap)
    }

    private fun getTokens(
        walletAddress: String
    ) {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        appPreference.getListToken().forEach {
            if (it.walletAddress == walletAddress) {
                val data = HashMap<String, Any>()
                data["walletAddress"] = it.walletAddress
                data["tokenFullName"] = it.tokenFullName
                data["symbol"] = it.symbol
                data["tokenAddress"] = it.tokenAddress
                data["iconUrl"] =
                    "https://icons.iconarchive.com/icons/cjdowner/cryptocurrency-flat/1024/Bitcoin-BTC-icon.png"
                data["isShow"] = it.isShow
                data["decimal"] = it.decimal
                hasMap.add(data)
            }
        }
        channel?.invokeMethod("getTokensCallback", hasMap)
    }

    private fun getNFT(
        walletAddress: String
    ) {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        appPreference.getListNft().forEach {
            if (it.walletAddress == walletAddress) {
                val data = HashMap<String, Any>()
                data["walletAddress"] = it.walletAddress
                data["nftAddress"] = it.nftAddress
                data["nftName"] = it.nftName
                data["iconNFT"] = it.iconNFT
                data["nftID"] = it.nftID
                hasMap.add(data)
            }
        }
        channel?.invokeMethod("getNFTCallback", hasMap)
    }

    private fun setShowedToken(
        walletAddress: String,
        tokenAddress: String,
        isShow: Boolean
    ) {
        val hasMap = HashMap<String, Any>()
        val listToken = ArrayList<TokenModel>()
        listToken.addAll(appPreference.getListToken())
        listToken.firstOrNull { it.walletAddress == walletAddress && it.tokenAddress == tokenAddress }?.isShow =
            isShow
        appPreference.saveListToken(listToken)
        hasMap["isSuccess"] = true
        channel?.invokeMethod("setShowedTokenCallback", hasMap)
    }

    private fun importNft(
        walletAddress: String,
        nftAddress: String,
        nftName: String,
        iconNFT: String,
        nftID: Int
    ) {
        //todo check password
        val hasMap = HashMap<String, Any>()
        val listNft = ArrayList<NftModel>()
        listNft.addAll(appPreference.getListNft())
        listNft.add(
            NftModel(
                walletAddress,
                nftAddress,
                nftName,
                iconNFT,
                nftID
            )
        )
        appPreference.saveListNft(listNft)
        hasMap["isSuccess"] = true
        channel?.invokeMethod("importNftCallback", hasMap)
    }

    private fun setShowedNft(
        walletAddress: String,
        nftAddress: String,
        isShow: Boolean
    ) {
        //todo check password
        val hasMap = HashMap<String, Any>()
        val listNft = ArrayList<NftModel>()
        listNft.addAll(appPreference.getListNft())
        listNft.firstOrNull { it.walletAddress == walletAddress && it.nftAddress == nftAddress }?.isShow =
            isShow
        appPreference.saveListNft(listNft)
        hasMap["isSuccess"] = true
        channel?.invokeMethod("setShowedNftCallback", hasMap)
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
