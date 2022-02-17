import 'dart:async';
import 'dart:math' hide log;
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/ui/collection_list.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/extension/call_api_be.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/base_items/base_success.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadProgress extends StatefulWidget {
  final CreateCollectionCubit bloc;

  const UploadProgress({Key? key, required this.bloc}) : super(key: key);

  @override
  State<UploadProgress> createState() => _UploadProgressState();
}

class _UploadProgressState extends State<UploadProgress>
    with TickerProviderStateMixin {
  late AnimationController _avatarAnimationController;
  late AnimationController _coverAnimationController;
  late AnimationController _featureAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final int rdC = Random().nextInt(3);
    _avatarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: (rdC + 3) * 2),
    );
    _coverAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: rdC + 3),
    );
    _featureAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: (rdC + 3) * 3),
    );
    widget.bloc.cidCreate(context);
    widget.bloc.upLoadStatusSubject.listen((value) {
      if (value == 1) {
        if (_avatarAnimationController.isAnimating) {
          _avatarAnimationController.stop();
        }
        if (_featureAnimationController.isAnimating) {
          _featureAnimationController.stop();
        }
        if (_coverAnimationController.isAnimating) {
          _coverAnimationController.stop();
        }
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Approve(
              hexString: widget.bloc.transactionData,
              onSuccessSign: (context, data) async {
                final navigator = Navigator.of(context);
                unawaited(showLoadingDialog(context));
                await widget.bloc.createCollection(
                  txhHash: data,
                );
                await showLoadSuccess(context)
                    .then(
                      (value) => navigator.popUntil(
                        (route) =>
                            route.isFirst,
                      ),
                    )
                    .then(
                      (value) => navigator.push(
                        MaterialPageRoute(
                          builder: (_) => BaseSuccess(
                            title: S.current.create_collection,
                            content: S.current.create_collection_successfully,
                            callback: () {
                              navigator.pop();
                              navigator.push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CollectionList(
                                    typeScreen: PageRouter.MY_ACC,
                                    addressWallet: widget.bloc.walletAddress,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
              },
              onErrorSign: (context) {},
              listDetail: [
                DetailItemApproveModel(
                  title: '${S.current.name}:',
                  value: widget.bloc.collectionName,
                ),
                DetailItemApproveModel(
                  title: 'URL:',
                  value: widget.bloc.customUrl,
                ),
                DetailItemApproveModel(
                  title: '${S.current.categories}:',
                  value: widget.bloc.categoryId,
                ),
                DetailItemApproveModel(
                  title: '${S.current.royalties}:',
                  value: '${widget.bloc.royalties.toString()} %',
                ),
              ],
              title: S.current.create_collection,
              textActiveButton: S.current.create,
              spender: widget.bloc.collectionType == HARD_COLLECTION
                  ? hard_nft_factory_address_dev2
                  : nft_factory_dev2,
            ),
          ),
        );
      }
      if (value == 0) {
        showErrDialog(
          onCloseDialog: () {
            Navigator.pop(context);
          },
          context: context,
          title: S.current.create_nft,
          content: S.current.something_went_wrong,
        );
      }
    });
  }

  @override
  void dispose() {
    if (_avatarAnimationController.isAnimating) {
      _avatarAnimationController.stop();
    }
    if (_featureAnimationController.isAnimating) {
      _featureAnimationController.stop();
    }
    if (_coverAnimationController.isAnimating) {
      _coverAnimationController.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: StateStreamLayout(
        stream: widget.bloc.stateStream,
        textEmpty: '',
        retry: () {},
        error: AppException('', S.current.something_went_wrong),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().selectDialogColor(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.cover_photo,
                            style: textCustom(
                              fontSize: 12,
                            ),
                          ),
                          StreamBuilder<int>(
                            stream: widget.bloc.coverPhotoUploadStatusSubject,
                            initialData: -1,
                            builder: (context, snapshot) {
                              final status = snapshot.data ?? -1;
                              if (status == -1) {
                                _coverAnimationController.forward();
                                return progressBar(_coverAnimationController);
                              } else if (status == 0) {
                                return uploadFailWidget();
                              } else {
                                return uploadSuccessWidget();
                              }
                            },
                          ),
                          spaceH20,
                          Text(
                            S.current.avatar_photo,
                            style: textCustom(
                              fontSize: 12,
                            ),
                          ),
                          StreamBuilder<int>(
                            stream: widget.bloc.avatarUploadStatusSubject,
                            initialData: -1,
                            builder: (context, snapshot) {
                              final status = snapshot.data ?? -1;
                              if (status == -1) {
                                _avatarAnimationController.forward();
                                return progressBar(_avatarAnimationController);
                              } else if (status == 0) {
                                return uploadFailWidget();
                              } else {
                                return uploadSuccessWidget();
                              }
                            },
                          ),
                          spaceH20,
                          Text(
                            S.current.feature_photo,
                            style: textCustom(
                              fontSize: 12,
                            ),
                          ),
                          StreamBuilder<int>(
                            stream: widget.bloc.featurePhotoUploadStatusSubject,
                            initialData: -1,
                            builder: (context, snapshot) {
                              final status = snapshot.data ?? -1;
                              if (status == -1) {
                                _featureAnimationController.forward();
                                return progressBar(_featureAnimationController);
                              } else if (status == 0) {
                                return uploadFailWidget();
                              } else {
                                return uploadSuccessWidget();
                              }
                            },
                          ),
                          spaceH20,
                        ],
                      ),
                    ),
                    line,
                    StreamBuilder<int>(
                      stream: widget.bloc.upLoadStatusSubject,
                      initialData: -1,
                      builder: (context, snapshot) {
                        final isComplete = snapshot.data ?? -1;
                        return InkWell(
                          onTap: () {
                            if (isComplete == 0) {
                              Navigator.pop(context);
                            }
                          },
                          child: SizedBox(
                            height: 64.h,
                            child: Center(
                              child: Text(
                                'OK',
                                style: textCustom(
                                  color: isComplete == -1
                                      ? AppTheme.getInstance().disableColor()
                                      : AppTheme.getInstance().fillColor(),
                                  weight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget uploadSuccessWidget() {
    return Row(
      children: [
        sizedSvgImage(
          w: 20,
          h: 20,
          image: ImageAssets.ic_transaction_success_svg,
        ),
        spaceW10,
        Text(
          S.current.uploading_successfully,
          style: textCustom(
            color: AppTheme.getInstance().successTransactionColors(),
            fontSize: 12,
          ),
        )
      ],
    );
  }

  Widget progressBar(AnimationController _animationController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        spaceH10,
        SizedBox(
          height: 6.h,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(3.r),
                  ),
                  color: AppTheme.getInstance().bgProgressingColors(),
                ),
              ),
              AnimatedBuilder(
                animation: _animationController,
                builder: (_, child) {
                  return Container(
                    width: (_animationController.value *
                            MediaQuery.of(context).size.width)
                        .w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(3.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: AppTheme.getInstance().gradientButtonColor(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget uploadFailWidget() {
    return Row(
      children: [
        sizedSvgImage(
          w: 20,
          h: 20,
          image: ImageAssets.ic_transaction_fail_svg,
        ),
        spaceW10,
        Text(
          S.current.uploading_fail,
          style: textCustom(
            color: AppTheme.getInstance().failTransactionColors(),
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
