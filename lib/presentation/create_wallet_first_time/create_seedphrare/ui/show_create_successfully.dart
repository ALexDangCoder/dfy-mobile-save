import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/main_screen/bloc/main_cubit.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_switch.dart';
import 'package:Dfy/widgets/form/form_switch1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum KeyType { IMPORT, CREATE }

void showCreateSuccessfully({
  required BuildContext context,
  required BLocCreateSeedPhrase bLocCreateSeedPhrase,
  required Wallet wallet,
  required KeyType type,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Body(
        bLocCreateSeedPhrase: bLocCreateSeedPhrase,
        type: type,
        wallet: wallet,
      );
    },
  );
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.bLocCreateSeedPhrase,
    required this.wallet,
    required this.type,
  }) : super(key: key);
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;
  final Wallet wallet;
  final KeyType type;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final MainCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = MainCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 764.h,
      width: 375.w,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        color: const Color(0xff3e3d5c),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.h),
          topRight: Radius.circular(30.h),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18.h,
          ),
          Center(
            child: Text(
              widget.type == KeyType.CREATE
                  ? S.current.success
                  : S.current.success_import,
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          spaceH20,
          line,
          spaceH24,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(ImageAssets.icFrame),
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    S.current.congratulation,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                    ),
                  ),
                  SizedBox(
                    height: 111.h,
                  ),
                  StreamBuilder(
                    stream: widget.bLocCreateSeedPhrase.isCheckTouchID,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      return FromSwitch1(
                        bLocCreateSeedPhrase: widget.bLocCreateSeedPhrase,
                        title: S.current.use_face,
                        isCheck: snapshot.data ?? false,
                        urlPrefixIcon: ImageAssets.icFace,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  StreamBuilder(
                    stream: widget.bLocCreateSeedPhrase.isCheckAppLock,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      return FromSwitch(
                        bLocCreateSeedPhrase: widget.bLocCreateSeedPhrase,
                        title: S.current.wallet_app_lock,
                        isCheck: snapshot.data ?? false,
                        urlPrefixIcon: ImageAssets.icPassword,
                      );
                    },
                  ),
                  SizedBox(
                    height: 56.h,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                //Navigator.popAndPushNamed(context,AppRouter.login);
                //cubit.walletSink.add(2);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      index: 1,
                    ),
                  ),
                  (route) => false,
                );
                widget.bLocCreateSeedPhrase.setConfig(
                  password: widget.bLocCreateSeedPhrase.passWord,
                  isAppLock: widget.bLocCreateSeedPhrase.isCheckAppLock.value,
                  isFaceID: widget.bLocCreateSeedPhrase.isCheckTouchID.value,
                );
              },
              child: ButtonGold(
                title: S.current.complete,
                isEnable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
