import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:Dfy/widgets/common/hero_photo.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/video_player/video_player_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class EvaluationDetail extends StatefulWidget {
  const EvaluationDetail({
    Key? key,
    required this.evaluation,
  }) : super(key: key);

  final Evaluation evaluation;

  @override
  _EvaluationDetailState createState() => _EvaluationDetailState();
}

class _EvaluationDetailState extends State<EvaluationDetail>
    with AutomaticKeepAliveClientMixin {
  late ItemScrollController scrollController;

  late final HardNFTBloc bloc;

  @override
  void initState() {
    // TODO: implement initState
    bloc = HardNFTBloc();
    scrollController = ItemScrollController();
    bloc.getListImage(widget.evaluation);
    bloc.changeImage('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final String time = formatDateTime.format(
      DateTime.fromMillisecondsSinceEpoch(
        widget.evaluation.evaluatedTime ?? 0,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: S.current.hard_nft_evaluation_from,
                style: textNormal(
                  textGray,
                  14,
                ),
              ),
              TextSpan(
                text: widget.evaluation.evaluator?.name ?? '',
                style: textNormal(
                  amountColor,
                  14,
                ),
              ),
              TextSpan(
                text: ' at $time',
                style: textNormal(
                  textGray,
                  14,
                ),
              ),
            ],
          ),
        ),
        spaceH16,
        title(S.current.hard_nft_evaluation_information),
        spaceH20,
        evaluationInfo(),
        spaceH32,
        additionalColumn(widget.evaluation.properties ?? []),
        spaceH32,
        title(S.current.additional_information),
        spaceH20,
        Text(
          widget.evaluation.additionalInformation ?? '',
          style: textNormal(
            textGray,
            16,
          ),
        ),
        spaceH32,
        title(S.current.hard_nft_picture_video),
        spaceH20,
        StreamBuilder<Media>(
          stream: bloc.imageStream,
          initialData: widget.evaluation.media?.first,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              final Media? media = snapShot.data;
              return Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 343.w,
                        height: 290.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.r),
                          ),
                          child: PhotoHero(
                            photo: media?.urlImage ?? '',
                            width: double.infinity,
                            typeImage: media?.type ?? TypeImage.IMAGE,
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) {
                                return Scaffold(
                                  body: SizedBox(
                                    child: media?.type == TypeImage.IMAGE
                                        ? PhotoView(
                                            imageProvider: NetworkImage(
                                                media?.urlImage ?? '',),
                                            minScale: PhotoViewComputedScale
                                                    .contained *
                                                0.8,
                                            maxScale:
                                                PhotoViewComputedScale.covered *
                                                    2,
                                            enableRotation: true,
                                          )
                                        : VideoPlayerView(
                                            urlVideo: media?.urlImage ?? '',
                                          ),
                                  ),
                                );
                              },),);
                            },
                          ),
                        ),
                      ),
                      StreamBuilder<bool>(
                        stream: bloc.showPreStream,
                        initialData: false,
                        builder: (context, snapPre) {
                          return Visibility(
                            visible: snapPre.data ?? true,
                            child: Positioned(
                              top: (290.h - 32.h) / 2,
                              left: 16.w,
                              child: InkWell(
                                onTap: () {
                                  bloc.preImage();
                                  scrollController.scrollTo(
                                    index: bloc.currentIndexImage > 2
                                        ? bloc.currentIndexImage - 1
                                        : 0,
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                  );
                                },
                                child: roundButton(
                                  image: ImageAssets.ic_btn_back_svg,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      StreamBuilder<bool>(
                          stream: bloc.showNextStream,
                          initialData: true,
                          builder: (context, snapNext) {
                            return Visibility(
                              visible: snapNext.data ?? true,
                              child: Positioned(
                                top: (290.h - 32.h) / 2,
                                right: 16.w,
                                child: InkWell(
                                  onTap: () {
                                    bloc.nextImage();
                                    scrollController.scrollTo(
                                      index: bloc.currentIndexImage > 2
                                          ? bloc.currentIndexImage - 1
                                          : 0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                    );
                                  },
                                  child: roundButton(
                                    image: ImageAssets.ic_btn_next_svg,
                                  ),
                                ),
                              ),
                            );
                          },),
                    ],
                  ),
                  spaceH12,
                  SizedBox(
                    height: 83.h,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: bloc.listImg.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            smallImage(
                              img: bloc.listImg[index],
                              isCurrentImg: bloc.listImg[index] == media,
                              index: index,
                            ),
                            spaceW12,
                          ],
                        );
                      },
                    ),
                  ),
                  spaceH12,
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        spaceH32,
        title(S.current.documentE),
        spaceH20,
        if (widget.evaluation.document?.isNotEmpty ?? false)
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.evaluation.document?.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        launch(widget.evaluation.document![index].urlDocument ??
                            '',);
                      },
                      child: Text(
                        widget.evaluation.document![index].name ?? '',
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                      ),
                    ),
                  ),
                  spaceH16,
                ],
              );
            },
          )
        else
          Text(
            'No document result',
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
            ),
          ),
        spaceH46,
      ],
    );
  }

  Widget title(String text) {
    return Text(
      text,
      style: textNormalCustom(purple, 14, FontWeight.w400),
    );
  }

  Widget additionalColumn(List<AdditionalInfo> properties) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title(
          S.current.hard_nft_properties,
        ),
        SizedBox(
          height: 23.h,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: properties.isEmpty
              ? Text(
                  S.current.no_more_info,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    14,
                    FontWeight.w400,
                  ),
                )
              : Wrap(
                  spacing: 12.w,
                  runSpacing: 8.h,
                  children: properties
                      .map(
                        (e) => SizedBox(
                          height: 50.h,
                          child: Chip(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppTheme.getInstance()
                                    .divideColor()
                                    .withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            backgroundColor:
                                AppTheme.getInstance().bgBtsColor(),
                            label: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.traitType ?? '',
                                  textAlign: TextAlign.left,
                                  style: textNormalCustom(
                                    AppTheme.getInstance()
                                        .textThemeColor()
                                        .withOpacity(0.7),
                                    12,
                                    FontWeight.w400,
                                  ),
                                ),
                                spaceH4,
                                Text(
                                  e.value ?? '',
                                  textAlign: TextAlign.left,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().textThemeColor(),
                                    14,
                                    FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
        )
      ],
    );
  }

  Widget evaluationInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 32.h,
                width: 32.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(getImage()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            spaceW6,
            Text(
              widget.evaluation.nameNft?.name ?? '',
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                28,
                FontWeight.w400,
              ),
            ),
          ],
        ),
        Row(
          children: [
            if (widget.evaluation.authenticityType == 1) ...[
              sizedSvgImage(w: 16.w, h: 16.h, image: ImageAssets.ic_verify_svg)
            ] else ...[
              sizedSvgImage(
                  w: 16.w, h: 16.h, image: ImageAssets.ic_transaction_fail_svg,)
            ],
            spaceW5,
            if (widget.evaluation.authenticityType == 1)
              Text(
                S.current.authentic_product,
                style: textNormalCustom(
                  blueMarketColor,
                  16,
                  FontWeight.w400,
                ),
              )
            else
              Text(
                S.current.fake_product,
                style: textNormalCustom(
                  redMarketColor,
                  16,
                  FontWeight.w400,
                ),
              ),
            spaceW8,
            Container(
              width: 1.w,
              height: 12.h,
              color: AppTheme.getInstance().whiteColor(),
            ),
            spaceW8,
            Text(
              '${widget.evaluation.depreciationPercent ?? ''}% '
              '${S.current.depreciationD}',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
          ],
        ),
        spaceH16,
        Text(
          S.current.evaluated_price,
          style: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w400,
          ),
        ),
        spaceH8,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: Container(
                height: 32.h,
                width: 32.h,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.evaluation.urlToken ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            spaceW8,
            Text(
              '${widget.evaluation.evaluatedPrice} '
              '${widget.evaluation.evaluatedSymbol ?? ''}',
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                28,
                FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getImage() {
    switch (widget.evaluation.assetType?.id ?? 0) {
      case 1:
        return ImageAssets.diamond;
      case 2:
        return ImageAssets.artWork;
      case 3:
        return ImageAssets.car;
      case 4:
        return ImageAssets.watch;
      case 5:
        return ImageAssets.house;
      default:
        return ImageAssets.others;
    }
  }

  Widget smallImage(
      {required Media img, required bool isCurrentImg, required int index,}) {
    return InkWell(
      onTap: () {
        bloc.changeImage(img.urlImage!);
        scrollController.scrollTo(
          index: index > 2 ? index - 1 : 0,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        width: 105.w,
        height: 83.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: img.type == TypeImage.IMAGE
            ? ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                child: Image.network(
                  img.urlImage!,
                  fit: BoxFit.cover,
                ),
              )
            : Container(
                color: Colors.black,
                child: Stack(
                  children: [
                    VideoPlayer(
                      VideoPlayerController.network(img.urlImage!)
                        ..initialize().then((_) {
                          setState(() {
                          });
                        }),
                    ),
                    Center(
                      child: Icon(
                        Icons.play_circle_outline_sharp,
                        size: 34.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
