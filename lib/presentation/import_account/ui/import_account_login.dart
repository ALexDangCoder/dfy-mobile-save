import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_fail.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_successfully.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_successfully_have_wallet.dart';
import 'package:Dfy/presentation/import_account/bloc/import_cubit.dart';
import 'package:Dfy/presentation/import_account/bloc/import_state.dart';
import 'package:Dfy/presentation/import_account/ui/choice_import_dialog.dart';
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

const String PASS_PHRASE = 'PASS_PHRASE';
const String PRIVATE_KEY = 'PRIVATE_KEY';

class ImportAccount extends StatefulWidget {
  const ImportAccount({Key? key}) : super(key: key);

  @override
  _ImportAccountState createState() => _ImportAccountState();
}

class _ImportAccountState extends State<ImportAccount> {
  late final ImportCubit importCubit;
  List<String> listString = [S.current.only_desc];
  String strValue = S.current.seed_phrase;
  bool isVisible = false;
  bool isEnable = true;
  FormType type = FormType.PASS_PHRASE;
  late final TextEditingController privateKeyController;
  late final TextEditingController seedPhraseController;

  @override
  void initState() {
    super.initState();
    importCubit = ImportCubit();
    trustWalletChannel
        .setMethodCallHandler(importCubit.nativeMethodCallBackTrustWallet);
    privateKeyController = TextEditingController();
    seedPhraseController = TextEditingController();
  }

  @override
  void dispose() {
    importCubit.close();
    seedPhraseController.dispose();
    privateKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImportCubit, ImportState>(
      bloc: importCubit,
      listener: (ctx, state) {
        if (state is NavState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreateSuccessfullyHaveWallet(
                  type: KeyType.IMPORT,
                  wallet: importCubit.wallet ?? Wallet(),
                );
              },
            ),
          );
        }
        if (state is ErrorState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const CreateFail(type: KeyType.IMPORT_HAVE_WALLET);
              },
            ),
          );
        }
        if (state is ExceptionState) {
          _showDialog(state.message, S.current.please_try_again);
        }
      },
      builder: (ctx, _) {
        return GestureDetector(
          onTap: () {
            importCubit.boolSink.add(false);
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: BaseBottomSheet(
            title: S.current.import_acc,
            child: Column(
              children: [
                spaceH24,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: StreamBuilder<List<String>>(
                    initialData: listString,
                    stream: importCubit.listStringStream,
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
                                    importCubit.boolSink.add(!isVisible);
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
                                            stream: importCubit.stringStream,
                                            initialData: strValue,
                                            builder: (ctx, snapshot) {
                                              strValue = snapshot.data!;
                                              return Align(
                                                alignment: Alignment.centerLeft,
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
                                  stream: importCubit.typeStream,
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
                                            importCubit: importCubit,
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
                                            importCubit: importCubit,
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
                                  height: 24.h,
                                ),
                                StreamBuilder<FormType>(
                                  stream: importCubit.typeStream,
                                  initialData: type,
                                  builder: (ctx, snapshot) {
                                    type = snapshot.data!;
                                    if (type == FormType.PRIVATE_KEY) {
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
                                      return SizedBox(
                                        height: 50.h,
                                      );
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
                          stream: importCubit.boolStream,
                          builder: (ctx, snapshot) {
                            isVisible = snapshot.data!;
                            return Visibility(
                              visible: isVisible,
                              child: Positioned(
                                top: 72.h,
                                child: ChoiceDialog(
                                  cubit: importCubit,
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
                  height: 150.h,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 39.w,
                    right: 39.w,
                  ),
                  child: StreamBuilder<bool>(
                    initialData: isEnable,
                    stream: importCubit.btnStream,
                    builder: (ctx, snapshot) {
                      isEnable = snapshot.data!;
                      if (isEnable) {
                        return ButtonGradient(
                          onPressed: () {
                            if (importCubit.type == FormType.PASS_PHRASE) {
                              importCubit.showTxtWarningSeed(
                                seedPhraseController.text,
                                importCubit.type,
                              );
                            } else {
                              importCubit.showTxtWarningSeed(
                                privateKeyController.text,
                                importCubit.type,
                              );
                            }
                            if (importCubit.validateAll()) {
                              final flag =
                                  importCubit.strValue == S.current.seed_phrase;
                              importCubit.importWallet(
                                type: flag ? PASS_PHRASE : PRIVATE_KEY,
                                content: flag
                                    ? seedPhraseController.text
                                    : privateKeyController.text,
                              );
                            }
                          },
                          gradient: RadialGradient(
                            center: const Alignment(0.5, -0.5),
                            radius: 4,
                            colors:
                                AppTheme.getInstance().gradientButtonColor(),
                          ),
                          child: Text(
                            S.current.restore,
                            style: textNormal(
                              AppTheme.getInstance().textThemeColor(),
                              20,
                            ),
                          ),
                        );
                      } else {
                        return ErrorButton(
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
                      }
                    },
                  ),
                ),
                spaceH38,
              ],
            ),
          ),
        );
      },
    );
  }
  void _showDialog(String alert, String text) {
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
              Text(
                alert,
                style: textNormalCustom(
                  Colors.white,
                  20,
                  FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                text,
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
  Widget warningSeedPhrase() {
    return StreamBuilder<bool>(
      stream: importCubit.seedStream,
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
                  stream: importCubit.txtWarningSeedStream,
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
