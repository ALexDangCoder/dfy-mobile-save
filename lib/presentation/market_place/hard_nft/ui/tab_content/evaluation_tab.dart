import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/information_widget.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/related_document_widget.dart';
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
import 'package:video_player/video_player.dart';

class EvaluationTab extends StatefulWidget {
  final Evaluation evaluation;

  const EvaluationTab({Key? key, required this.evaluation}) : super(key: key);

  @override
  _EvaluationTabState createState() => _EvaluationTabState();
}

class _EvaluationTabState extends State<EvaluationTab>
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH24,
                textRow(
                  name: S.current.evaluated_by,
                  value: widget.evaluation.evaluator?.name ?? '',
                  clickAble: true,
                ),
                textRow(
                  name: S.current.evaluated_time,
                  value: formatDateTime.format(
                    DateTime.fromMillisecondsSinceEpoch(
                      widget.evaluation.evaluatedTime ?? 0,
                    ),
                  ),
                ),
                textRow(
                  name: S.current.maximum_amount,
                  value: '${widget.evaluation.evaluatedPrice ?? 0} '
                      '${widget.evaluation.evaluatedSymbol}',
                  token: widget.evaluation.urlToken,
                ),
                textRow(
                    name: S.current.depreciation,
                    value: '${widget.evaluation.depreciationPercent}%'),
                textRow(
                    name: S.current.addition_info,
                    value: widget.evaluation.additionalInformation ?? ''),
                Text(
                  S.current.images_videos,
                  style: textNormalCustom(
                    AppTheme.getInstance().currencyDetailTokenColor(),
                    14,
                    FontWeight.w600,
                  ),
                ),
                spaceH16,
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
                                                child: media?.type ==
                                                        TypeImage.IMAGE
                                                    ? PhotoView(
                                                        imageProvider:
                                                            NetworkImage(media
                                                                    ?.urlImage ??
                                                                ''),
                                                        minScale:
                                                            PhotoViewComputedScale
                                                                    .contained *
                                                                0.8,
                                                        maxScale:
                                                            PhotoViewComputedScale
                                                                    .covered *
                                                                2,
                                                        enableRotation: true,
                                                      )
                                                    : VideoPlayerView(
                                                        urlVideo:
                                                            media?.urlImage ??
                                                                '',
                                                      ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
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
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            );
                                          },
                                          child: roundButton(
                                            image: ImageAssets.ic_btn_next_svg,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
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
                                      isCurrentImg:
                                          bloc.listImg[index] == media,
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
              ],
            ),
          ),
          StreamBuilder<bool>(
            stream: bloc.showMoreStream,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final bool isShow = snapshot.data ?? false;
                return Column(
                  children: [
                    Visibility(
                      visible: isShow,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                            ),
                            child: InformationWidget(
                              object: widget.evaluation,
                            ),
                          ),
                          spaceH20,
                          Container(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                            ),
                            child: RelatedDocument(
                              evaluation: widget.evaluation,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        bloc.showInformation();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          right: 16.w,
                          left: 16.w,
                        ),
                        height: 69.h,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppTheme.getInstance().divideColor(),
                            ),
                            top: BorderSide(
                              color: AppTheme.getInstance().divideColor(),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            sizedSvgImage(
                              w: 14,
                              h: 14,
                              image: isShow
                                  ? ImageAssets.ic_collapse_svg
                                  : ImageAssets.ic_expand_svg,
                            ),
                            SizedBox(
                              width: 13.15.w,
                            ),
                            Text(
                              isShow
                                  ? S.current.see_less
                                  : S.current.see_more,
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget smallImage(
      {required Media img, required bool isCurrentImg, required int index}) {
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
            : Center(
          child: Icon(
            Icons.play_circle_outline_sharp,
            size: 24.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget textRow({
    required String name,
    required String value,
    Color? valueColor,
    bool clickAble = false,
    String? token,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: tokenDetailAmount(
                color: AppTheme.getInstance().currencyDetailTokenColor(),
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          if (clickAble)
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {},
                child: Text(
                  value,
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().whiteColor(),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          else
            Expanded(
              flex: 3,
              child: token == null
                  ? Text(
                      value,
                      style: tokenDetailAmount(
                        color: AppTheme.getInstance().whiteColor(),
                        fontSize: 14,
                      ),
                    )
                  : Row(
                      children: [
                        Image(
                          image: NetworkImage(token),
                          height: 20.h,
                          width: 20.w,
                        ),
                        Text(
                          ' $value',
                          style: tokenDetailAmount(
                            color: AppTheme.getInstance().whiteColor(),
                            fontSize: 16,
                          ),
                        ),
                      ],
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
