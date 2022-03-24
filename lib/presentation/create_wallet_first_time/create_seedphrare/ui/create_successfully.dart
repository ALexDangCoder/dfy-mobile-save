import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/main_screen/bloc/main_cubit.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_switch_applock.dart';
import 'package:Dfy/widgets/form/form_switch_face.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


enum KeyType { IMPORT, CREATE, IMPORT_HAVE_WALLET, CREATE_HAVE_WALLET }

class CreateSuccessfully extends StatefulWidget {
  const CreateSuccessfully({
    Key? key,
    required this.bLocCreateSeedPhrase,
    required this.wallet,
    required this.type,
    required this.passWord,
    this.isFromConnectWlDialog = false,
  }) : super(key: key);
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;
  final Wallet wallet;
  final KeyType type;
  final String passWord;
  final bool isFromConnectWlDialog;

  @override
  State<CreateSuccessfully> createState() => _CreateSuccessfullyState();
}

class _CreateSuccessfullyState extends State<CreateSuccessfully> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 16.h),
        color: AppTheme.getInstance().bgBtsColor(),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  index: walletInfoIndex,
                  wallet: widget.wallet,
                ),
              ),
            );
            widget.bLocCreateSeedPhrase.setConfig(
              isAppLock: widget.bLocCreateSeedPhrase.isCheckAppLock.value,
              isFaceID: widget.bLocCreateSeedPhrase.isCheckTouchID.value,
            );
            widget.bLocCreateSeedPhrase.savePassword(password: widget.passWord);
          },
          child: Container(
            margin: EdgeInsets.only(
              bottom: 38.h,
            ),
            child: ButtonGold(
              title: S.current.complete,
              isEnable: true,
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 8.h,
          ),
          _Body(
            bLocCreateSeedPhrase: widget.bLocCreateSeedPhrase,
            type: widget.type,
            wallet: widget.wallet,
            passWord: widget.passWord,
          )
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    required this.bLocCreateSeedPhrase,
    required this.wallet,
    required this.type,
    required this.passWord,
  }) : super(key: key);
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;
  final Wallet wallet;
  final KeyType type;
  final String passWord;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final MainCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = MainCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 812.h,
      width: 375.w,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 18.h,
          ),
          Center(
            child: Text(
              widget.type == KeyType.CREATE
                  ? S.current.success
                  : S.current.success_import,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                20,
                FontWeight.bold,
              ),
            ),
          ),
          spaceH20,
          line,
          spaceH24,
          SizedBox(
            height: 228.h,
            width: 305.w,
            child: Image.asset(ImageAssets.frameGreen),
          ),
          SizedBox(
            height: 22.h,
          ),
          Text(
            S.current.congratulation,
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              32,
              FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 111.h,
          ),
          StreamBuilder(
            stream: widget.bLocCreateSeedPhrase.isCheckTouchID,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return FromSwitchFace(
                bLocCreateSeedPhrase: widget.bLocCreateSeedPhrase,
                title: S.current.use_face,
                isCheck: snapshot.data ?? false,
                urlPrefixIcon: ImageAssets.ic_face_id,
              );
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          StreamBuilder(
            stream: widget.bLocCreateSeedPhrase.isCheckAppLock,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return FromSwitchAppLock(
                bLocCreateSeedPhrase: widget.bLocCreateSeedPhrase,
                title: S.current.wallet_app_lock,
                isCheck: snapshot.data ?? false,
                urlPrefixIcon: ImageAssets.ic_lock,
              );
            },
          ),
        ],
      ),
    );
  }
}
