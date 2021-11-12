import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully.dart';
import 'package:Dfy/presentation/restore_bts/bloc/restore_cubit.dart';
import 'package:Dfy/presentation/restore_bts/bloc/restore_state.dart';
import 'package:Dfy/presentation/restore_bts/ui/choice_dialog.dart';
import 'package:Dfy/presentation/restore_bts/ui/scan_qr.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

const String PASS_PHRASE = 'PASS_PHRASE';
const String PRIVATE_KEY = 'PRIVATE_KEY';

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
  int checkBox = 1;
  bool tickCheckBox = false;
  FormType type = FormType.PASS_PHRASE;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController privateKeyController;
  late final TextEditingController seedPhraseController;

  @override
  void initState() {
    super.initState();
    restoreCubit = RestoreCubit();
    trustWalletChannel
        .setMethodCallHandler(restoreCubit.nativeMethodCallBackTrustWallet);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    privateKeyController = TextEditingController();
    seedPhraseController = TextEditingController();
  }

  @override
  void dispose() {
    restoreCubit.close();
    seedPhraseController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    privateKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestoreCubit, RestoreState>(
      bloc: restoreCubit,
      listener: (ctx, state) {
        if (state is NavState) {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Body(
              bLocCreateSeedPhrase:
                  BLocCreateSeedPhrase(passwordController.text),
              wallet: restoreCubit.wallet ?? Wallet(),
              type: KeyType1.IMPORT,
            ),
          );
        }
        if (state is ErrorState) {
          Fluttertoast.showToast(msg: S.current.error);
        }
      },
      builder: (ctx, _) {
        return GestureDetector(
          onTap: () {
            restoreCubit.boolSink.add(false);
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: 764.h,
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
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 28.w, left: 37.w),
                          child: const ImageIcon(
                            AssetImage(ImageAssets.ic_back),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 49.w,
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
                Flexible(
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
                                        color: AppTheme.getInstance()
                                            .itemBtsColors(),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            ImageAssets.ic_security,
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
                                              AssetImage(
                                                ImageAssets.ic_line_down,
                                              ),
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
                                              prefix: ImageAssets.ic_key24,
                                              hint: S.current.wallet_secret,
                                              suffix: ImageAssets.paste,
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
                                              prefix: ImageAssets.ic_key24,
                                              hint: S.current.private_key,
                                              suffix: S.current.paste,
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
                                        prefix: ImageAssets.ic_lock,
                                        hint: S.current.new_pass,
                                        suffix: isShowNewPass
                                            ? ImageAssets.ic_show
                                            : ImageAssets.ic_hide,
                                        formType: FormType.PASSWORD,
                                        isShow: isShowNewPass,
                                        callback: () {
                                          restoreCubit.newSink
                                              .add(!isShowNewPass);
                                        },
                                        controller: passwordController,
                                      );
                                    },
                                  ),
                                  warningInvalidPass(),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  StreamBuilder<bool>(
                                    initialData: isShowConPass,
                                    stream: restoreCubit.conStream,
                                    builder: (ctx, snapshot) {
                                      isShowConPass = snapshot.data!;
                                      return ItemForm(
                                        prefix: ImageAssets.ic_lock,
                                        hint: S.current.con_pass,
                                        suffix: isShowConPass
                                            ? ImageAssets.ic_show
                                            : ImageAssets.ic_hide,
                                        formType: FormType.PASSWORD,
                                        isShow: isShowConPass,
                                        callback: () {
                                          restoreCubit.conSink
                                              .add(!isShowConPass);
                                        },
                                        controller: confirmPasswordController,
                                      );
                                    },
                                  ),
                                  warningNotMatchPass(),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  StreamBuilder<List<String>>(
                                    stream: restoreCubit.listStringStream,
                                    initialData: listString,
                                    builder: (ctx, snapshot) {
                                      listString = snapshot.data!;
                                      if (listString.length == 1) {
                                        return Column(
                                          children: [
                                            Text(
                                              S.current.or_scan,
                                              style: textNormal(
                                                AppTheme.getInstance()
                                                    .textThemeColor(),
                                                16.sp,
                                              ).copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        QRViewExample(
                                                      controller:
                                                          privateKeyController,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Image.asset(
                                                ImageAssets.ic_qr_code,
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 50.h,
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
                SizedBox(
                  height: 24.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 26.w),
                  child: StreamBuilder<bool>(
                    initialData: tickCheckBox,
                    stream: restoreCubit.ckcStream,
                    builder: (ctx, snapshot) {
                      tickCheckBox = snapshot.data!;
                      return Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            fillColor: MaterialStateProperty.all(
                              AppTheme.getInstance().fillColor(),
                            ),
                            activeColor: AppTheme.getInstance().activeColor(),
                            onChanged: (bool? value) {
                              restoreCubit.ckcSink.add(value ?? false);
                              if (value == true) {
                                checkBox = 2;
                              } else {
                                checkBox = 1;
                              }
                            },
                            value: tickCheckBox,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  S.current.understand_defi,
                                  textAlign: TextAlign.start,
                                  style: textNormal(
                                    const Color.fromRGBO(255, 255, 255, 1),
                                    14.sp,
                                  ).copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 39.w,
                    right: 39.w,
                  ),
                  child: StreamBuilder<bool>(
                    initialData: tickCheckBox,
                    stream: restoreCubit.ckcStream,
                    builder: (ctx, snapshot) {
                      tickCheckBox = snapshot.data!;
                      return tickCheckBox
                          ? ButtonGradient(
                              onPressed: () {
                                restoreCubit
                                    .isValidate(passwordController.text);
                                restoreCubit.isMatchPW(
                                  password: passwordController.text,
                                  confirmPW: confirmPasswordController.text,
                                );
                                if (restoreCubit.isMatch(
                                  passwordController.text,
                                  confirmPasswordController.text,
                                )) {
                                  final flag = restoreCubit.strValue ==
                                      S.current.seed_phrase;
                                  restoreCubit.importWallet(
                                    type: flag ? '' : PRIVATE_KEY,
                                    content: privateKeyController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              gradient: RadialGradient(
                                center: const Alignment(0.5, -0.5),
                                radius: 4,
                                colors: AppTheme.getInstance()
                                    .gradientButtonColor(),
                              ),
                              child: Text(
                                S.current.restore,
                                style: textNormal(
                                  AppTheme.getInstance().textThemeColor(),
                                  20.sp,
                                ),
                              ),
                            )
                          : ErrorButton(
                              child: Center(
                                child: Text(
                                  S.current.restore,
                                  style: textNormal(
                                    AppTheme.getInstance().textThemeColor(),
                                    20.sp,
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                ),
                SizedBox(
                  height: 38.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget warningNotMatchPass() {
    return StreamBuilder<bool>(
      stream: restoreCubit.matchStream,
      builder: (BuildContext context, snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 323.w,
                height: 30.h,
                child: Text(
                  S.current.not_match,
                  style: textNormal(
                    AppTheme.getInstance().wrongColor(),
                    12.sp,
                  ).copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget warningInvalidPass() {
    return StreamBuilder<bool>(
      stream: restoreCubit.validateStream,
      builder: (BuildContext context, snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                S.current.pass_must,
                style: textNormal(
                  AppTheme.getInstance().wrongColor(),
                  12.sp,
                ).copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
