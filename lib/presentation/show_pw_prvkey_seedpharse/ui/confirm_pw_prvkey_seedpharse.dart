import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/ui/private_key_seed_phrase.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

class ConfirmPWShowPRVSeedPhr extends StatefulWidget {
  const ConfirmPWShowPRVSeedPhr({required this.cubit, Key? key})
      : super(key: key);
  final ConfirmPwPrvKeySeedpharseCubit cubit;

  @override
  _ConfirmPWShowPRVSeedPhrState createState() =>
      _ConfirmPWShowPRVSeedPhrState();
}

class _ConfirmPWShowPRVSeedPhrState extends State<ConfirmPWShowPRVSeedPhr> {
  late TextEditingController txtController;
  bool isFaceIdWalletCore = false;

  @override
  void initState() {
    widget.cubit.getListWallets();
    txtController = TextEditingController();
    widget.cubit.getConfig();
    trustWalletChannel.setMethodCallHandler(
      widget.cubit.nativeMethodCallBackTrustWallet,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfirmPwPrvKeySeedpharseCubit,
        ConfirmPwPrvKeySeedpharseState>(
      listener: (context, state) {
          if (state is ConfirmPWToShowSuccess) {
          widget.cubit.getListPrivateKeyAndSeedPhrase(
            password: isFaceIdWalletCore ? '' : txtController.text,
            isFaceId: isFaceIdWalletCore,
          );
          widget.cubit.listPrivateKey.sink.add(widget.cubit.listWallet);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PrivateKeySeedPhrase(
                bloc: widget.cubit,
              ),
            ),
          ).whenComplete(() => txtController.clear());
        } else {
          _showDialog(
            alert: S.current.password_is_not_correct,
          );
        }
      },
      bloc: widget.cubit,
      builder: (context, state) {
        return BaseDesignScreen(
          title: S.current.prv_key_ft_seed_phr,
          text: ImageAssets.ic_close,
          isImage: true,
          onRightClick: () {
            Navigator.pop(context);
          },
          child: Column(
            children: [
              spaceH24,
              formSetupPassWordConfirm(
                hintText: S.current.enter_password,
                controller: txtController,
                isShow: true,
              ),
              showTextValidatePW(),
              SizedBox(
                height: 40.h,
              ),
              StreamBuilder<bool>(
                stream: widget.cubit.isEnableBtnStream,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () {
                      if (snapshot.data!) {
                        widget.cubit
                            .checkPassword(password: txtController.text);
                      }
                    },
                    child: ButtonGold(
                      title: S.current.continue_s,
                      isEnable: snapshot.data ?? false,
                    ),
                  );
                },
              ),
              //todo handel scan finger or faceID, done
              spaceH40,
              StreamBuilder<bool>(
                stream: widget.cubit.isSuccessWhenScanStream,
                builder: (context, snapshot) {
                  return Visibility(
                    child: GestureDetector(
                      onTap: () async {
                        await widget.cubit
                            .authenticate(); //todo change stream not bloc
                        if (snapshot.data == true) {
                          isFaceIdWalletCore = true;
                          widget.cubit
                              .scanFaceIdFinger(value: isFaceIdWalletCore);
                        } else {
                          //nothing
                        }
                      },
                      child: Platform.isIOS
                          ? const Image(
                              image: AssetImage(ImageAssets.ic_face_id),
                            )
                          : const Image(
                              image: AssetImage(ImageAssets.ic_finger),
                            ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        );
      },
    );
  }

  Container formSetupPassWordConfirm({
    required String hintText,
    required TextEditingController controller,
    required bool isShow,
  }) {
    int index = 0;
    return Container(
      height: 64.h,
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: StreamBuilder<bool>(
        stream: widget.cubit.showPWStream,
        builder: (context, snapshot) {
          return Center(
            child: TextFormField(
              onChanged: (value) {
                widget.cubit.checkValidate(
                  value,
                );
                widget.cubit.isEnableButton(
                  value: value,
                );
              },
              style: textNormal(
                Colors.white,
                16,
              ),
              textAlignVertical: TextAlignVertical.center,
              obscureText: snapshot.data ?? true,
              cursorColor: Colors.white,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: textNormal(
                  Colors.grey,
                  14,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    if (index == 0) {
                      index = 1;
                      widget.cubit.showPW(0);
                    } else {
                      index = 0;
                      widget.cubit.showPW(1);
                    }
                  },
                  child: snapshot.data ?? false
                      ? const ImageIcon(
                          AssetImage(ImageAssets.ic_show),
                          color: Colors.grey,
                        )
                      : const ImageIcon(
                          AssetImage(ImageAssets.ic_hide),
                          color: Colors.grey,
                        ),
                ),
                prefixIcon: const ImageIcon(
                  AssetImage(ImageAssets.ic_lock),
                  color: Colors.white,
                ),
                border: InputBorder.none,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showTextValidatePW() {
    return StreamBuilder(
      stream: widget.cubit.showValidatePWStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 343.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  stream: widget.cubit.txtWarningValidateStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormalCustom(
                        const Color.fromRGBO(255, 108, 108, 1),
                        12,
                        FontWeight.w400,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog({String? alert, String? text}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                36.0.r,
              ),
            ),
          ),
          backgroundColor: AppTheme.getInstance().selectDialogColor(),
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  alert ?? S.current.password_is_not_correct,
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              spaceH16,
              Text(
                text ?? S.current.please_try_again,
                style: textNormalCustom(
                  Colors.white,
                  12,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Divider(
              height: 1.h,
              color: AppTheme.getInstance().divideColor(),
            ),
            Center(
              child: TextButton(
                child: Text(
                  S.current.ok,
                  style: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
                    20,
                    FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
