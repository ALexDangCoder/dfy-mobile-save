// Copyright © 2017-2021 Trust Wallet.
//
// This file is part of Trust. The full Trust copyright notice, including
// terms governing use, modification, and redistribution, is contained in the
// file LICENSE at the root of the source code distribution tree.
//
// This is a GENERATED FILE, changes made here WILL BE LOST.
//

package wallet.core.jni;

import java.security.InvalidParameterException;

public class EthereumFee {
    private byte[] bytes;

    private EthereumFee() {
    }

    static EthereumFee createFromNative(byte[] bytes) {
        EthereumFee instance = new EthereumFee();
        instance.bytes = bytes;
        return instance;
    }


    public static native String suggest(String feeHistory);

}
