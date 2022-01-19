import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/token_detail.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/widgets/dialog_remove/remove_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TokenItem extends StatelessWidget {
  TokenItem({
    Key? key,
    required this.index,
    required this.bloc,
    required this.modelToken,
    required this.walletAddress,
  }) : super(key: key);

  final ModelToken modelToken;
  final int index;
  final WalletCubit bloc;
  final String walletAddress;
  final formatUSD = NumberFormat('\$ ###,###,###.###', 'en_US');
  final formatBalance = NumberFormat('###,###,###.######', 'en_US');

  @override
  Widget build(BuildContext context) {
    final String price =
        formatUSD.format(modelToken.balanceToken * modelToken.exchangeRate);
    return MaterialButton(
      padding: EdgeInsets.zero,
      onLongPress: () {
        if (modelToken.nameShortToken != 'DFY' &&
            modelToken.nameShortToken != 'BNB') {
          Navigator.of(context).push(
            HeroDialogRoute(
              builder: (context) {
                return RemoveToken(
                  cubit: bloc,
                  index: index,
                );
              },
              isNonBackground: false,
            ),
          );
        }
      },
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TokenDetail(
              walletAddress: walletAddress,
              token: modelToken,
              walletName: bloc.nameWallet,
              bloc: TokenDetailBloc(
                walletAddress: walletAddress,
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Divider(
            height: 1.h,
            color: const Color(0xFF4b4a60),
          ),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 19.h,
                    left: 20.w,
                  ),
                  child: modelToken.iconToken.isEmpty
                      ? CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 14.r,
                          child: Center(
                            child: Text(
                              modelToken.nameShortToken.substring(0, 1),
                              style: textNormalCustom(
                                Colors.black,
                                20,
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      : Image(
                          image: NetworkImage(modelToken.iconToken),
                          width: 28.w,
                          height: 28.h,
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 10.w,
                    bottom: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${formatBalance.format(modelToken.balanceToken)} '
                        '${modelToken.nameShortToken}',
                        style: textNormalCustom(
                          Colors.white,
                          20,
                          FontWeight.w600,
                        ),
                      ),
                      Text(
                        price,
                        style: textNormalCustom(
                          Colors.grey.shade400,
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
