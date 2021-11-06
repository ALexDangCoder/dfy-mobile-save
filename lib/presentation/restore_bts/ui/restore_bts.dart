import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/restore_bts/bloc/restore_cubit.dart';
import 'package:Dfy/presentation/restore_bts/ui/choice_dialog.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestoreBTS extends StatefulWidget {
  const RestoreBTS({Key? key}) : super(key: key);

  @override
  _RestoreBTSState createState() => _RestoreBTSState();
}

class _RestoreBTSState extends State<RestoreBTS> {
  late final RestoreCubit restoreCubit;
  List<String> listString = [S.current.restore_with_seed, S.current.only_first];
  String strValue = S.current.seed_phrase;
  bool isVisible = false;
  bool isShowNewPass = true;
  bool isShowConPass = true;
  FormType type = FormType.PASS_PHRASE;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController privateKeyController;
  late final TextEditingController seedPhraseController;

  @override
  void initState() {
    super.initState();
    restoreCubit = RestoreCubit();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    privateKeyController = TextEditingController();
    seedPhraseController = TextEditingController();
  }

  @override
  void dispose() {
    restoreCubit.dispose();
    seedPhraseController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    privateKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        restoreCubit.boolSink.add(false);
      },
      child: Container(
        height: 803.h,
        width: 375.w,
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 37.w,
                right: 37.w,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.getInstance().divideColor(),
                  ),
                ),
              ),
              height: 64.h,
              width: 375.h,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const ImageIcon(
                      AssetImage(ImageAssets.back),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 77.w,
                  ),
                  Expanded(
                    child: Text(
                      S.current.restore_account,
                      style: textNormal(
                        AppTheme.getInstance().textThemeColor(),
                        20.sp,
                      ).copyWith(
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            StreamBuilder<List<String>>(
              initialData: listString,
              stream: restoreCubit.listStringStream,
              builder: (ctx, snapshot) {
                listString = snapshot.data!;
                return Container(
                  padding: EdgeInsets.only(
                    left: 26.w,
                    right: 26.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          listString.first,
                          style: textNormal(
                            AppTheme.getInstance().textThemeColor(),
                            16.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      if (listString.length == 2)
                        Text(
                          listString[1],
                          style: textNormal(
                            AppTheme.getInstance().textThemeColor(),
                            16.sp,
                          ),
                        )
                      else
                        SizedBox(
                          height: 36.h,
                        ),
                      if (listString.length == 2)
                        SizedBox(
                          height: 44.h,
                        )
                      else
                        const SizedBox(),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(left: 25.w, right: 26.w),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  restoreCubit.boolSink.add(!isVisible);
                                },
                                child: Container(
                                  height: 64.h,
                                  width: 323.w,
                                  padding: EdgeInsets.only(
                                    top: 6.h,
                                    bottom: 6.h,
                                    right: 8.w,
                                    left: 8.w,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color:
                                        AppTheme.getInstance().itemBtsColors(),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        ImageAssets.security,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 14.w,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8.h),
                                        height: 24.h,
                                        width: 215.w,
                                        child: StreamBuilder<String>(
                                          stream: restoreCubit.stringStream,
                                          initialData: strValue,
                                          builder: (ctx, snapshot) {
                                            strValue = snapshot.data!;
                                            return Text(
                                              strValue,
                                              style: textNormal(
                                                AppTheme.getInstance()
                                                    .textThemeColor(),
                                                16.sp,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 27.15.w,
                                      ),
                                      const Expanded(
                                        child: ImageIcon(
                                          AssetImage(ImageAssets.expand),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              StreamBuilder<FormType>(
                                stream: restoreCubit.typeStream,
                                initialData: type,
                                builder: (ctx, snapshot) {
                                  type = snapshot.data!;
                                  return type == FormType.PASS_PHRASE
                                      ? ItemForm(
                                          leadPath: ImageAssets.key,
                                          hint: S.current.wallet_secret,
                                          trailingPath: ImageAssets.paste,
                                          formType: FormType.PASS_PHRASE,
                                          isShow: false,
                                          controller: seedPhraseController,
                                          callback: () async {
                                            final ClipboardData? data =
                                                await Clipboard.getData(
                                              Clipboard.kTextPlain,
                                            );
                                            seedPhraseController.text =
                                                data?.text ?? '';
                                          },
                                        )
                                      : ItemForm(
                                          leadPath: ImageAssets.key,
                                          hint: S.current.private_key,
                                          trailingPath: ImageAssets.paste,
                                          formType: FormType.PRIVATE_KEY,
                                          isShow: false,
                                          controller: privateKeyController,
                                          callback: () async {
                                            final ClipboardData? data =
                                                await Clipboard.getData(
                                              Clipboard.kTextPlain,
                                            );
                                            privateKeyController.text =
                                                data?.text ?? '';
                                          },
                                        );
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              StreamBuilder<bool>(
                                initialData: isShowNewPass,
                                stream: restoreCubit.newStream,
                                builder: (ctx, snapshot) {
                                  isShowNewPass = snapshot.data!;
                                  return ItemForm(
                                    leadPath: ImageAssets.lock,
                                    hint: S.current.new_pass,
                                    trailingPath: isShowNewPass
                                        ? ImageAssets.show
                                        : ImageAssets.hide,
                                    formType: FormType.PASSWORD,
                                    isShow: isShowNewPass,
                                    callback: () {
                                      restoreCubit.newSink.add(!isShowNewPass);
                                    },
                                    controller: passwordController,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              StreamBuilder<bool>(
                                initialData: isShowConPass,
                                stream: restoreCubit.conStream,
                                builder: (ctx, snapshot) {
                                  isShowConPass = snapshot.data!;
                                  return ItemForm(
                                    leadPath: ImageAssets.lock,
                                    hint: S.current.con_pass,
                                    trailingPath: isShowConPass
                                        ? ImageAssets.show
                                        : ImageAssets.hide,
                                    formType: FormType.PASSWORD,
                                    isShow: isShowConPass,
                                    callback: () {
                                      restoreCubit.conSink.add(!isShowConPass);
                                    },
                                    controller: confirmPasswordController,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 100.h,
                              ),
                            ],
                          ),
                        ],
                      ),
                      StreamBuilder<bool>(
                        initialData: isVisible,
                        stream: restoreCubit.boolStream,
                        builder: (ctx, snapshot) {
                          isVisible = snapshot.data!;
                          return Visibility(
                            visible: isVisible,
                            child: Positioned(
                              top: 72.h,
                              child: ChoiceDialog(
                                cubit: restoreCubit,
                                controller1: seedPhraseController,
                                controller2: privateKeyController,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<List<String>>(
              stream: restoreCubit.listStringStream,
              initialData: listString,
              builder: (ctx, snapshot) {
                listString = snapshot.data!;
                if (listString.length == 1) {
                  return Container(
                    //color: Colors.red,
                    height: 32.h,
                    width: 32.w,
                    padding: EdgeInsets.only(
                      left: 133.w,
                      right: 133.w,
                    ),
                    child: Column(
                      children: [
                        Text(
                          S.current.or_scan,
                          style: textNormal(
                            AppTheme.getInstance().textThemeColor(),
                            16.sp,
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            ImageAssets.ic_copy,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              margin: EdgeInsets.only(
                left: 39.w,
                right: 39.w,
              ),
              child: ButtonGradient(
                onPressed: () {},
                gradient: RadialGradient(
                  center: const Alignment(0.5, -0.5),
                  radius: 4,
                  colors: AppTheme.getInstance().gradientButtonColor(),
                ),
                child: Text(
                  S.current.restore,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    20.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }
}
