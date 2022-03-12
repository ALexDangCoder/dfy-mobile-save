import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/list_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/upload_document_widget.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_fail.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/video_player/video_player_view.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/circle_status_provide_nft.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/upload_image_widget.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

enum NFT_TYPE {
  JEWELRY,
  ARTWORK,
  CAR,
  WATCH,
  HOUSE,
  OTHER,
}

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class Step1WhenSubmit extends StatefulWidget {
  const Step1WhenSubmit({
    Key? key,
    this.assetId,
    this.cubit,
  }) : super(key: key);
  final String? assetId;
  final ProvideHardNftCubit? cubit;

  @override
  _Step1WhenSubmitState createState() => _Step1WhenSubmitState();
}

class _Step1WhenSubmitState extends State<Step1WhenSubmit> {
  late ProvideHardNftCubit cubit;

  @override
  void initState() {
    super.initState();
    if (widget.cubit != null) {
      cubit = widget.cubit ?? ProvideHardNftCubit();
    } else {
      cubit = ProvideHardNftCubit();
    }

    ///if from mintRequest Screen use it like param else
    ///default asset from cubit
    if (widget.assetId != null) {
      cubit.checkStatusBeHandle(assetId: widget.assetId ?? '');
    } else {
      cubit.checkStatusBeHandle(assetId: cubit.assetId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProvideHardNftCubit, ProvideHardNftState>(
      listener: (context, state) {
        if (state is CreateStep1Submitting) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => const AlertDialog(
              backgroundColor: Colors.transparent,
              content: TransactionSubmit(),
            ),
          );
        } else if (state is CreateStep1SubmittingSuccess) {
          final NavigatorState navigator = Navigator.of(context);
          unawaited(
            navigator
                .push(
                  MaterialPageRoute(
                    builder: (context) => Approve(
                      // needApprove: true,
                      hexString: cubit.hexStringWeb3,
                      payValue: cubit.dataStep1.amountToken.toString(),
                      tokenAddress: Get.find<AppConstants>().contract_defy,
                      title: S.current.create_hard_nft,
                      listDetail: [
                        DetailItemApproveModel(
                          title: '${S.current.name} :',
                          value: cubit.dataStep1.hardNftName,
                        ),
                        DetailItemApproveModel(
                          title: '${S.current.type} :',
                          value: cubit.dataStep1.hardNftType.name ?? '',
                        ),
                        DetailItemApproveModel(
                          title: '${S.current.collection} :',
                          value: cubit.dataStep1.collection,
                        ),
                      ],
                      onErrorSign: (context) async {
                        final nav = Navigator.of(context);
                        nav.pop();
                        await showLoadFail(context);
                      },
                      onSuccessSign: (context, data) {
                        cubit.bcTxnHashModel.bc_txn_hash = data;
                        cubit.putHardNftBeforeConfirm(
                          cubit.assetId,
                          cubit.bcTxnHashModel,
                        );
                        showLoadSuccess(context).then((_) {
                          /// đoạn này confirm blockchain xong thì check status cuả
                          /// để trở lại màn hình
                          Navigator.pop(context);
                          Navigator.pop(context);
                          if (widget.assetId != null) {
                            cubit.checkStatusBeHandle(
                                assetId: widget.assetId ?? '');
                          } else {
                            cubit.checkStatusBeHandle(assetId: cubit.assetId);
                          }
                        });
                      },
                      textActiveButton: S.current.request_evaluation,
                      spender: Get.find<AppConstants>().eva,
                    ),
                  ),
                )
                .then(
                  (value) async => {
                    Navigator.pop(context),
                    if (widget.assetId != null)
                      await cubit.checkStatusBeHandle(
                          assetId: widget.assetId ?? '')
                    else
                      cubit.checkStatusBeHandle(assetId: cubit.assetId),
                  },
                ),
          );
        } else if (state is CreateStep1SubmittingFail) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const AlertDialog(
              backgroundColor: Colors.transparent,
              content: TransactionSubmitFail(),
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          }).then((value) => Navigator.pop(context));
        }
      },
      bloc: cubit,
      builder: (ctx, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () async {},
          textEmpty: '',
          child: _content(state, ctx),
        );
      },
    );
  }

  Widget _content(ProvideHardNftState state, BuildContext context) {
    if (state is CreateStep1LoadingSuccess) {
      return RefreshIndicator(
        onRefresh: () async {
          if (cubit.statusWhenSubmit != null) {
            if (widget.assetId != null) {
              await cubit.checkStatusBeHandle(
                  assetId: widget.assetId ?? '', isRefresh: true);
            } else {
              await cubit.checkStatusBeHandle(
                assetId: cubit.assetId,
                isRefresh: true,
              );
            }
          } else {}
        },
        child: BaseDesignScreen(
          isImage: true,
          text: ImageAssets.ic_close,
          onRightClick: () {
            //todo handle thêm case của mint request của a hưng
            Navigator.of(context)
              ..pop()
              ..pop()
              ..pop();
          },
          title: S.current.provide_hard_nft_info,
          bottomBar:
              _buttonByState(context, assetIdMintRq: widget.assetId ?? ''),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                spaceH24,
                const Center(child: CircleStatusProvideHardNft()),
                spaceH32,
                textShowWithPadding(
                  textShow: 'HARD NFT ${S.current.picture}/ VIDEO',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH20,
                if ((widget.assetId ?? '').isNotEmpty)
                  _buildPictureVidHardNft()
                else
                  UploadImageWidget(
                    //widget chỉ từ step 1 sang
                    cubit: cubit,
                    showAddMore: false,
                  ),
                spaceH20,
                _widgetListDocument(),
                textShowWithPadding(
                  textShow: S.current.hard_nft_info,
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH16,
                Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        imageNftByTypeSelect(
                          id: cubit.dataDetailAsset.assetType?.id ?? 0,
                        ),
                        spaceW4,
                        Text(
                          cubit.dataDetailAsset.name ?? '',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            24,
                            FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                spaceH8,
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                    ),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          cubit.dataDetailAsset.assetType?.name ?? '',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                        spaceW4,
                        Container(
                          width: 1.w,
                          height: 12.h,
                          color: AppTheme.getInstance().whiteColor(),
                        ),
                        spaceW5,
                        Text(
                          cubit.dataDetailAsset.condition?.name ?? '',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                        spaceW4,
                        Container(
                          width: 1.w,
                          height: 12.h,
                          color: AppTheme.getInstance().whiteColor(),
                        ),
                        spaceW5,
                        Text(
                          S.current.expecting_for,
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                        spaceW4,
                        SizedBox(
                          width: 16.w,
                          height: 16.h,
                          child: Image.asset(
                            ImageAssets.getSymbolAsset(
                              cubit.dataDetailAsset.expectingPriceSymbol ?? DFY,
                            ),
                          ),
                        ),
                        spaceW4,
                        Text(
                          '${formatValue.format(cubit.dataDetailAsset.expectingPrice)}'
                          ' ${cubit.dataDetailAsset.expectingPriceSymbol ?? DFY}',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                ///
                //todo start widget information text
                textShowWithPadding(
                  textShow: cubit.dataDetailAsset.additionalInfo ?? '',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteOpacityDot5(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH12,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16.w,
                    ),
                    child: Wrap(
                      runSpacing: 10.h,
                      children: (cubit.dataDetailAsset.additionalInfoList ?? [])
                          .map((e) {
                        final int index =
                            (cubit.dataDetailAsset.additionalInfoList ?? [])
                                .indexOf(e);
                        return itemProperty(
                          property: e.traitType ?? '',
                          value: e.value ?? '',
                          index: index,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                //todo end
                spaceH20,
                textShowWithPadding(
                  textShow: S.current.contact_info,
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH12,
                //4 widget contact info todo start
                informationContactWidget(
                  title: cubit.dataDetailAsset.contactName ?? '',
                  image: ImageAssets.profileStep1,
                ),
                spaceH15,
                informationContactWidget(
                  title: cubit.dataDetailAsset.contactEmail ?? '',
                  image: ImageAssets.mailStep1,
                ),
                spaceH15,
                informationContactWidget(
                  title: '(${cubit.dataDetailAsset.contactPhoneCode?.code}) '
                      '${cubit.dataDetailAsset.contactPhone}',
                  image: ImageAssets.callStep1,
                ),
                spaceH15,
                informationContactWidget(
                  title: cubit.dataDetailAsset.contactAddress ?? '',
                  image: ImageAssets.locationStep1,
                ),
                spaceH32,
                textShowWithPadding(
                  textShow: S.current.wallet_and_collection,
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH16,
                widgetShowCollectionFtWallet(
                  isWallet: true,
                  walletAddress: cubit.dataDetailAsset.walletAddress
                      ?.formatAddressWallet(),
                ),
                spaceH18,
                widgetShowCollectionFtWallet(
                  nameCollection: cubit.dataDetailAsset.collection?.name ?? '',
                  isWallet: false,
                ),
                spaceH46,
              ],
            ),
          ),
        ),
      );
    } else {
      return const ModalProgressHUD(
        inAsyncCall: true,
        progressIndicator: CupertinoLoading(),
        child: SizedBox(),
      );
    }
  }

  Widget _buildPictureVidHardNft() {
    if (cubit.handleTypeImgOrVid() == TypeMedia.VID) {
      return Column(
        children: [
          VideoPlayerView(
            urlVideo:
                '${ApiConstants.URL_BASE}${(cubit.dataDetailAsset.mediaList ?? [])[0].cid}',
            isJustWidget: true,
          ),
          spaceH8,
          if ((cubit.dataDetailAsset.mediaList ?? []).length > 2)
            textShowWithPadding(
              textShow:
                  '${S.current.and} ${(cubit.dataDetailAsset.mediaList ?? []).length - 1} ${S.current.other_file}',
              txtStyle: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                24,
                FontWeight.w600,
              ),
            )
          else
            Container(),
        ],
      );
    } else {
      return Column(
        children: [
          FadeInImage.assetNetwork(
            placeholder: ImageAssets.image_loading,
            image:
                '${ApiConstants.URL_BASE}${(cubit.dataDetailAsset.mediaList ?? [])[0].cid}',
            imageCacheHeight: 290,
            imageErrorBuilder: (context, url, error) {
              return Center(
                child: Text(
                  S.current.unload_image,
                  style: textNormalCustom(
                    Colors.white,
                    14,
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
            placeholderCacheHeight: 200,
            fit: BoxFit.cover,
          ),
          spaceH8,
          if ((cubit.dataDetailAsset.mediaList ?? []).length > 2)
            textShowWithPadding(
              textShow:
                  '${S.current.and} ${(cubit.dataDetailAsset.mediaList ?? []).length - 1} ${S.current.other_file}',
              txtStyle: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                24,
                FontWeight.w600,
              ),
            )
          else
            Container(),
        ],
      );
    }
  }

  Widget _buttonByState(BuildContext context, {required String assetIdMintRq}) {
    return StreamBuilder<StateButton>(
      initialData:
          assetIdMintRq.isEmpty ? StateButton.PROCESSING : StateButton.DEFAULT,
      stream: cubit.stateButton.stream,
      builder: (context, snapshot) {
        if ((snapshot.data ?? StateButton.DEFAULT) ==
            StateButton.FINDEVALUATOR) {
          return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ListBookEvaluation(
                        assetId: cubit.assetId,
                      );
                    },
                    settings: const RouteSettings(
                      name: AppRouter.step2ListBook,
                    ),
                  ),
                ).then((value) => Navigator.pop(context));
              },
              child: Container(
                  padding: EdgeInsets.only(
                    bottom: 38.h,
                    left: 16.w,
                    right: 16.w,
                  ),
                  color: AppTheme.getInstance().bgBtsColor(),
                  child: const ButtonGold(
                      title: 'Find evaluator', isEnable: true)));
        } else if ((snapshot.data ?? StateButton.DEFAULT) ==
            StateButton.PROCESSING) {
          return Container(
              padding: EdgeInsets.only(
                bottom: 38.h,
                left: 16.w,
                right: 16.w,
              ),
              color: AppTheme.getInstance().bgBtsColor(),
              child: const ButtonGold(
                title: 'Processing',
                isEnable: true,
                isProcessing: true,
              ));
        } else {
          return Container(
            padding: EdgeInsets.only(
              bottom: 38.h,
              left: 16.w,
              right: 16.w,
            ),
            color: AppTheme.getInstance().bgBtsColor(),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: ButtonGold(
                      haveGradient: false,
                      textColor: AppTheme.getInstance().yellowColor(),
                      border: Border.all(
                        color: AppTheme.getInstance().yellowColor(),
                      ),
                      radiusButton: 22,
                      textSize: 16,
                      title: S.current.edit_info,
                      isEnable: true,
                      fixSize: false,
                      height: 64.h,
                      haveMargin: false,
                    ),
                  ),
                ),
                const SizedBox(width: 23),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      await cubit.putInfoToBlockChain();
                    },
                    child: ButtonGold(
                      radiusButton: 22,
                      textSize: 16,
                      title: S.current.submit,
                      isEnable: true,
                      height: 64.h,
                      fixSize: false,
                      haveMargin: false,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Visibility _widgetListDocument() {
    return Visibility(
      visible: (cubit.dataDetailAsset.documentList ?? []).isNotEmpty,
      child: Column(
        children: [
          textShowWithPadding(
            textShow: S.current.documents,
            txtStyle: textNormalCustom(
              AppTheme.getInstance().unselectedTabLabelColor(),
              14,
              FontWeight.w400,
            ),
          ),
          spaceH20,
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: (cubit.dataDetailAsset.documentList ?? []).length,
            itemBuilder: (ctx, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  textShowWithPadding(
                    textShow: (cubit.dataDetailAsset.documentList ?? [])[index]
                            .name ??
                        '',
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  if (index ==
                      (cubit.dataDetailAsset.documentList ?? []).length)
                    spaceH32
                  else
                    spaceH16,
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Container textShowWithPadding({
    required String textShow,
    required TextStyle txtStyle,
    String? typeFile,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          textShow,
          style: txtStyle,
        ),
      ),
    );
  }

  Container itemProperty({
    bool isHaveClose = false,
    required String property,
    required String value,
    required int index,
  }) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().whiteDot2(),
        ),
      ),
      margin: EdgeInsets.only(right: 20.w),
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                property,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteOpacityDot5(),
                  12,
                  FontWeight.w400,
                ),
              ),
              Text(
                value,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  14,
                  FontWeight.w400,
                ),
              )
            ],
          ),
          Visibility(
            visible: isHaveClose ? true : false,
            child: InkWell(
              onTap: () {
                cubit.propertiesData.removeAt(index);
                cubit.checkPropertiesWhenSave(property: '', value: '');
              },
              child: Image.asset(
                ImageAssets.closeProperties,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container informationContactWidget({
    required String title,
    required String image,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24.h,
                width: 24.h,
                child: Image.asset(image),
              ),
              spaceW6,
              Text(
                title,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16,
                  FontWeight.w400,
                ),
              )
            ],
          ),
          spaceH15,
        ],
      ),
    );
  }

  Container widgetShowCollectionFtWallet({
    required bool isWallet,
    String? walletAddress,
    String? nameCollection,
  }) {
    return isWallet
        ? Container(
            padding: EdgeInsets.only(
              left: 16.w,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: Image.asset(
                    ImageAssets.walletStep1,
                  ),
                ),
                spaceW6,
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: '${S.current.wallet} ',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: walletAddress,
                          style: textNormalCustom(
                            AppTheme.getInstance().blueText(),
                            16,
                            FontWeight.w500,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: ' ${S.current.will_receive_nft}',
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.only(
              left: 16.w,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: Image.asset(
                    ImageAssets.collectionStep1,
                  ),
                ),
                spaceW6,
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: '${S.current.hard_nft_will_be_create} ',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: nameCollection,
                          style: textNormalCustom(
                            AppTheme.getInstance().blueText(),
                            16,
                            FontWeight.w500,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  SizedBox imageNftByTypeSelect({required int id}) {
    String imageNFT = '';
    switch (id) {
      case 2:
        imageNFT = ImageAssets.artWork;
        break;
      case 4:
        imageNFT = ImageAssets.car;
        break;
      case 3:
        imageNFT = ImageAssets.house;
        break;
      case 0:
        imageNFT = ImageAssets.diamond;
        break;
      case 1:
        imageNFT = ImageAssets.watch;
        break;
      default:
        //case other
        imageNFT = ImageAssets.others;
        break;
    }
    return SizedBox(
      width: 24.w,
      height: 24.h,
      child: Image.asset(imageNFT),
    );
  }
}
