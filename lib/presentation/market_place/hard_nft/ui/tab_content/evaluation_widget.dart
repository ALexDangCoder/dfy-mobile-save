import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class EvaluationWidget extends StatefulWidget {
  final HardNFTBloc bloc;

  const EvaluationWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  _EvaluationWidgetState createState() => _EvaluationWidgetState();
}

class _EvaluationWidgetState extends State<EvaluationWidget>
    with AutomaticKeepAliveClientMixin {
  late ItemScrollController scrollController;

  @override
  void initState() {
    // TODO: implement initState
    widget.bloc.changeImage('');
    scrollController = ItemScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceH24,
        textRow(
          name: 'Evaluated by',
          value: 'The London Evaluation',
          clickAble: true,
        ),
        textRow(
            name: 'Evaluated time', value: DateTime.now().stringFromDateTime),
        textRow(
          name: 'Maximum amount',
          value: ' ${1200000.stringIntFormat} USDT',
          token: ImageAssets.ic_token_dfy_svg,
        ),
        textRow(name: 'Depreciation (% annually)', value: '20%'),
        textRow(name: 'Conclusion', value: 'Fast & furious'),
        Text(
          'Images and videos',
          style: tokenDetailAmount(
            color: AppTheme.getInstance().currencyDetailTokenColor(),
            weight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        spaceH16,
        StreamBuilder<String>(
          stream: widget.bloc.imageStream,
          initialData:
              'https://cdn11.bigcommerce.com/s-yrkef1j7/images/stencil/1280x1280/products/294/37821/QQ20190807220008__01299.1565241023.png?c=2',
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              final String img = snapShot.data ?? '';
              return Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 350.w,
                        height: 200.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.r),
                          ),
                          child: Image.network(
                            img,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      StreamBuilder<bool>(
                        stream: widget.bloc.showPreStream,
                        initialData: false,
                        builder: (context, snapPre) {
                          return Visibility(
                            visible: snapPre.data ?? true,
                            child: Positioned(
                              top: (200.h - 32.h) / 2,
                              left: 16.w,
                              child: InkWell(
                                onTap: () {
                                  widget.bloc.preImage();
                                  scrollController.scrollTo(
                                    index: widget.bloc.currentIndexImage > 2
                                        ? widget.bloc.currentIndexImage - 1
                                        : 0,
                                    duration: const Duration(milliseconds: 300),
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
                          stream: widget.bloc.showNextStream,
                          initialData: true,
                          builder: (context, snapNext) {
                            return Visibility(
                              visible: snapNext.data ?? true,
                              child: Positioned(
                                top: (200.h - 32.h) / 2,
                                right: 16.w,
                                child: InkWell(
                                  onTap: () {
                                    widget.bloc.nextImage();
                                    scrollController.scrollTo(
                                      index: widget.bloc.currentIndexImage > 2
                                          ? widget.bloc.currentIndexImage - 1
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
                          }),
                    ],
                  ),
                  spaceH12,
                  SizedBox(
                    height: 64.h,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.bloc.listImg.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            smallImage(
                              img: widget.bloc.listImg[index],
                              isCurrentImg: widget.bloc.listImg[index] == img,
                              index: index,
                            ),
                            spaceW8,
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
    );
  }

  Widget smallImage(
      {required String img, required bool isCurrentImg, required int index}) {
    return InkWell(
      onTap: () {
        widget.bloc.changeImage(img);
        scrollController.scrollTo(
          index: index > 2 ? index - 1 : 0,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Container(
        width: 79.w,
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          border: Border.all(
            color: isCurrentImg ? const Color(0xFFE4AC1A) : Colors.transparent,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          child: Image.network(
            img,
            fit: BoxFit.cover,
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
                weight: FontWeight.w400,
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
                onTap: () {
                  log('Evaluation');
                },
                child: Text(
                  value,
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().whiteColor(),
                    fontSize: 14,
                    weight: FontWeight.w400,
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
                        weight: FontWeight.w400,
                      ),
                    )
                  : Row(
                      children: [
                        sizedSvgImage(w: 20, h: 20, image: token),
                        Text(
                          value,
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
