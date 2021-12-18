// Copyright © 2017-2021 Trust Wallet.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
//
// This is a GENERATED FILE, changes made here WILL BE LOST.
//

package wallet.core.jni;


public enum EthereumChainID {
    ETHEREUM (1),
    GO (60),
    POA (99),
    CALLISTO (820),
    ETHEREUMCLASSIC (61),
    VECHAIN (74),
    THUNDERTOKEN (108),
    TOMOCHAIN (88),
    BINANCESMARTCHAIN (97),
    POLYGON (137),
    WANCHAIN (888),
    OPTIMISM (10),
    ARBITRUM (42161),
    HECO (128),
    AVALANCHE (43114),
    XDAI (100),
    FANTOM (250),
    CELO (42220),
    RONIN (2020);

    private final int value;
    EthereumChainID(int value) {
        this.value = value;
    }
    public int value() { return value; }

    public static EthereumChainID createFromValue(int value) {
        switch (value) {
            case 1: return EthereumChainID.ETHEREUM;
            case 60: return EthereumChainID.GO;
            case 99: return EthereumChainID.POA;
            case 820: return EthereumChainID.CALLISTO;
            case 61: return EthereumChainID.ETHEREUMCLASSIC;
            case 74: return EthereumChainID.VECHAIN;
            case 108: return EthereumChainID.THUNDERTOKEN;
            case 88: return EthereumChainID.TOMOCHAIN;
            case 97: return EthereumChainID.BINANCESMARTCHAIN;
            case 137: return EthereumChainID.POLYGON;
            case 888: return EthereumChainID.WANCHAIN;
            case 10: return EthereumChainID.OPTIMISM;
            case 42161: return EthereumChainID.ARBITRUM;
            case 128: return EthereumChainID.HECO;
            case 43114: return EthereumChainID.AVALANCHE;
            case 100: return EthereumChainID.XDAI;
            case 250: return EthereumChainID.FANTOM;
            case 42220: return EthereumChainID.CELO;
            case 2020: return EthereumChainID.RONIN;
            default: return null;
        }
    }

}
