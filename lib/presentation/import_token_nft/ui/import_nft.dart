import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_token_nft/ui/import_nft_succesfully.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/form_input_address_nft.dart';
import 'package:Dfy/widgets/form/form_input_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImportNft extends StatelessWidget {
  const ImportNft({
    Key? key,
    required this.bloc,
    required this.addressWallet,
  }) : super(key: key);
  final WalletCubit bloc;
  final String addressWallet;

  @override
  Widget build(BuildContext context) {
    return _Body(
      bloc: bloc,
      addressWallet: addressWallet,
    );
  }
}

class _Body extends StatefulWidget {
  final WalletCubit bloc;
  final String addressWallet;

  const _Body({
    Key? key,
    required this.bloc,
    required this.addressWallet,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController _contractController;
  late final TextEditingController _idController;

  @override
  void initState() {
    super.initState();
    _contractController = TextEditingController();
    _idController = TextEditingController();
    widget.bloc.btnSubject.sink.add(false);
    widget.bloc.isNFT.sink.add(true);
    _contractController.addListener(() {
      widget.bloc.contractSubject.sink.add(_contractController.text);
    });
    _idController.addListener(() {
      widget.bloc.idSubject.sink.add(_idController.text);
    });
  }

  @override
  void dispose() {
    _contractController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is ImportNftSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const NFTSuccessfully();
              },
            ),
          ).whenComplete(() async {
            widget.bloc.listNftFromWalletCore.clear();
            await widget.bloc.getNFT(widget.bloc.addressWalletCore);
            widget.bloc.listNFTStream.add(widget.bloc.listNftFromWalletCore);
          });
        } else {
          _showDialog(alert: 'Import failed');
        }
      },
      bloc: widget.bloc,
      builder: (context, _) {
        return BaseBottomSheet(
          title: S.current.import_nft,
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        spaceH24,
                        FormInputAddressNFT(
                          controller: _contractController,
                          urlIcon1: ImageAssets.ic_address,
                          hint: S.current.contract_address,
                          urlIcon2: ImageAssets.ic_qr_code,
                          bloc: widget.bloc,
                        ),
                        spaceH4,
                        StreamBuilder(
                          stream: widget.bloc.isNFT,
                          builder: (context, snapshot) {
                            return SizedBox(
                              width: 343.w,
                              child: widget.bloc.isNFT.value
                                  ? null
                                  : Text(
                                      S.current.invalid_address,
                                      style: textNormal(
                                        Colors.red,
                                        14,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                            );
                          },
                        ),
                        spaceH16,
                        FormInputNumber(
                          urlIcon1: ImageAssets.ic_id,
                          bloc: widget.bloc,
                          hint: S.current.enter_id,
                        ),
                        const SizedBox(
                          height: 429,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: StreamBuilder<bool>(
                  stream: widget.bloc.btnSubject.stream,
                  builder: (context, snapshot) {
                    return snapshot.data ?? false
                        ? ButtonGradient(
                            onPressed: () async {
                              await widget.bloc.emitJsonNftToWalletCore(
                                contract: _contractController.text,
                                address: widget.bloc.addressWalletCore,
                              );
                            },
                            gradient: RadialGradient(
                              center: const Alignment(0.5, -0.5),
                              radius: 4,
                              colors:
                                  AppTheme.getInstance().gradientButtonColor(),
                            ),
                            child: Text(
                              S.current.import,
                              style: textNormal(
                                AppTheme.getInstance().textThemeColor(),
                                20,
                              ),
                            ),
                          )
                        : ErrorButton(
                            child: Center(
                              child: Text(
                                S.current.import,
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
              spaceH38,
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
                    20.sp,
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
                  12.sp,
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
                    20.sp,
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
