import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/extension_create_nft/core_bc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/upload_ipfs/pin_to_ipfs.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNftUploadProgress extends StatefulWidget {
  final CreateNftCubit cubit;

  const CreateNftUploadProgress({Key? key, required this.cubit})
      : super(key: key);

  @override
  State<CreateNftUploadProgress> createState() =>
      _CreateNftUploadProgressState();
}

class _CreateNftUploadProgressState extends State<CreateNftUploadProgress>
    with TickerProviderStateMixin {
  late AnimationController _mediaFileAnimationController;
  late AnimationController _coverAnimationController;

  @override
  void initState() {
    if (widget.cubit.coverFileSize != 0) {
      final int coverFileUploadTime =
          PinToIPFS().uploadTimeCalculate(widget.cubit.coverFileSize) + 3;
      _coverAnimationController = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: coverFileUploadTime,
        ),
      );
      widget.cubit.mediaFileUploadTime =
          widget.cubit.mediaFileUploadTime + coverFileUploadTime;
    } else {
      _coverAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 1,
        ),
      );
      widget.cubit.mediaFileUploadTime = widget.cubit.mediaFileUploadTime + 3;
    }
    _mediaFileAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.cubit.mediaFileUploadTime),
    );
    widget.cubit.upLoadStatusSubject.listen((value) {
      if (value == 1) {
        widget.cubit.getTransactionData();
        if (_mediaFileAnimationController.isAnimating) {
          _mediaFileAnimationController.stop();
        }
        if (_coverAnimationController.isAnimating) {
          _coverAnimationController.stop();
        }
        widget.cubit.getDfyTokenInf();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Approve(
              hexString: widget.cubit.transactionData,
              listDetail: [
                DetailItemApproveModel(
                  title: '${S.current.name}:',
                  value: widget.cubit.nftName,
                ),
                DetailItemApproveModel(
                  title: '${S.current.number_of_copies}:',
                  value: '01',
                ),
                DetailItemApproveModel(
                  title: '${S.current.collection_name}:',
                  value: widget.cubit.collectionAddress,
                ),
                DetailItemApproveModel(
                  title: '${S.current.minting_fee}:',
                  value:
                      '${widget.cubit.mintingFeeNumber.toString()} ${widget.cubit.mintingFeeToken}',
                ),
              ],
              title: S.current.create_collection,
              textActiveButton: S.current.create,
              typeApprove: TYPE_CONFIRM_BASE.CREATE_SOFT_NFT,
              payValue: 10.toString(),
              tokenAddress: widget.cubit.tokenAddress,
              spender: widget.cubit.collectionAddress,
            ),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StateStreamLayout(
      stream: widget.cubit.stateStream,
      textEmpty: '',
      retry: () {},
      error: AppException('', S.current.something_went_wrong),
      child: Scaffold(
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
                          S.current.upload_file,
                          style: textCustom(
                            fontSize: 12,
                          ),
                        ),
                        StreamBuilder<int>(
                          stream: widget.cubit.mediaFileUploadStatusSubject,
                          initialData: -1,
                          builder: (context, snapshot) {
                            final status = snapshot.data ?? -1;
                            if (status == -1) {
                              _mediaFileAnimationController.forward();
                              return progressBar(_mediaFileAnimationController);
                            } else if (status == 0) {
                              return uploadFailWidget();
                            } else {
                              return uploadSuccessWidget();
                            }
                          },
                        ),
                        if (widget.cubit.mediaType != MEDIA_IMAGE_FILE)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceH20,
                              Text(
                                S.current.cover_photo,
                                style: textCustom(
                                  fontSize: 12,
                                ),
                              ),
                              StreamBuilder<int>(
                                stream:
                                    widget.cubit.coverPhotoUploadStatusSubject,
                                initialData: -1,
                                builder: (context, snapshot) {
                                  final status = snapshot.data ?? -1;
                                  if (status == -1) {
                                    _coverAnimationController.forward();
                                    return progressBar(
                                        _coverAnimationController);
                                  } else if (status == 0) {
                                    return uploadFailWidget();
                                  } else {
                                    return uploadSuccessWidget();
                                  }
                                },
                              ),
                            ],
                          )
                        else
                          const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  line,
                  StreamBuilder<int>(
                    stream: widget.cubit.upLoadStatusSubject,
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
                  ),
                ],
              ),
            ),
          ],
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
