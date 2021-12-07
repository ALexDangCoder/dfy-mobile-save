import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/ui/import_nft.dart';
import 'package:Dfy/presentation/import_token_nft/ui/import_token.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImportToken extends StatelessWidget {
  const ImportToken({
    Key? key,
    required this.title,
    required this.icon,
    required this.keyRouter,
    required this.addressWallet,
    required this.cubit,
  }) : super(key: key);

  final int keyRouter;
  final String title;
  final String icon;
  final String addressWallet;
  final WalletCubit cubit;

  @override
  Widget build(BuildContext context) {
    void _checkKey() {
      switch (keyRouter) {
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ImportTokenScreen(
                  bloc: cubit,
                  addressWallet: addressWallet,
                );
              },
            ),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ImportNft(
                  bloc: WalletCubit(),
                );
              },
            ),
          );
          break;
      }
    }

    return GestureDetector(
      onTap: () {
        _checkKey();
      },
      child: Column(
        children: [
          Divider(
            height: 1.h,
            color: const Color(0xFF4b4a60),
          ),
          SizedBox(
            height: 60.h,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage(icon),
                    color: const Color(0xFFE4AC1A),
                    size: 24,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    title,
                    style: textNormalCustom(
                      const Color(0xFFE4AC1A),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1.h,
            color: const Color(0xFF4b4a60),
          ),
        ],
      ),
    );
  }
}
