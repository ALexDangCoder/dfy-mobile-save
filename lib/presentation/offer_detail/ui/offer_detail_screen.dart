import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/offer_detail.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/offer_detail/bloc/offer_detail_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/base_items/base_fail.dart';
import 'package:Dfy/widgets/base_items/base_success.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/button/button_transparent.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferDetailScreen extends StatefulWidget {
  const OfferDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  late final OfferDetailCubit _cubit;
  late String owner;

  @override
  void initState() {
    _cubit = OfferDetailCubit();
    onRefresh();
    super.initState();
  }

  Future<void> onRefresh() async {
    await _cubit.getOfferDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      error: AppException(S.current.error, S.current.something_went_wrong),
      retry: onRefresh,
      textEmpty: '',
      stream: _cubit.stateStream,
      child: BaseBottomSheet(
        title: S.current.offer_detail,
        isImage: true,
        text: ImageAssets.ic_close,
        onRightClick: () {},
        child: StreamBuilder<OfferDetailModel>(
          stream: _cubit.offerStream,
          builder: (context, snapshot) {
            final offer = snapshot.data;
            return snapshot.data != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        spaceH20,
                        Text(
                          (offer?.walletAddress ?? '').formatAddress(index: 4),
                          style: richTextWhite.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        spaceH8,
                        _rowStar(40),
                        spaceH18,
                        _textButton(),
                        Divider(
                          color: AppTheme.getInstance().divideColor(),
                        ),
                        spaceH20,
                        ..._buildTable(offer),
                        if (offer?.status == 3 &&
                            PrefsService.getOwnerPawn().toLowerCase() ==
                                PrefsService.getCurrentBEWallet()
                                    .toLowerCase()) ...[
                          Container(
                            margin: EdgeInsets.only(top: 152.h),
                            padding: EdgeInsets.only(
                              bottom: 38.h,
                              right: 16.w,
                              left: 16.w,
                            ),
                            color: AppTheme.getInstance().bgBtsColor(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildButtonReject(context, offer!),
                                ),
                                spaceW25,
                                Expanded(
                                  child: _buildButtonAccept(context, offer),
                                ),
                              ],
                            ),
                          ),
                        ]
                      ],
                    ),
                  )
                : ColoredBox(color: AppTheme.getInstance().bgBtsColor());
          },
        ),
      ),
    );
  }

  List<Widget> _buildTable(OfferDetailModel? data) => [
        buildRowCustom(
          title: '${S.current.status}:',
          child: Text(
            _cubit.colorText.status ?? '',
            style: textNormalCustom(
              _cubit.colorText.color,
              16,
              FontWeight.w600,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: '${S.current.message}:',
          child: Text(
            data?.description ?? '',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: S.current.loan_amount,
          child: Row(
            children: [
              if (data?.supplyCurrencySymbol != null)
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: Image.asset(
                    ImageAssets.getSymbolAsset(
                      data?.supplyCurrencySymbol ?? 'DFY',
                    ),
                  ),
                )
              else
                const SizedBox(),
              spaceW4,
              Text(
                '${data?.loanAmount ?? 0}',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
              ),
              spaceW4,
              Text(
                data?.supplyCurrencySymbol ?? '',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: S.current.interest_rate,
          child: Text(
            '${data?.interestRate ?? 0}%',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: S.current.recurring_interest,
          child: Text(
            data?.durationType == ID_MONTH ? S.current.month : S.current.week,
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: '${S.current.repayment_token}:',
          child: Row(
            children: [
              if (data?.repaymentToken != null)
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: Image.asset(
                    ImageAssets.getSymbolAsset(data?.repaymentToken ?? 'DFY'),
                  ),
                )
              else
                const SizedBox(),
              spaceW4,
              Text(
                data?.repaymentToken ?? '',
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: S.current.duration,
          child: Text(
            '${data?.durationQty ?? 0} ${data?.durationType == ID_MONTH ? S.current.month : S.current.week}',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        buildRowCustom(
          title: '${S.current.offer_create_by_day}:',
          child: Text(
            formatDateTime.format(
              DateTime.fromMillisecondsSinceEpoch(
                data?.createdAt?.toInt() ?? 0,
              ),
            ),
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
      ];

  Widget _rowStar(int mark) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.ic_star),
          spaceW12,
          Text(
            '$mark',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              32,
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        S.current.view_profile,
        style: textNormalCustom(
          AppTheme.getInstance().fillColor(),
          16,
          FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildButtonReject(BuildContext context, OfferDetailModel obj) {
    return ButtonTransparent(
      child: Text(
        S.current.reject,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
      onPressed: () {
        _cubit
            .getCancelOfferData(
          obj.collateralId?.toString() ?? '',
          obj.id?.toString() ?? '',
          context,
        )
            .then(
              (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Approve(
                title: S.current.reject_offer,
                spender: nft_pawn_dev2,
                textActiveButton: S.current.reject_offer,
                hexString: value,
                header: Column(
                  children: [
                    buildRowCustom(
                      isPadding: false,
                      title: '${S.current.from}:',
                      child: Text(
                        obj.walletAddress?.formatAddressWalletConfirm() ?? '',
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    buildRowCustom(
                      isPadding: false,
                      title: '${S.current.loan_amount}:',
                      child: Text(
                        '${obj.loanAmount} ${obj.repaymentToken ?? ''}',
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceH20,
                    line,
                  ],
                ),
                onSuccessSign: (context, data) async {
                  Navigator.pop(context);
                  _cubit.rejectOffer(obj.id?.toInt() ?? 0);
                  await showLoadSuccess(context)
                      .then((value) => Navigator.pop(context))
                      .then(
                        (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BaseSuccess(
                          title: S.current.reject_offer,
                          content: S.current.congratulation,
                          callback: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  );
                },
                onErrorSign: (context) async {
                  Navigator.pop(context);
                  await showLoadFail(context)
                      .then((_) => Navigator.pop(context))
                      .then(
                        (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BaseFail(
                          title: S.current.reject_offer,
                          onTapBtn: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonAccept(BuildContext context, OfferDetailModel obj) {
    return ButtonGradient(
      onPressed: () {
        _cubit
            .getAcceptOfferData(
              obj.collateralId?.toString() ?? '',
              obj.id?.toString() ?? '',
              context,
            )
            .then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Approve(
                    title: S.current.accept_offer,
                    spender: nft_pawn_dev2,
                    textActiveButton: S.current.accept,
                    hexString: value,
                    header: Column(
                      children: [
                        buildRowCustom(
                          isPadding: false,
                          title: '${S.current.from}:',
                          child: Text(
                            obj.walletAddress?.formatAddressWalletConfirm() ?? '',
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              16,
                              FontWeight.w400,
                            ),
                          ),
                        ),
                        buildRowCustom(
                          isPadding: false,
                          title: '${S.current.loan_amount}:',
                          child: Text(
                            '${obj.loanAmount} ${obj.repaymentToken ?? ''}',
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              16,
                              FontWeight.w400,
                            ),
                          ),
                        ),
                        spaceH20,
                        line,
                      ],
                    ),
                    onSuccessSign: (context, data) async {
                      Navigator.pop(context);
                      _cubit.acceptOffer(obj.id?.toInt() ?? 0);
                      await showLoadSuccess(context)
                          .then((value) => Navigator.pop(context))
                          .then(
                            (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BaseSuccess(
                                  title: S.current.accept_offer,
                                  content: S.current.congratulation,
                                  callback: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          );
                    },
                    onErrorSign: (context) async {
                      Navigator.pop(context);
                      await showLoadFail(context)
                          .then((_) => Navigator.pop(context))
                          .then(
                            (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BaseFail(
                                  title: S.current.accept,
                                  onTapBtn: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          );
                    },
                  ),
                ),
              ),
            );
      },
      gradient: RadialGradient(
        center: const Alignment(0.5, -0.5),
        radius: 4,
        colors: AppTheme.getInstance().gradientButtonColor(),
      ),
      child: Text(
        S.current.accept,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          16,
          FontWeight.w700,
        ),
      ),
    );
  }
}
//todo
