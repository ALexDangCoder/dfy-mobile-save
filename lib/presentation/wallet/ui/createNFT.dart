import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_nft_screen.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/widgets/views/coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNFT extends StatelessWidget {
  final WalletCubit walletCubit;

  const CreateNFT({
    Key? key,
    required this.title,
    required this.icon,
    required this.walletCubit,
  }) : super(key: key);

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CreateNFTScreen(
                cubit: CreateNftCubit(),
              );
            },
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage(icon),
                    color: const Color(0xFFE4AC1A),
                    size: 20.sp,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    title,
                    style: textNormalCustom(
                      const Color(0xFFE4AC1A),
                      16.sp,
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
