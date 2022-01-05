import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/approve/bloc/approve_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EstimateGasFee extends StatefulWidget {
  const EstimateGasFee(
      {Key? key, required this.cubit, required this.gasLimitStart})
      : super(key: key);
  final double gasLimitStart;
  final ApproveCubit cubit;

  @override
  _EstimateGasFeeState createState() => _EstimateGasFeeState();
}

class _EstimateGasFeeState extends State<EstimateGasFee> {
  bool isCustomFee = false;
  double? gasPrice;

  double? gasLimit;
  double? gasPriceStart;
  final TextEditingController _editGasPriceController = TextEditingController();
  final TextEditingController _editGasLimitController = TextEditingController();

  @override
  void initState() {
    _editGasLimitController.text = widget.gasLimitStart.toString();
    initData();
    // TODO: implement initState
    super.initState();
  }

  Future<void> initData() async {
    await widget.cubit.getGasPrice();
    _editGasPriceController.text =
        (widget.cubit.gasPriceSubject.valueOrNull ?? 0).toString();
  }

  void resetEditGasFee() {
    _editGasLimitController.text = widget.gasLimitStart.toString();
    _editGasLimitController.text = gasPriceStart.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().whiteBackgroundButtonColor(),
          width: 1,
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
                      stream: widget.cubit.gasPriceStream,
                      builder: (context, snapshot) {
                        gasPriceStart = snapshot.data;
                        final gasFee = ((gasPrice ?? (gasPriceStart ?? 0)) *
                                (gasLimit ?? widget.gasLimitStart)) /
                            1000000000;
                        return Column(
                          children: [
                            Text(
                              '$gasFee BNB',
                              style: textNormal(
                                AppTheme.getInstance().whiteColor(),
                                16,
                              ).copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (gasFee > (widget.cubit.balanceWallet ?? 0))
                              Text("a")
                            else
                              const SizedBox(height: 0),
                          ],
                        );
                      }),
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
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    gasLimit = double.parse(value);
                                  });
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
                              child: TextFormField(
                                controller: _editGasPriceController,
                                textAlign: TextAlign.right,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d*'),
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
                                  print(value);
                                  setState(() {
                                    gasPrice = double.parse(value);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
