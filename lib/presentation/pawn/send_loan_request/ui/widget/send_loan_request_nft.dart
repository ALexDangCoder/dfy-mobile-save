import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/confirm_send_loan_nft.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/list_select_nft_collateral.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SendLoanRequestNft extends StatefulWidget {
  const SendLoanRequestNft({
    Key? key,
    required this.cubit,
    required this.packageId,
    required this.type,
  }) : super(key: key);

  final SendLoanRequestCubit cubit;
  final String packageId;
  final int type;

  @override
  _SendLoanRequestNftState createState() => _SendLoanRequestNftState();
}

class _SendLoanRequestNftState extends State<SendLoanRequestNft> {
  late TextEditingController loanController;
  late TextEditingController durationController ;
  late TextEditingController messageController;
  late Map<String, dynamic> itemToken;
  late Map<String, dynamic> itemDuration;

  @override
  void initState() {
    super.initState();
    loanController = TextEditingController();
    durationController = TextEditingController();
    messageController = TextEditingController();
    widget.cubit.getTokensRequestNft();
    itemToken = widget.cubit.listDropDownToken[0];
    itemDuration = widget.cubit.listDropDownDuration[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        // vertical: 16.h,
      ),
      child: Column(
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
          SizedBox(
            height: 64.h,
            child: TextFieldValidator(
              controller: messageController,
              hint: 'Enter message',
              onChange: (value) {
                widget.cubit.nftRequest.message = value;
                widget.cubit.validateMessage(value);
                widget.cubit.validateAll();
              },
            ),
          ),
          _txtWarning(
            isShowStream: widget.cubit.isShowMessage,
            txtWarningStream: widget.cubit.txtWarnMess,
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
          SizedBox(
            height: 64.h,
            child: TextFieldValidator(
              controller: loanController,
              hint: 'Loan amount',
              textInputType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              onChange: (value) {
                widget.cubit.validateAmount(value);
                widget.cubit.validateAll();
              },
              suffixIcon: DropdownButtonHideUnderline(
                child: DropdownButton<Map<String, dynamic>>(
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                  dropdownColor: AppTheme.getInstance().backgroundBTSColor(),
                  items: widget.cubit.listDropDownToken.map((model) {
                    return DropdownMenuItem(
                      value: model,
                      child: Row(
                        children: <Widget>[
                          model['icon'],
                          spaceW5,
                          Text(
                            model['label'],
                            style: textNormal(
                              Colors.white,
                              16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Map<String, dynamic>? newValue) {
                    setState(() {
                      widget.cubit.nftRequest.loanSymbol = newValue!['label'];
                      itemToken = newValue;
                    });
                  },
                  value: itemToken,
                  icon: Row(
                    children: [
                      spaceW15,
                      SizedBox(
                        height: 70.h,
                        child: sizedSvgImage(
                          w: 13,
                          h: 13,
                          image: ImageAssets.ic_expand_white_svg,
                        ),
                      ),
                      spaceW15,
                    ],
                  ),
                ),
              ),
            ),
          ),
          _txtWarning(
            isShowStream: widget.cubit.isShowLoanToken,
            txtWarningStream: widget.cubit.txtWarnLoan,
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
          SizedBox(
            height: 64.h,
            child: StreamBuilder<bool>(
              initialData: true,
              stream: widget.cubit.isMonthForm,
              builder: (context, snapshot) {
                return TextFieldValidator(
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  controller: durationController,
                  hint: 'Duration',
                  onChange: (value) {
                    widget.cubit.validateDuration(
                      value,
                      isMonth: snapshot.data ?? false,
                    );
                    widget.cubit.validateAll();
                  },
                  suffixIcon: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, dynamic>>(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      dropdownColor:
                          AppTheme.getInstance().backgroundBTSColor(),
                      items: widget.cubit.listDropDownDuration.map((model) {
                        return DropdownMenuItem(
                          value: model,
                          child: Text(
                            model['label'],
                            style: textNormal(
                              Colors.white,
                              16,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (Map<String, dynamic>? newValue) {
                        setState(() {
                          if (newValue!['label'] == 'month') {
                            widget.cubit.nftRequest.durationType = 1;
                            widget.cubit.isMonthForm.sink.add(true);
                          } else {
                            widget.cubit.nftRequest.durationType = 0;
                            widget.cubit.isMonthForm.sink.add(false);
                          }
                          itemDuration = newValue;
                        });
                      },
                      value: itemDuration,
                      icon: Row(
                        children: [
                          spaceW15,
                          SizedBox(
                            height: 70.h,
                            child: sizedSvgImage(
                              w: 13,
                              h: 13,
                              image: ImageAssets.ic_expand_white_svg,
                            ),
                          ),
                          spaceW15,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _txtWarning(
            isShowStream: widget.cubit.isShowDuration,
            txtWarningStream: widget.cubit.txtWarnDuration,
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
                child: Text(
                  'Login to receive email notifications',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
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
                onTap: () async {
                  if (snapshot.data ?? false) {
                    if (widget.cubit.nftType != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmSendLoanNft(
                            cubit: widget.cubit,
                          ),
                        ),
                      );
                    } else {
                      final NavigatorState navigator = Navigator.of(context);
                      await widget.cubit.getHexString(
                        pawnShopPackageId: widget.packageId,
                        nftTokenQuantity: 1.toString(),
                        //todo
                        nftTokenId:
                            widget.cubit.nftMarketFill.value?.nftTokenId ?? '',
                        nftContract: widget
                                .cubit.nftMarketFill.value?.collectionAddress ??
                            '',
                        expectedlLoanAmount: loanController.text,
                        beNFTId: widget.cubit.nftMarketFill.value?.nftId ?? '',
                        loanAsset:
                            ImageAssets.getAddressToken(itemToken['label']),
                        expectedDurationQty: durationController.text,
                        message: messageController.text,
                        durationType:
                            widget.cubit.nftMarketConfirm.durationType ?? 0,
                      );
                      unawaited(
                        navigator.push(
                          MaterialPageRoute(
                            builder: (context) => Approve(
                              needApprove: true,
                              textActiveButton: 'Confirm loan request',
                              spender: Get.find<AppConstants>().nftPawn,
                              isPutOnMarket: true,
                              payValue: loanController.text,
                              tokenAddress: ImageAssets.getAddressToken(
                                itemToken['label'],
                              ),
                              putOnMarketModel: PutOnMarketModel(
                                collectionAddress: widget.cubit.nftMarketFill
                                    .value?.collectionAddress,
                              ),
                              hexString: widget.cubit.hexString,
                              title: 'Confirm loan request',
                              onSuccessSign: (context, data) async {
                                final result = await widget.cubit.putOnPawn(
                                  txHash: data,
                                  putOnMarketModel: PutOnMarketModel(
                                    nftTokenId: int.parse(widget.cubit
                                            .nftMarketFill.value?.nftTokenId ??
                                        '0'),
                                    loanSymbol: itemToken['label'],
                                    tokenAddress: ImageAssets.getAddressToken(
                                        itemToken['label']),
                                    loanAmount: loanController.text,
                                    collectionAddress: widget.cubit
                                        .nftMarketFill.value?.collectionAddress,
                                    buyOutPrice: widget
                                        .cubit.nftMarketFill.value?.buyOutPrice
                                        .toString(),
                                    collectionIsWhitelist: widget
                                        .cubit.nftMarketFill.value?.isWhitelist,
                                    collectionName: widget.cubit.nftMarketFill
                                        .value?.collectionName,
                                    nftId:
                                        widget.cubit.nftMarketFill.value?.nftId,
                                    nftMediaCid:
                                        widget.cubit.nftMarketFill.value?.cover,
                                    nftMediaType: widget.cubit.nftMarketFill
                                                .value?.typeImage ==
                                            TypeImage.VIDEO
                                        ? 'video'
                                        : 'image',
                                    nftName:
                                        widget.cubit.nftMarketFill.value?.name,
                                    nftStandard: ERC721,
                                    nftType: (widget.cubit.nftMarketFill.value
                                                ?.typeNFT ==
                                            TypeNFT.SOFT_NFT)
                                        ? 0
                                        : 1,
                                    numberOfCopies: widget.cubit.nftMarketFill
                                        .value?.numberOfCopies,
                                    totalOfCopies: widget
                                        .cubit.nftMarketFill.value?.totalCopies,
                                  ),
                                );
                                if (result) {
                                  await showLoadSuccess(context).then((value) {
                                    widget.cubit.nftRequest.walletAddress =
                                        PrefsService.getCurrentBEWallet();
                                    widget.cubit.nftRequest.txId = null;
                                    widget.cubit.nftRequest.nftId =
                                        widget.cubit.nftMarketFill.value?.nftId;
                                    widget.cubit.nftRequest.message =
                                        messageController.text;
                                    widget.cubit.nftRequest.loanAmount =
                                        double.parse(loanController.text);
                                    widget.cubit.nftRequest.loanSymbol =
                                        itemToken['label'];
                                    widget.cubit.nftRequest.durationTime =
                                        int.parse(durationController.text);
                                    widget.cubit.nftRequest.durationType =
                                        (itemDuration['label'] == 'month')
                                            ? 1
                                            : 0;
                                    widget.cubit.nftRequest.pawnShopPackageId =
                                        int.parse(widget.packageId);
                                    widget.cubit.nftRequest.collateralSymbol =
                                        itemToken['label'];
                                    widget.cubit.nftRequest.collateralId =
                                        widget.cubit.idCollateral ;
                                    widget.cubit.nftRequest.marketType = (widget
                                                .cubit
                                                .nftMarketFill
                                                .value
                                                ?.typeNFT ==
                                            TypeNFT.SOFT_NFT)
                                        ? 0
                                        : 1;
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ConfirmSendLoanNft(
                                          cubit: widget.cubit,
                                        ),
                                      ),
                                    );
                                  });
                                } else {
                                  await showLoadFail(context);
                                }
                              },
                              onErrorSign: (context) async {
                                await showLoadFail(context);
                              },
                              listDetail: [],
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: ButtonGold(
                  haveMargin: false,
                  title: 'Request loan',
                  isEnable: snapshot.data ?? false,
                ),
              );
            },
          ),
          // spaceH35
          // SizedBox(height: 200.h,),
        ],
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
                      final value = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ListSelectNftCollateral( cubit: widget.cubit);
                          },
                        ),
                      );
                      widget.cubit.emit(GetWalletSuccess());
                      if (value != null) {
                        value;
                        durationController.text = '10';

                        // value;
                        // widget.cubit.nftMarketFill.sink.add(value[0]);
                        // widget.cubit.mapValidate['chooseNFT'] = true;
                        // durationController.text =
                        //     (value[1] ?? '1').toString();
                        // widget.cubit.validateDuration(
                        //   durationController.text,
                        //   isMonth: int.parse(value[2]) == 0 ? false : true,
                        // );
                        // loanController.text = value[4];
                        // widget.cubit.validateAmount(loanController.text);
                        // itemToken = widget.cubit.listDropDownToken.firstWhere(
                        //       (element) =>
                        //   element['label'] ==
                        //       (value[3] ?? 'DFY'),
                        // );
                        // itemDuration = widget.cubit.listDropDownDuration
                        //     .firstWhere((element) =>
                        // element['label'] ==
                        //     (int.parse(value[2]) == 0 ? 'month' : 'week'));
                        // widget.cubit.validateMessage(messageController.text);
                        // widget.cubit.validateAll();
                        // ///fill data to request to post
                        // ///
                        // widget.cubit.nftType = value[0].marketStatus ?? 1;
                        // widget.cubit.nftMarketConfirm = value[0];
                        // widget.cubit.nftRequest.durationType =
                        //     int.parse(value[2]);
                        // widget.cubit.nftRequest.collateralId =
                        //     value[0].collateralId;
                        // widget.cubit.nftRequest.walletAddress =
                        //     value[0].walletAddress;
                        // widget.cubit.nftRequest.marketType =
                        // value[0].typeNFT == TypeNFT.SOFT_NFT ? 0 : 1;
                        // widget.cubit.nftRequest.nftId = value[0].nftId ?? '';
                        // widget.cubit.nftRequest.pawnShopPackageId =
                        //     int.parse(widget.packageId);
                        // widget.cubit.nftRequest.durationTime =
                        //     int.parse(value[1]);
                        // widget.cubit.nftRequest.txId =
                        // null; //case nay dang de null
                        // widget.cubit.nftRequest.collateralSymbol =
                        // value[3];
                        // widget.cubit.nftRequest.loanAmount = double.parse(value[4]);
                        ///end

                      }

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
                          widget.cubit.mapValidate['formLoan'] = false;
                          widget.cubit.mapValidate['formDuration'] = false;
                          loanController.text = '';
                          durationController.text = '';
                          widget.cubit.validateAll();
                        },
                        child: Image.asset(ImageAssets.ic_close),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _txtWarning({
    required Stream<bool> isShowStream,
    required Stream<String> txtWarningStream,
  }) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: isShowStream,
      builder: (context, snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: StreamBuilder<String>(
            initialData: '',
            stream: txtWarningStream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                ),
                child: Text(
                  snapshot.data ?? '',
                  style: textNormalCustom(
                    AppTheme.getInstance().redMarketColors(),
                    12,
                    FontWeight.w400,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
