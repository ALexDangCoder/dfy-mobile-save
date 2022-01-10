import 'dart:developer';
import 'dart:math' hide log;

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/create_collection/bloc/bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadProgress extends StatefulWidget {
  final CreateCollectionBloc bloc;

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
    final int rdA = Random().nextInt(5);
    final int rdC = Random().nextInt(3);
    final int rdF = Random().nextInt(7);
    _avatarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: rdA + 3),
    );
    _coverAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: rdC + 3),
    );
    _featureAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: rdF + 3),
    );
    widget.bloc.cidCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // height: 244.h,
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
                      SizedBox(
                        height: 20.h,
                      ),
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
                      SizedBox(
                        height: 20.h,
                      ),
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
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                line,
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Approve(
                          listDetail: [
                            DetailItemApproveModel(
                              title: S.current.collection_name,
                              value: widget.bloc.collectionName,
                            ),
                            DetailItemApproveModel(
                              title: 'URL',
                              value: widget.bloc.customUrl,
                            ),
                            DetailItemApproveModel(
                              title: S.current.categories,
                              value: widget.bloc.categoryId,
                            ),
                            DetailItemApproveModel(
                              title: S.current.royalties,
                              value: '${widget.bloc.royalties.toString()} %',
                            ),
                          ],
                          title: S.current.create_collection,
                          textActiveButton: S.current.create,
                          approve: () {
                            widget.bloc.createCollection();
                          },
                          action: () {
                            log('ON ACTION');
                            widget.bloc.createCollection();
                          },
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 64.h,
                    child: Center(
                      child: Text(
                        'OK',
                        style: textCustom(
                          color: AppTheme.getInstance().fillColor(),
                          weight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
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
