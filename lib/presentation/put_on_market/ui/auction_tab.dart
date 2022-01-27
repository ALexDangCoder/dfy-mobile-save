import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/presentation/put_on_market/ui/component/pick_time.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:Dfy/widgets/form/input_with_select_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'component/custom_calandar.dart';

class AuctionTab extends StatefulWidget {
  final PutOnMarketCubit cubit;
  final PutOnMarketModel putOnMarketModel;

  const AuctionTab({
    Key? key,
    required this.cubit,
    required this.putOnMarketModel,
  }) : super(key: key);

  @override
  _AuctionTabState createState() => _AuctionTabState();
}

class _AuctionTabState extends State<AuctionTab>
    with AutomaticKeepAliveClientMixin<AuctionTab> {
  late double width, height, xPosition, yPosition;
  int chooseIndex = 0;
  bool outPrice = false;
  bool priceStep = false;
  TokenInf? _tokenInf;
  late PutOnMarketModel _putOnMarketModel;
  final timeStartController = TextEditingController();
  final timeEndController = TextEditingController();
  final dateStartController = TextEditingController();
  final dateEndController = TextEditingController();

  String? errorTextStartTime;
  String? buyOutPriceErrorText;
  String? priceStepErrorText;
  String? errorTextEndTime;

  int? durationTime;

  @override
  void initState() {
    // TODO: implement initState
    final now = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _putOnMarketModel = widget.putOnMarketModel;
    _putOnMarketModel.numberOfCopies = 1;
    dateStartController.text = now;
    dateEndController.text = now;
    super.initState();
  }

  void validateDuration() {
    if (timeStartController.text != '' && timeEndController.text != '') {
      final DateTime startTime =
          DateFormat(DateTimeFormat.DATE_TIME_AUCTION_FORMAT)
              .parse('${dateStartController.text} ${timeStartController.text}');
      _putOnMarketModel.startTime =
          (startTime.millisecondsSinceEpoch ~/ 1000).toString();
      final DateTime endTime =
          DateFormat(DateTimeFormat.DATE_TIME_AUCTION_FORMAT)
              .parse('${dateEndController.text} ${timeEndController.text}');
      _putOnMarketModel.endTime =
          (endTime.millisecondsSinceEpoch ~/ 1000).toString();
      final difference = endTime.difference(startTime).inHours;
      durationTime = endTime.difference(startTime).inMinutes;
      if (startTime.difference(DateTime.now()).inHours < 48) {
        setState(() {
          errorTextStartTime = S.current.start_time_auction;
        });
        widget.cubit.timeValidate = false;
      }
      else if ((durationTime ?? 0) > 10 || (durationTime ?? 0) < 0) {
        setState(() {
          errorTextStartTime = null;
          errorTextEndTime = S.current.min_duration_auction;
        });
      }
      // else if (difference < 12) {
      //   setState(() {
      //     errorTextStartTime = null;
      //     errorTextEndTime = S.current.min_duration_auction;
      //   });
      //   widget.cubit.timeValidate = false;
      // } else
      // if (difference > 168) {
      //   setState(() {
      //     errorTextEndTime = S.current.max_duration_auction;
      //   });
      //   widget.cubit.timeValidate = false;
      // }
      else {
        setState(() {
          errorTextStartTime = null;
          errorTextEndTime = null;
        });
        widget.cubit.timeValidate = true;
      }
    }
    widget.cubit.updateStreamContinueAuction();
  }

  bool validatePriceStep() {
    if (priceStep &&
        (_putOnMarketModel.priceStep == null ||
            _putOnMarketModel.priceStep == '')) {
      widget.cubit.priceStepValidate = false;
      widget.cubit.updateStreamContinueAuction();
      return false;
    } else {
      widget.cubit.priceStepValidate = true;
      widget.cubit.updateStreamContinueAuction();
      return true;
    }
  }

  bool validateBuyOutPrice() {
    if (outPrice &&
        (_putOnMarketModel.buyOutPrice == null ||
            _putOnMarketModel.buyOutPrice == '' ||
            (double.parse(_putOnMarketModel.buyOutPrice ?? '0') <
                double.parse(_putOnMarketModel.price ?? '0')))) {
      widget.cubit.buyOutPriceValidate = false;
      widget.cubit.updateStreamContinueAuction();
      return false;
    } else {
      widget.cubit.buyOutPriceValidate = true;
      widget.cubit.updateStreamContinueAuction();
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.getInstance().bgBtsColor(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  S.current.get_a_loan_by_nft_on_pawn_marketplace,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                    FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              Text(
                S.current.expected_loan,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                child: Text(
                  S.current
                      .set_the_loan_amount_you_expected_to_have_for_the_nft,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                    14,
                    FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              StreamBuilder<List<TokenInf>>(
                stream: widget.cubit.listTokenStream,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  if (data.isNotEmpty) {
                    widget.cubit.changeTokenSale(
                      indexToken: 0,
                    );
                    _putOnMarketModel.tokenAddress =
                        widget.cubit.listToken[0].address ?? '';
                    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                      if (_tokenInf == null) {
                        setState(() {
                          _tokenInf = widget.cubit.listToken[0];
                        });
                      }
                    });
                  }
                  return InputWithSelectType(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,5}'),
                      ),
                    ],
                    maxSize: 100,
                    keyboardType: TextInputType.number,
                    typeInput: data
                        .map(
                          (e) => SizedBox(
                            height: 64,
                            width: 70,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Image.network(
                                    e.iconUrl ?? '',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    e.symbol ?? '',
                                    style: textValueNFT.copyWith(
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    hintText: S.current.enter_price,
                    onChangeType: (index) {
                      widget.cubit.changeTokenAuction(
                        indexToken: index,
                      );
                      _putOnMarketModel.tokenAddress =
                          widget.cubit.listToken[index].address ?? '';
                      setState(() {
                        _tokenInf = widget.cubit.listToken[index];
                      });
                    },
                    onchangeText: (value) {
                      widget.cubit.changeTokenAuction(
                        value: value != '' ? double.parse(value) : 0,
                      );
                      _putOnMarketModel.price = value;
                      if (!validateBuyOutPrice()) {
                        setState(() {
                          buyOutPriceErrorText = S.current.buy_out_price_error;
                        });
                      } else {
                        setState(() {
                          buyOutPriceErrorText = null;
                        });
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    S.current.duration,
                    style: textNormalCustom(
                      AppTheme.getInstance().textThemeColor(),
                      16,
                      FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => InfoPopup(
                          name: S.current.duration,
                          content: S.current.duration_more_content,
                        ),
                      );
                    },
                    icon: Image.asset(ImageAssets.more_circle_white),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                child: Text(
                  S.current.duration_content,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                    14,
                    FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              datetimePickerCustom(
                type: typeInputDateTime.START,
                date: S.current.start_date,
                time: S.current.start_time,
                timeController: timeStartController,
                dateController: dateStartController,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: SizedBox(
                    height: errorTextStartTime == null ? 0 : 25,
                    child: Text(
                      errorTextStartTime ?? '',
                      style: textNormalCustom(
                        AppTheme.getInstance().redColor(),
                        12,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              datetimePickerCustom(
                type: typeInputDateTime.END,
                timeController: timeEndController,
                dateController: dateEndController,
                date: S.current.end_date,
                time: S.current.end_time,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: SizedBox(
                    height: errorTextEndTime == null ? 0 : 25,
                    child: Text(
                      errorTextEndTime ?? '',
                      style: textNormalCustom(
                        AppTheme.getInstance().redColor(),
                        12,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.current.buy_out_price,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                        FontWeight.w600,
                      ),
                    ),
                  ),
                  CupertinoSwitch(
                    onChanged: (value) {
                      setState(() {
                        outPrice = value;
                      });
                      if (!value) {
                        _putOnMarketModel.buyOutPrice = null;
                      }
                      if (!validateBuyOutPrice()) {
                        setState(() {
                          buyOutPriceErrorText = S.current.buy_out_price_error;
                        });
                      } else {
                        setState(() {
                          buyOutPriceErrorText = null;
                        });
                      }
                    },
                    activeColor: AppTheme.getInstance().fillColor(),
                    value: outPrice,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                child: Text(
                  S.current.buy_out_price_content,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                    14,
                    FontWeight.w400,
                  ),
                ),
              ),
              if (outPrice)
                Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: AppTheme.getInstance().backgroundBTSColor(),
                  ),
                  height: 64,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,5}'),
                            ),
                          ],
                          maxLength: 100,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _putOnMarketModel.buyOutPrice = value;
                            if (!validateBuyOutPrice()) {
                              setState(() {
                                buyOutPriceErrorText =
                                    S.current.buy_out_price_error;
                              });
                            } else {
                              setState(() {
                                buyOutPriceErrorText = null;
                              });
                            }
                          },
                          cursorColor: AppTheme.getInstance().whiteColor(),
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            16,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 18),
                            counterText: '',
                            hintText:
                                '${S.current.enter} ${S.current.buy_out_price}',
                            hintStyle: textNormal(
                              Colors.white.withOpacity(0.5),
                              16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                            height: 64,
                          ),
                          SizedBox(
                            height: 64,
                            width: 70,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Image.network(
                                    _tokenInf?.iconUrl ?? '',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    _tokenInf?.symbol ?? '',
                                    style: textValueNFT.copyWith(
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 15)
                        ],
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(
                  height: 0,
                ),
              if (outPrice)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: SizedBox(
                      height: buyOutPriceErrorText == null ? 0 : 25,
                      child: Text(
                        buyOutPriceErrorText ?? '',
                        style: textNormalCustom(
                          AppTheme.getInstance().redColor(),
                          12,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(
                  height: 0,
                ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        S.current.price_step,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  CupertinoSwitch(
                    onChanged: (value) {
                      setState(() {
                        priceStep = value;
                      });
                      if (!value) {
                        _putOnMarketModel.priceStep = null;
                      }
                      if (!validatePriceStep()) {
                        setState(() {
                          priceStepErrorText = S.current.price_step_error;
                        });
                      } else {
                        setState(() {
                          priceStepErrorText = null;
                        });
                      }
                    },
                    activeColor: AppTheme.getInstance().fillColor(),
                    value: priceStep,
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                child: Text(
                  S.current.price_step_content,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                    14,
                    FontWeight.w400,
                  ),
                  maxLines: 5,
                ),
              ),
              if (priceStep)
                Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: AppTheme.getInstance().backgroundBTSColor(),
                  ),
                  height: 64,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,5}'),
                            ),
                          ],
                          maxLength: 100,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            _putOnMarketModel.priceStep = value;
                            if (!validatePriceStep()) {
                              setState(() {
                                priceStepErrorText = S.current.price_step_error;
                              });
                            } else {
                              setState(() {
                                priceStepErrorText = null;
                              });
                            }
                          },
                          cursorColor: AppTheme.getInstance().whiteColor(),
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            16,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 18),
                            counterText: '',
                            hintText:
                                '${S.current.enter} ${S.current.price_step}',
                            hintStyle: textNormal(
                              Colors.white.withOpacity(0.5),
                              16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                            height: 64,
                          ),
                          SizedBox(
                            height: 64,
                            width: 70,
                            child: Row(
                              children: [
                                Flexible(
                                  child: Image.network(
                                    _tokenInf?.iconUrl ?? '',
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    _tokenInf?.symbol ?? '',
                                    style: textValueNFT.copyWith(
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 15)
                        ],
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(
                  height: 0,
                ),
              if (priceStep)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    child: SizedBox(
                      height: priceStepErrorText == null ? 0 : 25,
                      child: Text(
                        priceStepErrorText ?? '',
                        style: textNormalCustom(
                          AppTheme.getInstance().redColor(),
                          12,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                )
              else
                const SizedBox(
                  height: 0,
                ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<bool>(
              stream: widget.cubit.canContinueAuctionStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? false;
                return GestureDetector(
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    if (data) {
                      final hexString =
                          await widget.cubit.getHexStringPutOnAuction(
                        _putOnMarketModel,
                        context,
                      );
                      unawaited(
                        navigator.push(
                          MaterialPageRoute(
                            builder: (context) => Approve(
                              needApprove: true,
                              payValue: _putOnMarketModel.price,
                              tokenAddress: _putOnMarketModel.tokenAddress,
                              putOnMarketModel: _putOnMarketModel,
                              hexString: hexString,
                              title: S.current.put_on_auction,
                              listDetail: [
                                DetailItemApproveModel(
                                  title: '${S.current.reserve_price} :',
                                  value:
                                      '${widget.cubit.valueTokenInputAuction ?? 0} ${_tokenInf?.symbol ?? 'DFY'}',
                                  isToken: true,
                                ),
                                if (outPrice)
                                  DetailItemApproveModel(
                                    title: '${S.current.buy_out_price} :',
                                    value:
                                        '${_putOnMarketModel.buyOutPrice ?? 0} ${_tokenInf?.symbol ?? 'DFY'}',
                                    isToken: true,
                                  ),
                                if (priceStep)
                                  DetailItemApproveModel(
                                    title: '${S.current.price_step} :',
                                    value:
                                        '${_putOnMarketModel.priceStep ?? 0} ${_tokenInf?.symbol ?? 'DFY'}',
                                    isToken: true,
                                  ),
                                DetailItemApproveModel(
                                  title: '${S.current.duration} :',
                                  value:
                                      '${(durationTime ?? 0) ~/ 60} ${S.current.hour} '
                                      '${(durationTime ?? 0 % 60) > 0 ? (durationTime ?? 0 % 60).toInt().toString() + ' ' + S.current.minute : ''} \n'
                                      '${S.current.from} ${timeStartController.text} '
                                      '${dateStartController.text} ',
                                ),
                              ],
                              textActiveButton: S.current.put_on_auction,
                              typeApprove: TYPE_CONFIRM_BASE.PUT_ON_AUCTION,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: ButtonGold(
                    title: S.current.continue_s,
                    isEnable: data,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 38,
            )
          ],
        ),
      ),
    );
  }

  Widget datetimePickerCustom({
    required String date,
    required String time,
    required TextEditingController timeController,
    required TextEditingController dateController,
    required typeInputDateTime type,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: AppTheme.getInstance().backgroundBTSColor(),
      ),
      height: 116,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      ImageAssets.ic_clock_white,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final Map<String, String>? result = await showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (_) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: const AlertDialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              content: PickTime(),
                            ),
                          ),
                        );
                        if (result != null) {
                          final String hour = result.stringValueOrEmpty('hour');
                          final String minute =
                              result.stringValueOrEmpty('minute');
                          timeController.text = '$hour : $minute';
                          validateDuration();
                        }
                      },
                      child: TextField(
                        controller: timeController,
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: time,
                          hintStyle: textNormal(
                            Colors.white.withOpacity(0.5),
                            16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 1,
              color: AppTheme.getInstance().divideColor(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      ImageAssets.ic_calendar,
                      height: 20,
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration.zero,
                            opaque: false,
                            pageBuilder: (_, __, ___) {
                              return CustomCalendar(
                                selectDate:
                                    DateTime.tryParse(dateController.text),
                              );
                            },
                          ),
                        );
                        if (result != null) {
                          final date = DateFormat('yyyy-MM-dd').format(result);
                          dateController.text = date;
                          validateDuration();
                        }
                      },
                      child: TextField(
                        controller: dateController,
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: date,
                          hintStyle: textNormal(
                            Colors.white.withOpacity(0.5),
                            16,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

enum typeInputDateTime { START, END }
