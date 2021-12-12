package com.edsolabs.dfy_mobile

import com.edsolabs.dfy_mobile.data.local.prefs.AppPreference
import com.edsolabs.dfy_mobile.data.model.ItemNftModel
import com.edsolabs.dfy_mobile.data.model.NftModel
import com.edsolabs.dfy_mobile.data.model.TokenModel
import com.edsolabs.dfy_mobile.data.model.WalletModel
import com.google.protobuf.ByteString
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import org.json.JSONArray
import org.json.JSONObject
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

    private val TOKEN_DFY_ADDRESS = "0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14"
    private val TOKEN_BNB_ADDRESS = "0x0000000000000000000000000000000000000000"

    private val TYPE_DELETE_WALLET_IMPORT = "IMPORT"
    private val TYPE_DELETE_WALLET_CREATE = "CREATE"

    private val CHANNEL_TRUST_WALLET = "flutter/trust_wallet"

    private val CODE_SUCCESS = 200
    private val CODE_ERROR = 400

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
                    val newPassword = call.argument<String>("newPassword")
                        ?: return@setMethodCallHandler
                    changePassWordWallet(oldPassword, newPassword)
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
                "changeNameWallet" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    val walletName =
                        call.argument<String>("walletName") ?: return@setMethodCallHandler
                    changeNameWallet(walletAddress, walletName)
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
                "checkToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress") ?: return@setMethodCallHandler
                    checkToken(
                        walletAddress,
                        tokenAddress
                    )
                }
                "importToken" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress") ?: return@setMethodCallHandler
                    val tokenAddress =
                        call.argument<String>("tokenAddress") ?: return@setMethodCallHandler
                    val tokenFullName =
                        call.argument<String>("tokenFullName") ?: return@setMethodCallHandler
                    val iconToken =
                        call.argument<String>("iconToken") ?: return@setMethodCallHandler
                    val symbol =
                        call.argument<String>("symbol") ?: return@setMethodCallHandler
                    val decimal =
                        call.argument<Int>("decimal") ?: return@setMethodCallHandler
                    val exchangeRate =
                        call.argument<Double>("exchangeRate") ?: return@setMethodCallHandler
                    importToken(
                        walletAddress,
                        tokenAddress,
                        tokenFullName,
                        iconToken,
                        symbol,
                        decimal,
                        exchangeRate
                    )
                }
                "importListToken" -> {
                    val jsonTokens =
                        call.argument<String>("jsonTokens")
                            ?: return@setMethodCallHandler
                    importListToken(jsonTokens)
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
                    val jsonNft =
                        call.argument<String>("jsonNft")
                            ?: return@setMethodCallHandler
                    importNft(jsonNft, walletAddress)
                }
//                "importListNft" -> {
//                    val jsonNft =
//                        call.argument<String>("jsonNft")
//                            ?: return@setMethodCallHandler
//                    importListNft(jsonNft)
//                }
                "deleteNft" -> {
                    val walletAddress =
                        call.argument<String>("walletAddress")
                            ?: return@setMethodCallHandler
                    val nftAddress =
                        call.argument<String>("nftAddress")
                            ?: return@setMethodCallHandler
                    val id =
                        call.argument<Int>("id")
                            ?: return@setMethodCallHandler
                    deleteNft(walletAddress, nftAddress, id)
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


    private fun changeNameWallet(walletAddress: String, walletName: String) {
        val hasMap = HashMap<String, Any>()
        val wallet = appPreference.getListWallet().firstOrNull { it.walletAddress == walletAddress }
        if (wallet != null && walletName.isNotEmpty()) {
            val listWallet = ArrayList<WalletModel>()
            listWallet.addAll(appPreference.getListWallet())
            listWallet.firstOrNull { it.walletAddress == walletAddress }?.walletName = walletName
            appPreference.saveListWallet(listWallet)
            hasMap["isSuccess"] = true
        } else {
            hasMap["isSuccess"] = false
        }
        channel?.invokeMethod("changeNameWalletCallBack", hasMap)
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
                    if (listWallet.firstOrNull { it.walletAddress == address } == null) {
                        val walletName = "Account ${listWallet.size + 1}"
                        hasMap["walletAddress"] = address
                        listWallet.add(
                            WalletModel(
                                walletName,
                                address,
                                content,
                                privateKey.toByteArray().toHexString(false),
                                true
                            )
                        )
                        appPreference.saveListWallet(listWallet)
                        hasMap["walletName"] = walletName
                        hasMap["code"] = CODE_SUCCESS
                        hasMap["messages"] = "Import tài khoản thành công"
                        channel?.invokeMethod("importWalletCallback", hasMap)
                    } else {
                        hasMap["walletAddress"] = ""
                        hasMap["walletName"] = ""
                        hasMap["code"] = CODE_ERROR
                        hasMap["messages"] = "Tài khoản đã tồn tại"
                        channel?.invokeMethod("importWalletCallback", hasMap)
                    }
                }
                TYPE_WALLET_PRIVATE_KEY -> {
                    val privateKey = PrivateKey(content.toHexBytes())
                    val publicKey = privateKey.getPublicKeySecp256k1(false)
                    val address = AnyAddress(publicKey, coinType).description()
                    val listWallet = ArrayList<WalletModel>()
                    listWallet.addAll(appPreference.getListWallet())
                    if (listWallet.firstOrNull { it.walletAddress == address } == null) {
                        val walletName = "Account ${listWallet.size + 1}"
                        hasMap["walletAddress"] = address
                        listWallet.add(
                            WalletModel(
                                walletName,
                                address,
                                "",
                                content,
                                true
                            )
                        )
                        appPreference.saveListWallet(listWallet)
                        hasMap["walletName"] = walletName
                        hasMap["code"] = CODE_SUCCESS
                        hasMap["messages"] = "Import tài khoản thành công"
                        channel?.invokeMethod("importWalletCallback", hasMap)
                    } else {
                        hasMap["walletAddress"] = ""
                        hasMap["walletName"] = ""
                        hasMap["code"] = CODE_ERROR
                        hasMap["messages"] = "Tài khoản đã tồn tại"
                        channel?.invokeMethod("importWalletCallback", hasMap)
                    }
                }
                else -> {
                    hasMap["walletAddress"] = ""
                    hasMap["walletName"] = ""
                    hasMap["code"] = CODE_ERROR
                    hasMap["messages"] = "Có lỗi xảy ra vui lòng thử lại."
                    channel?.invokeMethod("importWalletCallback", hasMap)
                }
            }
        } catch (e: InvalidParameterException) {
            hasMap["walletAddress"] = ""
            hasMap["walletName"] = ""
            hasMap["code"] = CODE_ERROR
            hasMap["messages"] =
                if (type == TYPE_WALLET_SEED_PHRASE) "Lỗi seed phrase vui lòng thử lại" else "Lỗi private key vui lòng thử lại"
            channel?.invokeMethod("importWalletCallback", hasMap)
        }
    }

    private fun getListWallets() {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        appPreference.getListWallet().forEach {
            val data = HashMap<String, Any>()
            data["walletName"] = it.walletName
            data["walletAddress"] = it.walletAddress
            data["isImportWallet"] = it.isImportWallet
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
                privateKey,
                false
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

    private fun checkToken(walletAddress: String, tokenAddress: String) {
        val hasMap = HashMap<String, Any>()
        hasMap["isExist"] = appPreference.getListTokenSupport()
            .firstOrNull { it.walletAddress == walletAddress && it.tokenAddress == tokenAddress && it.isShow } != null
        channel?.invokeMethod("checkTokenCallback", hasMap)
    }

    private fun importToken(
        walletAddress: String,
        tokenAddress: String,
        tokenFullName: String,
        iconToken: String,
        symbol: String,
        decimal: Int,
        exchangeRate: Double
    ) {
        val hasMap = HashMap<String, Any>()
        val listToken = ArrayList<TokenModel>()
        listToken.addAll(appPreference.getListTokenSupport())
        if (listToken.firstOrNull { it.walletAddress == walletAddress && it.tokenAddress == tokenAddress && it.isShow } == null) {
            listToken.add(
                TokenModel(
                    walletAddress,
                    tokenAddress,
                    tokenFullName,
                    iconToken,
                    symbol,
                    decimal,
                    exchangeRate,
                    isShow = true
                )
            )
            appPreference.saveListTokenSupport(listToken)
            hasMap["isSuccess"] = true
        } else {
            hasMap["isSuccess"] = false
        }
        channel?.invokeMethod("importTokenCallback", hasMap)
    }

    private fun importListToken(
        jsonTokens: String
    ) {
        val listTokenSupport = ArrayList<TokenModel>()
        listTokenSupport.addAll(appPreference.getListTokenSupport())
        val listTokens = ArrayList<TokenModel>()
        val listObjectTokens = JSONArray(jsonTokens)

        var size = 0
        while (size < listObjectTokens.length()) {
            val data = listObjectTokens.getJSONObject(size)
            val tokenAddress = data.getString("tokenAddress")
            val token = TokenModel(
                walletAddress = data.getString("walletAddress"),
                tokenAddress = tokenAddress,
                tokenFullName = data.getString("nameToken"),
                iconUrl = data.getString("iconToken"),
                symbol = data.getString("nameShortToken"),
                decimal = data.getInt("decimal"),
                exchangeRate = data.getDouble("exchangeRate"),
                isShow = tokenAddress == TOKEN_DFY_ADDRESS || tokenAddress == TOKEN_BNB_ADDRESS
            )
            val tokenInCore =
                listTokenSupport.firstOrNull { it.walletAddress == token.walletAddress && it.tokenAddress == token.tokenAddress }
            if (tokenInCore == null) {
                when (tokenAddress) {
                    TOKEN_DFY_ADDRESS -> {
                        listTokens.add(0, token)
                    }
                    TOKEN_BNB_ADDRESS -> {
                        listTokens.add(1, token)
                    }
                    else -> {
                        listTokens.add(token)
                    }
                }
            } else {
                token.isShow = tokenInCore.isShow
                when (tokenAddress) {
                    TOKEN_DFY_ADDRESS -> {
                        listTokens.add(0, token)
                    }
                    TOKEN_BNB_ADDRESS -> {
                        listTokens.add(1, token)
                    }
                    else -> {
                        listTokens.add(token)
                    }
                }
            }
            size++
        }
        val hasMap = HashMap<String, Any>()
        appPreference.saveListTokenSupport(listTokens)
        hasMap["isSuccess"] = true
        channel?.invokeMethod("importListTokenCallback", hasMap)
    }

    private fun getTokens(
        walletAddress: String
    ) {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        appPreference.getListTokenSupport().forEach {
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
                data["exchangeRate"] = it.exchangeRate
                hasMap.add(data)
            }
        }
        channel?.invokeMethod("getTokensCallback", hasMap)
    }

    private fun deleteNft(walletAddress: String, collectionAddress: String, id: Int) {
        val listNft = ArrayList<NftModel>()
        var isDeleteSuccess = false
        appPreference.getListNft().forEach { it ->
            if (it.walletAddress != walletAddress && it.collectionAddress != collectionAddress) {
                val data = NftModel()
                data.walletAddress = walletAddress
                data.collectionAddress = collectionAddress
                data.nftName = it.nftName
                data.symbol = it.symbol
                it.item.forEach {
                    if (it.id != id) {
                        data.item.add(it)
                    } else {
                        isDeleteSuccess = true
                    }
                }
                if (data.item.isNotEmpty()) {
                    listNft.add(it)
                }
            }
        }
        appPreference.saveListNft(listNft)
        val data = HashMap<String, Any>()
        data["isSuccess"] = isDeleteSuccess
        channel?.invokeMethod("setDeleteNftCallback", data)

    }

    private fun getNFT(
        walletAddress: String
    ) {
        val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
        appPreference.getListNft().forEach {
            if (it.walletAddress == walletAddress) {
                val data = HashMap<String, Any>()
                data["walletAddress"] = it.walletAddress ?: ""
                data["collectionAddress"] = it.collectionAddress ?: ""
                data["nftName"] = it.nftName ?: ""
                data["symbol"] = it.symbol ?: ""
                val hasMapListNft: ArrayList<HashMap<String, Any>> = ArrayList()
                it.item.forEach {
                    val dataListNft = HashMap<String, Any>()
                    dataListNft["id"] = it.id
                    dataListNft["contract"] = it.contract
                    dataListNft["uri"] = it.uri
                    hasMapListNft.add(dataListNft)
                }
                data["listNft"] = hasMapListNft
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
        if (tokenAddress != TOKEN_DFY_ADDRESS || tokenAddress != TOKEN_BNB_ADDRESS) {
            val listToken = ArrayList<TokenModel>()
            listToken.addAll(appPreference.getListTokenSupport())
            listToken.firstOrNull { it.walletAddress == walletAddress && it.tokenAddress == tokenAddress }?.isShow =
                isShow
            appPreference.saveListTokenSupport(listToken)
            hasMap["isSuccess"] = true
        } else {
            hasMap["isSuccess"] = false
        }
        channel?.invokeMethod("setShowedTokenCallback", hasMap)
    }

    private fun importNft(
        jsonNft: String,
        walletAddress: String
    ) {
        val listNftSupport = ArrayList<NftModel>()
        listNftSupport.addAll(appPreference.getListNft())
        val objectNft = JSONObject(jsonNft)
        val contractNft = objectNft.getString("contract")
        var checkItemNft =
            listNftSupport.firstOrNull { it.walletAddress == walletAddress && it.collectionAddress == contractNft }
        if (checkItemNft == null) {
            checkItemNft = NftModel()
            checkItemNft.walletAddress = walletAddress
            checkItemNft.collectionAddress = objectNft.getString("contract")
            checkItemNft.nftName = objectNft.getString("name")
            checkItemNft.symbol = objectNft.getString("symbol")
            val listNftJson = objectNft.getJSONArray("listNft")
            var size = 0
            val listNft = ArrayList<ItemNftModel>()
            while (size < listNftJson.length()) {
                val data = listNftJson.getJSONObject(size)
                listNft.add(
                    ItemNftModel(
                        id = data.getInt("id"),
                        contract = data.getString("contract"),
                        uri = data.getString("uri")
                    )
                )
                size++
            }
            checkItemNft.item = listNft
        } else {
            checkItemNft.let {
                val listNftJson = objectNft.getJSONArray("listNft")
                var size = 0
                val listNft = ArrayList<ItemNftModel>()
                while (size < listNftJson.length()) {
                    val data = listNftJson.getJSONObject(size)
                    val id = data.getInt("id")
                    if (checkItemNft.item.firstOrNull { it.id != id } == null) {
                        listNft.add(
                            ItemNftModel(
                                id = id,
                                contract = data.getString("contract"),
                                uri = data.getString("uri")
                            )
                        )
                    }
                    size++
                }
                it.item.addAll(listNft)
            }
        }
        listNftSupport.add(checkItemNft)
        val hasMap = HashMap<String, Any>()
        appPreference.saveListNft(listNftSupport)
        hasMap["isSuccess"] = true
        channel?.invokeMethod("importNftCallback", hasMap)
    }

    private fun setShowedNft(
        walletAddress: String,
        nftAddress: String,
        isShow: Boolean
    ) {
        val hasMap = HashMap<String, Any>()
        val listNft = ArrayList<NftModel>()
        listNft.addAll(appPreference.getListNft())
//        listNft.firstOrNull { it.walletAddress == walletAddress && it.nftAddress == nftAddress }?.isShow =
//            isShow
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
