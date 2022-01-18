import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EstimateGasFee extends StatefulWidget {
  const EstimateGasFee({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ApproveCubit cubit;

  @override
  _EstimateGasFeeState createState() => _EstimateGasFeeState();
}

class _EstimateGasFeeState extends State<EstimateGasFee> {
  bool isCustomFee = false;
  double? gasPrice;

  double gasLimit=0;

  final TextEditingController _editGasPriceController = TextEditingController();
  final TextEditingController _editGasLimitController = TextEditingController();

  @override
  void initState() {
    widget.cubit.gasLimitFirstSubject.listen((value) {
      setState(() {
        gasLimit = widget.cubit.gasLimitFirst ?? 0;
        _editGasLimitController.text =
            (widget.cubit.gasLimitFirst ?? 0).toInt().toString();
      });
    });
    gasPrice = (widget.cubit.gasPriceFirst ?? 0) / 1000000000;
    _editGasPriceController.text =
        ((widget.cubit.gasPriceFirstSubject.valueOrNull ?? 10) / 1000000000)
            .toInt()
            .toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().whiteBackgroundButtonColor(),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${S.current.estimate_gas_fee}:',
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  StreamBuilder<double>(
                    stream: widget.cubit.gasPriceFirstSubject,
                    builder: (context, snapshot) {
                      final gasFee = (gasPrice ?? 0) * gasLimit / 1000000000;
                      if (gasFee < (widget.cubit.balanceWallet ?? 0) &&
                          gasFee >=
                              ((widget.cubit.gasLimitFirst ?? 0) *
                                  (widget.cubit.gasPriceFirst ?? 0) /
                                  1e18)) {
                        widget.cubit.canActionSubject.sink.add(true);
                      } else {
                        widget.cubit.canActionSubject.sink.add(false);
                      }
                      return Column(
                        children: [
                          Text(
                            '$gasFee BNB',
                            style: textNormal(
                              gasFee <= (widget.cubit.balanceWallet ?? 0) &&
                                      gasFee > 0
                                  ? AppTheme.getInstance().whiteColor()
                                  : AppTheme.getInstance().redColor(),
                              16,
                            ).copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (gasFee > (widget.cubit.balanceWallet ?? 0))
                            Text(
                              S.current.insufficient_balance,
                              style: textNormalCustom(
                                AppTheme.getInstance().redColor(),
                                12,
                                FontWeight.w400,
                              ),
                            )
                          else
                            const SizedBox(height: 0),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isCustomFee = !isCustomFee;
                });
              },
              child: Text(
                isCustomFee
                    ? S.current.hide_customize_fee
                    : S.current.customize_fee,
                style: textNormal(
                  AppTheme.getInstance().blueColor(),
                  14,
                ),
              ),
            ),
            if (isCustomFee)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Divider(
                    height: 1,
                    color: AppTheme.getInstance().whiteBackgroundButtonColor(),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            S.current.gas_limit,
                            style: textNormal(
                              AppTheme.getInstance().whiteColor(),
                              16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 64,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: AppTheme.getInstance().itemBtsColors(),
                            ),
                            child: Center(
                              child: TextField(
                                controller: _editGasLimitController,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                cursorColor:
                                    AppTheme.getInstance().textThemeColor(),
                                decoration: InputDecoration(
                                  hintStyle: textNormal(
                                    AppTheme.getInstance().disableColor(),
                                    16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    if (value != '') {
                                      gasLimit = double.parse(value);
                                    } else {
                                      gasLimit = 0;
                                    }
                                  });
                                  final gasFee =
                                      (gasPrice ?? 0) * gasLimit / 1000000000;
                                  if (gasFee <
                                          (widget.cubit.balanceWallet ?? 0) &&
                                      gasFee >=
                                          ((widget.cubit.gasLimitFirst ?? 0) *
                                              (widget.cubit.gasPriceFirst ??
                                                  0) /
                                              1e18)) {
                                    widget.cubit.canActionSubject.sink.add(
                                      true,
                                    );
                                  } else {
                                    widget.cubit.canActionSubject.sink
                                        .add(false);
                                  }
                                  widget.cubit.gasLimit = gasLimit;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${S.current.gas_price} (GWEI)',
                            style: textNormal(
                              AppTheme.getInstance().whiteColor(),
                              16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 64,
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: AppTheme.getInstance().itemBtsColors(),
                            ),
                            child: Center(
                              child: TextField(
                                controller: _editGasPriceController,
                                textAlign: TextAlign.right,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,5}'),
                                  ),
                                ],
                                keyboardType: TextInputType.number,
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                cursorColor:
                                    AppTheme.getInstance().textThemeColor(),
                                decoration: InputDecoration(
                                  hintStyle: textNormal(
                                    AppTheme.getInstance().disableColor(),
                                    16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value != '') {
                                      gasPrice = double.parse(value);
                                    } else {
                                      gasPrice = 0;
                                    }
                                  });
                                  widget.cubit.gasPrice =
                                      (gasPrice ?? 0) * 1000000000;
                                  final gasFee =
                                      (gasPrice ?? 0) * gasLimit / 1000000000;
                                  if (gasFee <
                                          (widget.cubit.balanceWallet ?? 0) &&
                                      gasFee >=
                                          ((widget.cubit.gasLimitFirst ?? 0) *
                                              (widget.cubit.gasPriceFirst ??
                                                  0) /
                                              1e18)) {
                                    widget.cubit.canActionSubject.sink
                                        .add(true);
                                  } else {
                                    widget.cubit.canActionSubject.sink
                                        .add(false);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        gasPrice =
                            (widget.cubit.gasPriceFirst ?? 0) / 1000000000;
                        _editGasPriceController.text =
                            gasPrice!.toInt().toString();
                        gasLimit = widget.cubit.gasLimitFirst ?? 0;
                        _editGasLimitController.text =
                            gasLimit.toInt().toString();
                        widget.cubit.gasLimit = gasLimit;
                        widget.cubit.gasPrice = gasLimit;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().selectDialogColor(),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        S.current.reset,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          14,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
