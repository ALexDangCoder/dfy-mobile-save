import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/approve/bloc/approve_cubit.dart';
import 'package:flutter/material.dart';

class EstimateGasFee extends StatefulWidget {
  const EstimateGasFee({Key? key, required this.cubit, required this.gasLimit})
      : super(key: key);
  final double gasLimit;
  final ApproveCubit cubit;

  @override
  _EstimateGasFeeState createState() => _EstimateGasFeeState();
}

class _EstimateGasFeeState extends State<EstimateGasFee> {
  bool isCustomFee = false;

  @override
  void initState() {
    widget.cubit.getGasPrice();
    // TODO: implement initState
    super.initState();
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
                  Text(
                    '${((widget.cubit.gasPrice ?? 10) * widget.gasLimit) / 1000000000} BNB',
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
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
                  const SizedBox (height : 16),
                  Divider(
                    height: 1,
                    color: AppTheme.getInstance().whiteBackgroundButtonColor(),
                  ),
                  const SizedBox (height : 16),
                  Padding(
                    padding:const  EdgeInsets.symmetric(horizontal: 16),
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
                                // textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.right,
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                //controller: txtController,
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                cursorColor: AppTheme.getInstance().textThemeColor(),
                                decoration: InputDecoration(
                                  hintStyle: textNormal(
                                    AppTheme.getInstance().disableColor(),
                                    16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox (height : 16),
                  Padding(
                    padding:const  EdgeInsets.symmetric(horizontal: 16),
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
                            padding:const EdgeInsets.only(
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
                                // textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.right,
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                //controller: txtController,
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                cursorColor: AppTheme.getInstance().textThemeColor(),
                                decoration: InputDecoration(
                                  hintStyle: textNormal(
                                    AppTheme.getInstance().disableColor(),
                                    16,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
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
