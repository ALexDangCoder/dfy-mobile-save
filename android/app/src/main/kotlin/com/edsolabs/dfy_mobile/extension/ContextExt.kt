package com.edsolabs.dfy_mobile.extension

import android.content.Context
import com.edsolabs.dfy_mobile.Constant
import com.edsolabs.dfy_mobile.data.local.prefs.AppPreference
import com.edsolabs.dfy_mobile.data.model.ItemNftModel
import com.edsolabs.dfy_mobile.data.model.NftModel
import com.edsolabs.dfy_mobile.data.model.TokenModel
import com.edsolabs.dfy_mobile.data.model.WalletModel
import com.google.protobuf.ByteString
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray
import org.json.JSONObject
import wallet.core.java.AnySigner
import wallet.core.jni.*
import wallet.core.jni.proto.Ethereum
import java.math.BigInteger
import java.security.InvalidParameterException
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap

fun Context.chooseWallet(channel: MethodChannel?, walletAddress: String) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Any>()
    val listWallet = ArrayList<WalletModel>()
    val listWalletInCore = appPreference.getListWallet()
    listWalletInCore.forEachIndexed { index, walletModel ->
        if (walletAddress == walletModel.walletAddress) {
            listWallet.add(0, walletModel)
        } else {
            listWallet.add(walletModel)
        }
    }
    listWallet.forEachIndexed { index, walletModel ->
        walletModel.walletIndex = index
    }
    appPreference.saveListWallet(listWallet)
    hasMap["isSuccess"] = true
    channel?.invokeMethod("chooseWalletCallBack", hasMap)
}

fun Context.setConfig(channel: MethodChannel?, appLock: Boolean, faceID: Boolean) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Any>()
    hasMap["isSuccess"] = true
    appPreference.isAppLock = appLock
    appPreference.isFaceID = faceID
    channel?.invokeMethod("setConfigCallback", hasMap)
}

fun Context.exportWallet(
        channel: MethodChannel?,
        password: String,
        isFaceId: Boolean,
        walletAddress: String
) {
    val appPreference = AppPreference(this)
    if (password == appPreference.password || isFaceId) {
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

fun Context.checkPassWordWallet(channel: MethodChannel?, password: String) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Any>()
    hasMap["isCorrect"] = password == appPreference.password
    channel?.invokeMethod("checkPasswordCallback", hasMap)
}

fun Context.savePassWordWallet(channel: MethodChannel?, password: String) {
    val appPreference = AppPreference(this)
    if (password.isNotEmpty()) {
        val hasMap = HashMap<String, Any>()
        appPreference.password = password
        hasMap["isSuccess"] = true
        channel?.invokeMethod("savePasswordCallback", hasMap)
    }
}

fun Context.changePassWordWallet(
        channel: MethodChannel?,
        oldPassword: String,
        newPassword: String
) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Any>()
    hasMap["isSuccess"] = oldPassword == appPreference.password
    if (appPreference.password == oldPassword) {
        appPreference.password = newPassword
    }
    channel?.invokeMethod("changePasswordCallback", hasMap)
}


fun Context.getConfigWallet(channel: MethodChannel?) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Boolean>()
    hasMap["isAppLock"] = appPreference.isAppLock
    hasMap["isFaceID"] = appPreference.isFaceID
    hasMap["isWalletExist"] = appPreference.getListWallet().isNotEmpty()
    channel?.invokeMethod("getConfigCallback", hasMap)
}

fun Context.changeNameWallet(channel: MethodChannel?, walletAddress: String, walletName: String) {
    val appPreference = AppPreference(this)
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

//fun Context.earseAllWallet(channel: MethodChannel?, type: String) {
//    val appPreference = AppPreference(this)
//    val hasMap = HashMap<String, Any>()
//    appPreference.earseAllWallet()
//    hasMap["isSuccess"] = true
//    hasMap["type"] = type
//    channel?.invokeMethod("earseAllWalletCallback", hasMap)
//}

fun Context.earseWallet(channel: MethodChannel?, walletAddress: String) {
    val appPreference = AppPreference(this)
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


fun Context.importWallet(
        channel: MethodChannel?,
        type: String,
        content: String,
        typeEarseWallet: String
) {
    val appPreference = AppPreference(this)
    val coinType: CoinType = CoinType.SMARTCHAIN
    val hasMap = HashMap<String, Any>()
    try {
        when (type) {
            Constant.TYPE_WALLET_SEED_PHRASE -> {
                val wallet = HDWallet(content, "")
                val address = wallet.getAddressForCoin(coinType)
                val privateKey = ByteString.copyFrom(wallet.getKeyForCoin(coinType).data())
                val listWallet = ArrayList<WalletModel>()
                if (typeEarseWallet != Constant.TYPE_EARSE_WALLET) {
                    listWallet.addAll(appPreference.getListWallet())
                }
                if (listWallet.firstOrNull { it.walletAddress == address } == null) {
                    val walletName = "Account ${listWallet.size + 1}"
                    hasMap["walletAddress"] = address
                    listWallet.add(
                            0,
                            WalletModel(
                                    walletName,
                                    address,
                                    0,
                                    content,
                                    privateKey.toByteArray().toHexString(false),
                                    true
                            )
                    )
                    listWallet.forEachIndexed { index, walletModel ->
                        walletModel.walletIndex = index
                    }
                    appPreference.saveListWallet(listWallet)
                    hasMap["walletName"] = walletName
                    hasMap["code"] = Constant.CODE_SUCCESS
                    channel?.invokeMethod("importWalletCallback", hasMap)
                } else {
                    hasMap["walletAddress"] = ""
                    hasMap["walletName"] = ""
                    hasMap["code"] = Constant.CODE_ERROR_DUPLICATE
                    channel?.invokeMethod("importWalletCallback", hasMap)
                }
            }
            Constant.TYPE_WALLET_PRIVATE_KEY -> {
                val privateKey = PrivateKey(content.toHexBytes())
                val publicKey = privateKey.getPublicKeySecp256k1(false)
                val address = AnyAddress(publicKey, coinType).description()
                val listWallet = ArrayList<WalletModel>()
                if (typeEarseWallet != Constant.TYPE_EARSE_WALLET) {
                    listWallet.addAll(appPreference.getListWallet())
                }
                if (listWallet.firstOrNull { it.walletAddress == address } == null) {
                    val walletName = "Account ${listWallet.size + 1}"
                    hasMap["walletAddress"] = address
                    listWallet.add(
                            0,
                            WalletModel(
                                    walletName,
                                    address,
                                    0,
                                    "",
                                    content,
                                    true
                            )
                    )
                    listWallet.forEachIndexed { index, walletModel ->
                        walletModel.walletIndex = index
                    }
                    appPreference.saveListWallet(listWallet)
                    hasMap["walletName"] = walletName
                    hasMap["code"] = Constant.CODE_SUCCESS
                    channel?.invokeMethod("importWalletCallback", hasMap)
                } else {
                    hasMap["walletAddress"] = ""
                    hasMap["walletName"] = ""
                    hasMap["code"] = Constant.CODE_ERROR_DUPLICATE
                    channel?.invokeMethod("importWalletCallback", hasMap)
                }
            }
            else -> {
                hasMap["walletAddress"] = ""
                hasMap["walletName"] = ""
                hasMap["code"] = Constant.CODE_ERROR
                channel?.invokeMethod("importWalletCallback", hasMap)
            }
        }
    } catch (e: InvalidParameterException) {
        hasMap["walletAddress"] = ""
        hasMap["walletName"] = ""
        hasMap["code"] = Constant.CODE_ERROR_WALLET
        channel?.invokeMethod("importWalletCallback", hasMap)
    }
}

fun Context.getListWallets(channel: MethodChannel?) {
    val appPreference = AppPreference(this)
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

fun Context.generateWallet(
        channel: MethodChannel?, typeEarseWallet: String
) {
    val appPreference = AppPreference(this)
    val coinType: CoinType = CoinType.SMARTCHAIN
    val wallet = HDWallet(128, "")
    val seedPhrase = wallet.mnemonic()
    val address = wallet.getAddressForCoin(coinType)
    val privateKey = ByteString.copyFrom(wallet.getKeyForCoin(coinType).data())
    val walletName =
            if (typeEarseWallet != Constant.TYPE_EARSE_WALLET) "Account ${appPreference.getListWallet().size + 1}" else "Account 1"

    val hasMap = HashMap<String, String>()
    hasMap["walletName"] = walletName
    hasMap["passPhrase"] = seedPhrase
    hasMap["walletAddress"] = address
    hasMap["privateKey"] = privateKey.toByteArray().toHexString(false)
    channel?.invokeMethod("generateWalletCallback", hasMap)
}

fun Context.storeWallet(
        channel: MethodChannel?,
        seedPhrase: String,
        walletName: String,
        walletAddress: String,
        privateKey: String,
        typeEarseWallet: String
) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Any>()
    hasMap["isSuccess"] = true
    val listWallet = ArrayList<WalletModel>()
    if (typeEarseWallet != Constant.TYPE_EARSE_WALLET) {
        listWallet.addAll(appPreference.getListWallet())
    }
    listWallet.add(
            0,
            WalletModel(
                    walletName,
                    walletAddress,
                    0,
                    seedPhrase,
                    privateKey,
                    false
            )
    )
    listWallet.forEachIndexed { index, walletModel ->
        walletModel.walletIndex = index
    }
    appPreference.saveListWallet(listWallet)
    channel?.invokeMethod("storeWalletCallback", hasMap)
}

fun Context.checkToken(channel: MethodChannel?, walletAddress: String, tokenAddress: String) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Any>()
    hasMap["isExist"] = appPreference.getListTokens()
            .firstOrNull {
                it.walletAddress == walletAddress && it.tokenAddress.lowercase(Locale.getDefault()) == tokenAddress && it.isShow
            } != null
    channel?.invokeMethod("checkTokenCallback", hasMap)
}

fun Context.importToken(
        channel: MethodChannel?,
        walletAddress: String,
        tokenAddress: String,
        tokenFullName: String,
        iconToken: String,
        symbol: String,
        decimal: Int,
        exchangeRate: Double,
        isImport: Boolean
) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Any>()
    val listTokens = ArrayList<TokenModel>()
    listTokens.addAll(appPreference.getListTokens())
    if (listTokens.firstOrNull {
                it.walletAddress == walletAddress && it.tokenAddress.lowercase(
                        Locale.getDefault()
                ) == tokenAddress
            } == null) {
        listTokens.add(
                TokenModel(
                        walletAddress,
                        tokenAddress,
                        tokenFullName,
                        iconToken,
                        symbol,
                        decimal,
                        exchangeRate,
                        true,
                        isImport
                )
        )
        appPreference.saveListTokens(listTokens)
    } else {
        listTokens.firstOrNull {
            it.walletAddress == walletAddress && it.tokenAddress.lowercase(
                    Locale.getDefault()
            ) == tokenAddress
        }?.isShow = true
    }
    hasMap["isSuccess"] = true
    appPreference.saveListTokens(listTokens)
    channel?.invokeMethod("importTokenCallback", hasMap)
}

fun Context.importListToken(
        channel: MethodChannel?,
        walletAddress: String,
        jsonTokens: String
) {
    val appPreference = AppPreference(this)
    val listAllToken = appPreference.getListTokens()
    val listTokenAddress = listAllToken.filter { it.walletAddress == walletAddress }
    val listTokenOther = listAllToken.filter { it.walletAddress != walletAddress }

    val listTokens = ArrayList<TokenModel>()
    val listObjectTokens = JSONArray(jsonTokens)
    var index = 0
    while (index < listObjectTokens.length()) {
        val data = listObjectTokens.getJSONObject(index)
        val tokenAddress = data.getString("tokenAddress").lowercase(Locale.getDefault())
        val symbol = data.getString("nameShortToken")
        val isImport = data.getBoolean("isImport")
        val tokenModel = TokenModel(
                walletAddress = data.getString("walletAddress"),
                tokenAddress = tokenAddress,
                tokenFullName = data.getString("nameToken"),
                iconUrl = data.getString("iconToken"),
                symbol = symbol,
                decimal = data.getInt("decimal"),
                exchangeRate = data.getDouble("exchangeRate"),
                isShow = tokenAddress == Constant.TOKEN_DFY_ADDRESS.lowercase(Locale.getDefault()) || tokenAddress == Constant.TOKEN_BNB_ADDRESS.lowercase(
                        Locale.getDefault()
                ),
                isImport = isImport
        )
        val tokenInCore =
                listTokenAddress.firstOrNull {
                    it.tokenAddress.lowercase(Locale.getDefault()) == tokenModel.tokenAddress.lowercase(
                            Locale.getDefault()
                    )
                }
        if (tokenInCore != null) {
            tokenModel.isShow = tokenInCore.isShow
        }
        when (tokenAddress) {
            Constant.TOKEN_DFY_ADDRESS.lowercase(Locale.getDefault()) -> {
                listTokens.add(0, tokenModel)
            }
            Constant.TOKEN_BNB_ADDRESS.lowercase(Locale.getDefault()) -> {
                listTokens.add(1, tokenModel)
            }
            else -> {
                listTokens.add(tokenModel)
            }
        }
        index++
    }
    val hasMap = HashMap<String, Any>()
    listTokenAddress.forEachIndexed { _, tokenModel ->
        val item = listTokens.firstOrNull {
            it.tokenAddress.lowercase(Locale.getDefault()) == tokenModel.tokenAddress.lowercase(
                    Locale.getDefault()
            )
        }
        if (item == null) {
            listTokens.add(tokenModel)
        }
    }
    listTokens.addAll(listTokenOther)
    appPreference.saveListTokens(listTokens)
    hasMap["isSuccess"] = true
    channel?.invokeMethod("importListTokenCallback", hasMap)
}

fun Context.getTokens(
        channel: MethodChannel?,
        walletAddress: String
) {
    val appPreference = AppPreference(this)
    val hasMap: ArrayList<HashMap<String, Any>> = ArrayList()
    appPreference.getListTokens().forEach {
        if (it.walletAddress == walletAddress) {
            val data = HashMap<String, Any>()
            data["walletAddress"] = it.walletAddress
            data["tokenFullName"] = it.tokenFullName
            data["symbol"] = it.symbol
            data["tokenAddress"] = it.tokenAddress.lowercase(Locale.getDefault())
            data["iconUrl"] = it.iconUrl
            data["isShow"] = it.isShow
            data["decimal"] = it.decimal
            data["exchangeRate"] = it.exchangeRate
            data["isImport"] = it.isImport
            hasMap.add(data)
        }
    }
    channel?.invokeMethod("getTokensCallback", hasMap)
}

fun Context.deleteNft(
        channel: MethodChannel?,
        walletAddress: String,
        collectionAddress: String,
        nftId: String
) {
    val appPreference = AppPreference(this)
    val listCollection = ArrayList<NftModel>()
    var isDeleteSuccess = false
    appPreference.getListNft().forEach { it ->
        if (it.walletAddress == walletAddress && it.collectionAddress == collectionAddress) {
            val data = NftModel()
            data.walletAddress = walletAddress
            data.collectionAddress = collectionAddress
            data.nftName = it.nftName
            data.symbol = it.symbol
            val listNft = ArrayList<ItemNftModel>()
            it.item.forEach {
                if (it.id == nftId) {
                    isDeleteSuccess = true
                } else {
                    listNft.add(it)
                }
            }
            if (listNft.isNotEmpty()) {
                data.item.addAll(listNft)
                listCollection.add(data)
            }
        } else {
            listCollection.add(it)
        }
    }
    appPreference.saveListNft(listCollection)
    val data = HashMap<String, Any>()
    data["isSuccess"] = isDeleteSuccess
    channel?.invokeMethod("setDeleteNftCallback", data)
}

fun Context.deleteCollection(
        channel: MethodChannel?,
        walletAddress: String,
        collectionAddress: String
) {
    val appPreference = AppPreference(this)
    val listNft = ArrayList<NftModel>()
    var isDeleteSuccess = false
    val listCollectionInLocal = appPreference.getListNft()
    listCollectionInLocal.forEach {
        if (it.walletAddress == walletAddress) {
            if (collectionAddress == it.collectionAddress) {
                isDeleteSuccess = true
            } else {
                listNft.add(it)
            }
        }
    }
    listNft.addAll(listCollectionInLocal.filter { it.walletAddress != walletAddress })
    appPreference.saveListNft(listNft)
    val data = HashMap<String, Any>()
    data["isSuccess"] = isDeleteSuccess
    channel?.invokeMethod("setDeleteCollectionCallback", data)
}

fun Context.getNFT(
        channel: MethodChannel?,
        walletAddress: String
) {
    val appPreference = AppPreference(this)
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

fun Context.setShowedToken(
        channel: MethodChannel?,
        walletAddress: String,
        tokenAddress: String,
        isShow: Boolean,
        isImport: Boolean
) {
    val appPreference = AppPreference(this)
    val hasMap = HashMap<String, Any>()
    if (tokenAddress != Constant.TOKEN_DFY_ADDRESS.lowercase(Locale.getDefault()) || tokenAddress != Constant.TOKEN_BNB_ADDRESS.lowercase(
                    Locale.getDefault()
            )
    ) {
        val listToken = ArrayList<TokenModel>()
        if (isImport) {
            appPreference.getListTokens().forEach {
                if (it.walletAddress != walletAddress || it.tokenAddress.lowercase(Locale.getDefault()) != tokenAddress
                ) {
                    listToken.add(it)
                }
            }
        } else {
            listToken.addAll(appPreference.getListTokens())
            listToken.firstOrNull {
                it.walletAddress == walletAddress && it.tokenAddress.lowercase(
                        Locale.getDefault()
                ) == tokenAddress
            }?.isShow =
                    isShow
        }
        appPreference.saveListTokens(listToken)
        hasMap["isSuccess"] = true
    } else {
        hasMap["isSuccess"] = false
    }
    channel?.invokeMethod("setShowedTokenCallback", hasMap)
}

fun Context.importNft(
        channel: MethodChannel?,
        jsonNft: String,
        walletAddress: String
) {
    var code = Constant.CODE_SUCCESS
    val appPreference = AppPreference(this)
    val listCollectionSupport = ArrayList<NftModel>()

    val objectNft = JSONObject(jsonNft)

    val listAllCollection = appPreference.getListNft()
    val checkAddress = listAllCollection.firstOrNull { it.walletAddress == walletAddress }
    if (checkAddress == null) {
        val nftModel = NftModel()
        nftModel.walletAddress = walletAddress
        nftModel.collectionAddress = objectNft.getString("contract")
        nftModel.nftName = objectNft.getString("name")
        nftModel.symbol = objectNft.getString("symbol")
        val listNftJson = objectNft.getJSONArray("listNft")
        var size = 0
        val listNft = ArrayList<ItemNftModel>()
        while (size < listNftJson.length()) {
            val data = listNftJson.getJSONObject(size)
            listNft.add(
                    ItemNftModel(
                            id = data.getString("id"),
                            contract = data.getString("contract"),
                            uri = data.getString("uri")
                    )
            )
            size++
        }
        nftModel.item.addAll(listNft)
        listCollectionSupport.add(nftModel)
        listCollectionSupport.addAll(listAllCollection.filter { it.walletAddress != walletAddress })
    } else {
        val contractNft = objectNft.getString("contract")
        if (checkAddress.collectionAddress == contractNft) {
            val nftModel = NftModel()
            nftModel.walletAddress = walletAddress
            nftModel.collectionAddress = contractNft
            nftModel.nftName = objectNft.getString("name")
            nftModel.symbol = objectNft.getString("symbol")
            val listNftJson = objectNft.getJSONArray("listNft")
            var size = 0
            val listNft = ArrayList<ItemNftModel>()
            while (size < listNftJson.length()) {
                val data = listNftJson.getJSONObject(size)
                val id = data.getString("id")
                if (checkAddress.item.firstOrNull { it.id == id } == null) {
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
            code = if (listNft.isEmpty()) Constant.CODE_ERROR_DUPLICATE else Constant.CODE_SUCCESS
            val listNftLocal = ArrayList<ItemNftModel>()
            checkAddress.item.forEach { item ->
                if (listNft.firstOrNull { it.id == item.id } == null) {
                    listNftLocal.add(item)
                }
            }
            nftModel.item.addAll(listNft)
            nftModel.item.addAll(listNftLocal)
            listCollectionSupport.add(nftModel)
            listCollectionSupport.addAll(listAllCollection.filter { it.walletAddress != walletAddress })
        } else {
            val nftModel = NftModel()
            nftModel.walletAddress = walletAddress
            nftModel.collectionAddress = contractNft
            nftModel.nftName = objectNft.getString("name")
            nftModel.symbol = objectNft.getString("symbol")
            val listNftJson = objectNft.getJSONArray("listNft")
            var size = 0
            val listNft = ArrayList<ItemNftModel>()
            while (size < listNftJson.length()) {
                val data = listNftJson.getJSONObject(size)
                listNft.add(
                        ItemNftModel(
                                id = data.getString("id"),
                                contract = data.getString("contract"),
                                uri = data.getString("uri")
                        )
                )
                size++
            }
            nftModel.item.addAll(listNft)
            listCollectionSupport.add(nftModel)
            listCollectionSupport.addAll(listAllCollection.filter { it.collectionAddress != contractNft })
        }
    }
    val hasMap = HashMap<String, Any>()
    appPreference.saveListNft(listCollectionSupport)
    hasMap["code"] = code
    channel?.invokeMethod("importNftCallback", hasMap)
}

fun Context.signTransactionToken(
        channel: MethodChannel?,
        walletAddress: String,
        tokenAddress: String,
        toAddress: String,
        nonce: String,
        chainId: String,
        gasPrice: String,
        gasLimit: String,
        gasFee: String,
        amount: String,
        symbol: String
) {
    val hasMap = HashMap<String, Any>()
    val walletModel =
            AppPreference(this).getListWallet().firstOrNull { it.walletAddress == walletAddress }
    if (walletModel != null && walletModel.privateKey.isNotEmpty()) {
        val signerInput = when (tokenAddress) {
            Constant.TOKEN_BNB_ADDRESS -> {
                Ethereum.SigningInput.newBuilder().apply {
                    this.nonce = ByteString.copyFrom(BigInteger(nonce).toByteArray())
                    this.chainId = ByteString.copyFrom(BigInteger(chainId).toByteArray())
                    this.gasPrice = BigInteger(
                            gasPrice.handleAmount(decimal = 9)
                    ).toByteString() // decimal 3600000000
                    this.gasLimit = BigInteger(
                            gasLimit
                    ).toByteString()     // decimal 21000
                    this.toAddress = toAddress
                    this.transaction = Ethereum.Transaction.newBuilder().apply {
                        transfer = Ethereum.Transaction.Transfer.newBuilder().apply {
                            this.amount =
                                    BigInteger(amount.handleAmount(decimal = 18)).toByteString()
                        }.build()
                    }.build()
                    this.privateKey =
                            ByteString.copyFrom(PrivateKey(walletModel.privateKey.toHexBytes()).data())
                }.build()
            }
            else -> {
                Ethereum.SigningInput.newBuilder().apply {
                    this.nonce = ByteString.copyFrom(BigInteger(nonce).toByteArray())
                    this.chainId = ByteString.copyFrom(BigInteger(chainId).toByteArray())
                    this.gasPrice = BigInteger(
                            gasPrice.handleAmount(decimal = 9)
                    ).toByteString() // decimal 3600000000
                    this.gasLimit = BigInteger(
                            gasLimit
                    ).toByteString()     // decimal 21000
                    this.toAddress = tokenAddress
                    this.transaction = Ethereum.Transaction.newBuilder().apply {
                        erc20Transfer = Ethereum.Transaction.ERC20Transfer.newBuilder().apply {
                            this.to = toAddress
                            this.amount =
                                    BigInteger(amount.handleAmount(decimal = 18)).toByteString()
                        }.build()
                    }.build()
                    this.privateKey =
                            ByteString.copyFrom(PrivateKey(walletModel.privateKey.toHexBytes()).data())
                }.build()
            }
        }
        val output =
                AnySigner.sign(signerInput, CoinType.SMARTCHAIN, Ethereum.SigningOutput.parser())
        val value = output.encoded.toByteArray().toHexString(false)
        hasMap["isSuccess"] = true
        hasMap["signedTransaction"] = value
    } else {
        hasMap["isSuccess"] = false
        hasMap["signedTransaction"] = ""
    }
    hasMap["walletAddress"] = walletAddress
    hasMap["toAddress"] = toAddress
    hasMap["tokenAddress"] = tokenAddress
    hasMap["nonce"] = nonce
    hasMap["chainId"] = chainId
    hasMap["gasPrice"] = gasPrice
    hasMap["gasLimit"] = gasLimit
    hasMap["gasFee"] = gasFee
    hasMap["amount"] = amount
    hasMap["symbol"] = symbol
    channel?.invokeMethod("signTransactionTokenCallback", hasMap)
}

fun Context.signTransactionNft(
        channel: MethodChannel?,
        walletAddress: String,
        tokenAddress: String,
        toAddress: String,
        nonce: String,
        chainId: String,
        gasPrice: String,
        gasLimit: String,
        tokenId: String,
        gasFee: String,
        amount: String,
        symbol: String,
) {
    val hasMap = HashMap<String, Any>()
    val walletModel =
            AppPreference(this).getListWallet().firstOrNull { it.walletAddress.lowercase(Locale.getDefault()) == walletAddress.lowercase(Locale.getDefault()) }
    if (walletModel != null && walletModel.privateKey.isNotEmpty()) {
        val signingInput = Ethereum.SigningInput.newBuilder().apply {
            this.privateKey =
                    ByteString.copyFrom(PrivateKey(walletModel.privateKey.toHexBytes()).data())
            this.toAddress = tokenAddress
            this.chainId = ByteString.copyFrom(BigInteger(chainId).toByteArray())
            this.nonce = ByteString.copyFrom(BigInteger(nonce).toByteArray())
            this.gasPrice = BigInteger(
                    gasPrice
            ).toByteString()
            this.gasLimit = BigInteger(
                    gasLimit
            ).toByteString()
            transaction = Ethereum.Transaction.newBuilder().apply {
                erc721Transfer = Ethereum.Transaction.ERC721Transfer.newBuilder().apply {
                    this.from = walletAddress
                    this.to = toAddress
                    this.tokenId = BigInteger(tokenId).toByteString()
                }.build()
            }.build()
        }

        val output =
                AnySigner.sign(
                        signingInput.build(),
                        CoinType.SMARTCHAIN,
                        Ethereum.SigningOutput.parser()
                )
        val value = output.encoded.toByteArray().toHexString(false)
        hasMap["isSuccess"] = true
        hasMap["signedTransaction"] = value
    } else {
        hasMap["isSuccess"] = false
        hasMap["signedTransaction"] = ""
    }
    hasMap["walletAddress"] = walletAddress
    hasMap["toAddress"] = toAddress
    hasMap["collectionAddress"] = tokenAddress
    hasMap["nonce"] = nonce
    hasMap["chainId"] = chainId
    hasMap["gasPrice"] = gasPrice
    hasMap["gasLimit"] = gasLimit
    hasMap["gasFee"] = gasFee
    hasMap["amount"] = amount
    hasMap["symbol"] = symbol
    hasMap["nftId"] = tokenId
    channel?.invokeMethod("signTransactionNftCallback", hasMap)
}

fun Context.signTransactionWithData(
        channel: MethodChannel?,
        walletAddress: String,
        contractAddress: String,
        nonce: String,
        chainId: String,
        gasPrice: String,
        gasLimit: String,
        withData: String
) {
    val hasMap = HashMap<String, Any>()
    val walletModel =
            AppPreference(this).getListWallet().firstOrNull { it.walletAddress == walletAddress }
    if (walletModel != null && walletModel.privateKey.isNotEmpty()) {
        val signerInput = Ethereum.SigningInput.newBuilder().apply {
            this.nonce = ByteString.copyFrom(BigInteger(nonce).toByteArray())
            this.chainId = ByteString.copyFrom(BigInteger(chainId).toByteArray())
            this.gasPrice = BigInteger(
                    gasPrice.handleAmount(decimal = 9)
            ).toByteString()
            this.gasLimit = BigInteger(
                    gasLimit
            ).toByteString()
            this.toAddress = contractAddress
            this.transaction = Ethereum.Transaction.newBuilder().apply {
                transfer = Ethereum.Transaction.Transfer.newBuilder().apply {
                    this.amount = BigInteger("0").toByteString()
                    this.data = ByteString.copyFrom((withData).hexStringToByteArray())
                }.build()
            }.build()
            this.privateKey =
                    ByteString.copyFrom(PrivateKey(walletModel.privateKey.toHexBytes()).data())
        }.build()
        val output =
                AnySigner.sign(signerInput, CoinType.SMARTCHAIN, Ethereum.SigningOutput.parser())
        val value = output.encoded.toByteArray().toHexString(false)
        hasMap["isSuccess"] = true
        hasMap["signedTransaction"] = value
    } else {
        hasMap["isSuccess"] = false
        hasMap["signedTransaction"] = ""
    }
    hasMap["walletAddress"] = walletAddress
    hasMap["contractAddress"] = contractAddress
    hasMap["nonce"] = nonce
    hasMap["chainId"] = chainId
    hasMap["gasPrice"] = gasPrice
    hasMap["gasLimit"] = gasLimit
    hasMap["withData"] = withData
    channel?.invokeMethod("signTransactionWithDataCallback", hasMap)
}

fun Context.signWallet(
        channel: MethodChannel?,
        walletAddress: String,
        bytesSha3: ByteArray
) {
    val hasMap = HashMap<String, Any>()
    val walletModel =
            AppPreference(this).getListWallet().firstOrNull { it.walletAddress == walletAddress }
    if (walletModel != null && walletModel.privateKey.isNotEmpty()) {
        val privateKey = PrivateKey(walletModel.privateKey.toHexBytes())
        val originalMessageHashInHexCore =
                privateKey.sign(
                        bytesSha3,
                        Curve.SECP256K1
                ).toHexString(false)
        val firstKey =
                originalMessageHashInHexCore.subSequence(
                        originalMessageHashInHexCore.length - 2,
                        originalMessageHashInHexCore.length
                )
                        .toString().toInt()
        val signature = StringBuilder()
        signature.append(
                originalMessageHashInHexCore.subSequence(
                        0,
                        originalMessageHashInHexCore.length - 2
                )
        ).append(if (firstKey % 2 == 0) "1b" else "1c")
        hasMap["signature"] = signature.toString()
    } else {
        hasMap["signature"] = ""
    }
    channel?.invokeMethod("signWalletCallback", hasMap)
}
