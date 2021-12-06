import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/bloc/private_key_seed_phrase_bloc.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/ui/private_key_seed_phrase.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPWShowPRVSeedPhr extends StatefulWidget {
  const ConfirmPWShowPRVSeedPhr({required this.cubit, Key? key})
      : super(key: key);
  final ConfirmPwPrvKeySeedpharseCubit cubit;

  @override
  _ConfirmPWShowPRVSeedPhrState createState() =>
      _ConfirmPWShowPRVSeedPhrState();
}

class _ConfirmPWShowPRVSeedPhrState extends State<ConfirmPWShowPRVSeedPhr> {
  String password = 'Huydepzai1102.';
  late TextEditingController txtController;

  @override
  void initState() {
    txtController = TextEditingController();
    print(Platform.isIOS);
    widget.cubit.getConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.prv_key_ft_seed_phr,
      text: ImageAssets.ic_close,
      isImage: true,
      callback: () {
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
          // cubit.isEnableBtnStream,
          StreamBuilder<bool>(
            stream: widget.cubit.isEnableBtnStream,
            builder: (context, snapshot) {
              return GestureDetector(
                onTap: () {
                  if (snapshot.data ?? false) {
                    widget.cubit.checkValidate(
                      txtController.text,
                      rightPW: password,
                    );
                    if (widget.cubit.isValidPW) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PrivateKeySeedPhrase(
                              bloc: PrivateKeySeedPhraseBloc(),
                            );
                          },
                        ),
                      );
                    } else {
                      //nothing
                    }
                  }
                },
                child: ButtonGold(
                  title: S.current.continue_s,
                  isEnable: snapshot.data ?? false,
                ),
              );
            },
          ),
          SizedBox(
            height: 40.h,
          ),

          //todo handel scan finger or faceID
          StreamBuilder<bool>(
            stream: widget.cubit.isSuccessWhenScanStream,
            builder: (context, snapshot) {
              return Visibility(
                child: GestureDetector(
                  onTap: () async {
                    await widget.cubit
                        .authenticate(); //todo change stream not bloc
                    if (snapshot.data == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PrivateKeySeedPhrase(
                              bloc: PrivateKeySeedPhraseBloc(),
                            );
                          },
                        ),
                      );
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
          )
        ],
      ),
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
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: StreamBuilder<bool>(
          stream: widget.cubit.showPWStream,
          builder: (context, snapshot) {
            return TextFormField(
              onChanged: (value) {
                widget.cubit.isEnableButton(
                  value: value,
                );
              },
              style: textNormal(
                Colors.white,
                16,
              ),
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
            );
          }),
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
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 108, 108, 1),
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
}
