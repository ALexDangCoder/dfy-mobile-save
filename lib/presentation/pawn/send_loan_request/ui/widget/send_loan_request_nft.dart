import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/confirm_send_loan_nft.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/form_dropdown.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/list_select_nft_collateral.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendLoanRequestNft extends StatefulWidget {
  const SendLoanRequestNft({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final SendLoanRequestCubit cubit;

  @override
  _SendLoanRequestNftState createState() => _SendLoanRequestNftState();
}

class _SendLoanRequestNftState extends State<SendLoanRequestNft> {
  final GlobalKey<FormGroupState> _key = GlobalKey<FormGroupState>();
  final TextEditingController loanController = TextEditingController();
  late Map<String, dynamic> tokenSymbol;

  @override
  void initState() {
    super.initState();
    widget.cubit.getTokensRequestNft();
    tokenSymbol = widget.cubit.listDropDownToken[0];
  }

  @override
  Widget build(BuildContext context) {
    return FormGroup(
      key: _key,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _chooseNftFtFillNft(context),
            spaceH36,
            Text(
              'Message',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
            spaceH4,
            TextFieldValidator(
              hint: 'Enter message',
              onChange: (value) {
                widget.cubit.mapValidate['form'] =
                    _key.currentState?.checkValidator() ?? false;
                widget.cubit.validateAll();
              },
              validator: (value) {
                return widget.cubit.validateMessage(value ?? '');
              },
            ),
            spaceH16,
            Text(
              'Loan amount',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
            spaceH4,
            TextFieldValidator(
              controller: loanController,
              hint: 'Loan amount',
              onChange: (value) {
                widget.cubit.mapValidate['form'] =
                    _key.currentState?.checkValidator() ?? false;
                widget.cubit.validateAll();
              },
              validator: (value) {
                return widget.cubit.validateAmount(value ?? '');
              },
              suffixIcon: FormDropDownWidget(
                widthDropDown: 100.w,
                heightDropDown: 300.h,
                listDropDown: widget.cubit.listDropDownToken,
                initValue: tokenSymbol,
                onChange: (Map<String, dynamic> value) {},
              ),
            ),
            spaceH16,
            Text(
              'Duration',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
            spaceH4,
            StreamBuilder<bool>(
              initialData: true,
              stream: widget.cubit.isMonthForm,
              builder: (context, snapshot) {
                return TextFieldValidator(
                  hint: 'Duration',
                  onChange: (value) {
                    widget.cubit.mapValidate['form'] =
                        _key.currentState?.checkValidator() ?? false;
                    widget.cubit.validateAll();
                  },
                  suffixIcon: FormDropDownWidget(
                    listDropDown: widget.cubit.listDropDownDuration,
                    initValue: widget.cubit.listDropDownDuration[0],
                    heightDropDown: 150.h,
                    widthDropDown: 100.w,
                    onChange: (value) => {
                      if (value['label'] == 'month')
                        {
                          widget.cubit.isMonthForm.sink.add(true),
                        }
                      else
                        {
                          widget.cubit.isMonthForm.sink.add(false),
                        }
                    },
                  ),
                  validator: (value) {
                    return (snapshot.data ?? true)
                        ? widget.cubit.validateDuration(value ?? '')
                        : widget.cubit.validateDuration(
                            value ?? '',
                            isMonth: false,
                          );
                  },
                );
              },
            ),
            spaceH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<bool>(
                    initialData: true,
                    stream: widget.cubit.tickBoxSendRqNft,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          fillColor: MaterialStateProperty.all(
                              AppTheme.getInstance().fillColor()),
                          activeColor: AppTheme.getInstance().activeColor(),
                          // checkColor: const Colors,
                          onChanged: (value) {
                            widget.cubit.tickBoxSendRqNft.sink
                                .add(value ?? false);
                            if (value ?? false) {
                              widget.cubit.mapValidate['tick'] = true;
                              widget.cubit.validateAll();
                            } else {
                              widget.cubit.mapValidate['tick'] = false;
                              widget.cubit.validateAll();
                            }
                          },
                          value: snapshot.data ?? false,
                        ),
                      );
                    }),
                spaceW12,
                SizedBox(
                  width: 287.w,
                  child: Flexible(
                    child: Text(
                      'Login to receive email notifications',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            ),
            spaceH40,
            StreamBuilder<bool>(
                initialData: false,
                stream: widget.cubit.isEnableSendRqNft,
                builder: (context, snapshot) {
                  return InkWell(
                    onTap: () {
                      if (snapshot.data ?? false) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmSendLoanNft(
                              cubit: widget.cubit,
                            ),
                          ),
                        );
                      } else {}
                    },
                    child: ButtonGold(
                      title: 'Request loan',
                      isEnable: snapshot.data ?? false,
                    ),
                  );
                }),
            // SizedBox(height: 200.h,),
          ],
        ),
      ),
    );
  }

  Widget _chooseNftFtFillNft(BuildContext context) {
    return DottedBorder(
      radius: Radius.circular(20.r),
      borderType: BorderType.RRect,
      color: AppTheme.getInstance().dashedColorContainer(),
      child: StreamBuilder<NftMarket?>(
        stream: widget.cubit.nftMarketFill,
        builder: (context, snapshot) {
          return Container(
            height: ((snapshot.data?.name ?? '').isEmpty) ? 172.h : 269.h,
            width: 343.w,
            padding: ((snapshot.data?.name ?? '').isEmpty)
                ? EdgeInsets.only(top: 47.h)
                : EdgeInsets.only(
                    top: 16.h,
                    left: 94.w,
                  ),
            child: ((snapshot.data?.name ?? '').isEmpty)
                ? InkWell(
                    onTap: () async {
                      final NftMarket result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ListSelectNftCollateral(cubit: widget.cubit);
                          },
                        ),
                      );
                      widget.cubit.nftMarketFill.sink.add(result);
                      widget.cubit.mapValidate['chooseNFT'] = true;
                      loanController.text = result.price.toString();
                      widget.cubit
                          .fillTokenAfterChooseNft(result.symbolToken ?? DFY);
                      tokenSymbol = widget.cubit.fillToken;
                      widget.cubit.validateAll();
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          ImageAssets.createNft,
                        ),
                        spaceH16,
                        Text(
                          'Choose your NFT',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            14,
                            FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      NFTItemWidget(
                        nftMarket: snapshot.data ?? NftMarket(),
                        isChoosing: true,
                      ),
                      InkWell(
                        onTap: () {
                          widget.cubit.nftMarketFill.sink.add(NftMarket());
                          widget.cubit.mapValidate['chooseNFT'] = false;
                          widget.cubit.validateAll();
                        },
                        child: Positioned(
                          right: 0.w,
                          child: Image.asset(ImageAssets.ic_close),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
