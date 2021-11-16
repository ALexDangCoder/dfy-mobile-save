import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully2.dart';
import 'package:Dfy/presentation/import_account_login_bts/bloc/import_cubit.dart';
import 'package:Dfy/presentation/import_account_login_bts/ui/choice_import_dialog.dart';
import 'package:Dfy/presentation/restore_bts/ui/scan_qr.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const String PASS_PHRASE = 'PASS_PHRASE';
const String PRIVATE_KEY = 'PRIVATE_KEY';

class ImportBTS extends StatefulWidget {
  const ImportBTS({Key? key}) : super(key: key);

  @override
  _ImportBTSState createState() => _ImportBTSState();
}

class _ImportBTSState extends State<ImportBTS> {
  late final ImportCubit importCubit;
  List<String> listString = [S.current.only_desc];
  String strValue = S.current.seed_phrase;
  bool isVisible = false;
  bool isShowNewPass = true;
  bool isShowConPass = true;
  int checkBox = 1;
  bool tickCheckBox = true;
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
    return BaseBottomSheet(
      title: S.current.import_seed,
      child: Column(
        children: [
          spaceH24,
          StreamBuilder<List<String>>(
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
                                color: AppTheme.getInstance().itemBtsColors(),
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
                                              16.sp,
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
                            height: 24.h,
                          ),
                          StreamBuilder<List<String>>(
                            stream: importCubit.listStringStream,
                            initialData: listString,
                            builder: (ctx, snapshot) {
                              listString = snapshot.data!;
                              if (listString.length == 1) {
                                return Column(
                                  children: [
                                    Text(
                                      S.current.or_scan,
                                      style: textNormal(
                                        AppTheme.getInstance().textThemeColor(),
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
                                            builder: (ctx) => QRViewExample(
                                              controller: privateKeyController,
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
            child: ButtonGradient(
              onPressed: () {
                showCreateSuccessfully2(
                  context: context,
                  wallet: Wallet(
                    address: '0xxx2727dadacgvfafa',
                    name: 'Nguyen Thanh Nam',
                  ),
                  type: KeyType.IMPORT,
                );
              },
              gradient: RadialGradient(
                center: const Alignment(0.5, -0.5),
                radius: 4,
                colors: AppTheme.getInstance().gradientButtonColor(),
              ),
              child: Text(
                S.current.import,
                style: textNormal(
                  AppTheme.getInstance().textThemeColor(),
                  20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
