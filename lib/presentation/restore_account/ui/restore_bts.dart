import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_fail.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_successfully.dart';
import 'package:Dfy/presentation/restore_account/bloc/restore_cubit.dart';
import 'package:Dfy/presentation/restore_account/bloc/restore_state.dart';
import 'package:Dfy/presentation/restore_account/ui/scan_qr.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'choice_dialog.dart';

const String PASS_PHRASE = 'PASS_PHRASE';
const String PRIVATE_KEY = 'PRIVATE_KEY';

class RestoreAccount extends StatefulWidget {
  const RestoreAccount({
    Key? key,
  }) : super(key: key);

  @override
  _RestoreAccountState createState() => _RestoreAccountState();
}

class _RestoreAccountState extends State<RestoreAccount> {
  late final RestoreCubit restoreCubit;
  List<String> listString = [S.current.restore_with_seed, S.current.only_first];
  String strValue = S.current.seed_phrase;
  bool isVisible = false;
  bool isShowNewPass = true;
  bool isShowConPass = true;
  int checkBox = 1;
  bool isEnable = true;
  bool tickCheckBox = true;
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return CreateSuccessfully(
                  bLocCreateSeedPhrase:
                      BLocCreateSeedPhrase(passwordController.text),
                  wallet: restoreCubit.wallet ?? Wallet(),
                  type: KeyType.IMPORT,
                );
              },
            ),
          );
        }
        if (state is ErrorState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const CreateFail(type: KeyType.IMPORT);
              },
            ),
          );
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
          child: BaseBottomSheet(
            title: S.current.restore_account,
            isBackNewWallet: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  spaceH24,
                  StreamBuilder<List<String>>(
                    initialData: listString,
                    stream: restoreCubit.listStringStream,
                    builder: (ctx, snapshot) {
                      listString = snapshot.data!;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              listString.first,
                              style: textNormal(
                                AppTheme.getInstance().textThemeColor(),
                                16,
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
                                16,
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
                      );
                    },
                  ),
                  Flexible(
                    child: SingleChildScrollView(
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
                                      width: 343.w,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Image.asset(
                                              ImageAssets.ic_security,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 8,
                                            child: StreamBuilder<String>(
                                              stream: restoreCubit.stringStream,
                                              initialData: strValue,
                                              builder: (ctx, snapshot) {
                                                strValue = snapshot.data!;
                                                return Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    strValue,
                                                    style: textNormal(
                                                      AppTheme.getInstance()
                                                          .textThemeColor(),
                                                      16,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const Flexible(
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
                                              suffix: S.current.paste,
                                              formType: FormType.PASS_PHRASE,
                                              isShow: false,
                                              cubit: restoreCubit,
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
                                              cubit: restoreCubit,
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
                                  warningSeedPhrase(),
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
                                        cubit: restoreCubit,
                                        callback: () {
                                          restoreCubit.newSink
                                              .add(!isShowNewPass);
                                        },
                                        controller: passwordController,
                                        passType: PassType.NEW,
                                      );
                                    },
                                  ),
                                  warningPassword(),
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
                                        cubit: restoreCubit,
                                        callback: () {
                                          restoreCubit.conSink
                                              .add(!isShowConPass);
                                        },
                                        controller: confirmPasswordController,
                                        passType: PassType.CON,
                                      );
                                    },
                                  ),
                                  warningMatchPassword(),
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
                                                16,
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
                  SizedBox(
                    height: 24.h,
                  ),
                  StreamBuilder<bool>(
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
                              restoreCubit.checkCkcValue(value ?? false);
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
                                    14,
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
                  spaceH40,
                  Container(
                    margin: EdgeInsets.only(
                      left: 23.w,
                      right: 23.w,
                    ),
                    child: StreamBuilder<bool>(
                      initialData: isEnable,
                      stream: restoreCubit.btnStream,
                      builder: (ctx, snapshot) {
                        isEnable = snapshot.data!;
                        return isEnable
                            ? ButtonGradient(
                                onPressed: () {
                                  restoreCubit.showTxtWarningNewPW(
                                    passwordController.text,
                                  );
                                  restoreCubit.showTxtWarningConfirmPW(
                                    confirmPasswordController.text,
                                    newPW: passwordController.text,
                                  );
                                  if (restoreCubit.type ==
                                      FormType.PASS_PHRASE) {
                                    restoreCubit.showTxtWarningSeed(
                                      seedPhraseController.text,
                                      restoreCubit.type,
                                    );
                                  } else {
                                    restoreCubit.showTxtWarningSeed(
                                      privateKeyController.text,
                                      restoreCubit.type,
                                    );
                                  }
                                  if (restoreCubit.validateAll()) {
                                    final flag = restoreCubit.strValue ==
                                        S.current.seed_phrase;
                                    restoreCubit.importWallet(
                                      type: flag ? PASS_PHRASE : PRIVATE_KEY,
                                      content: flag
                                          ? seedPhraseController.text
                                          : privateKeyController.text,
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
                                    20,
                                  ),
                                ),
                              )
                            : ErrorButton(
                                child: Center(
                                  child: Text(
                                    S.current.restore,
                                    style: textNormal(
                                      AppTheme.getInstance().textThemeColor(),
                                      20,
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                  spaceH38
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget warningSeedPhrase() {
    return StreamBuilder<bool>(
      stream: restoreCubit.seedStream,
      builder: (BuildContext context, snapshot) {
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
                  stream: restoreCubit.txtWarningSeedStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormal(AppTheme.getInstance().wrongColor(), 12)
                          .copyWith(fontWeight: FontWeight.w400),
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

  Widget warningPassword() {
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
              SizedBox(
                width: 343.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  stream: restoreCubit.txtWarningNewPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormal(AppTheme.getInstance().wrongColor(), 12)
                          .copyWith(fontWeight: FontWeight.w400),
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

  Widget warningMatchPassword() {
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
                width: 343.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  stream: restoreCubit.txtWarningConfirmPWStream,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: textNormal(AppTheme.getInstance().wrongColor(), 12)
                          .copyWith(fontWeight: FontWeight.w400),
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
