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

public class THORChainSwap {
    private byte[] bytes;

    private THORChainSwap() {
    }

    static THORChainSwap createFromNative(byte[] bytes) {
        THORChainSwap instance = new THORChainSwap();
        instance.bytes = bytes;
        return instance;
    }


    public static native byte[] buildSwap(byte[] input);

}
