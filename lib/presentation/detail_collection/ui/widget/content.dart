import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'copy.dart';

class ContentDetailCollection extends StatefulWidget {
  const ContentDetailCollection({
    Key? key,
    required this.owner,
    required this.contract,
    required this.nftStandard,
    this.category,
    required this.title,
    required this.bodyText,
    required this.detailCollectionBloc,
  }) : super(key: key);
  final DetailCollectionBloc detailCollectionBloc;
  final String owner;
  final String contract;
  final String nftStandard;
  final String? category;
  final String title;
  final String bodyText;

  @override
  _ContentDetailCollectionState createState() =>
      _ContentDetailCollectionState();
}

class _ContentDetailCollectionState extends State<ContentDetailCollection> {
  late final FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
      ),
      child: StreamBuilder<bool>(
        stream: widget.detailCollectionBloc.isShowMoreStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final bool isShow = snapshot.data ?? false;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH2,
                Text(
                  widget.title,
                  style: textNormalCustom(
                    null,
                    20,
                    FontWeight.w600,
                  ),
                ),
                spaceH6,
                Text(
                  widget.bodyText,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacity(),
                    14,
                    null,
                  ),
                  maxLines: isShow ? null : 2,
                ),
                Visibility(
                  visible: isShow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceH15,
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  S.current.owner,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteWithOpacity(),
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Text(
                                  widget.owner.length < 20
                                      ? widget.contract
                                      : widget.owner
                                          .formatAddressWalletConfirm(),
                                  style: textNormalCustom(
                                    null,
                                    14,
                                    null,
                                  ).copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          spaceH15,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  S.current.contract,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteWithOpacity(),
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                  onTap: () {
                                    FlutterClipboard.copy(widget.contract);
                                    fToast.showToast(
                                      child: Copied(
                                        title: S.current.copy,
                                      ),
                                      gravity: ToastGravity.CENTER,
                                      toastDuration: const Duration(
                                        seconds: 2,
                                      ),
                                    );
                                  },
                                  child: Text(
                                    widget.contract.length < 20
                                        ? widget.contract
                                        : widget.contract
                                            .formatAddressWalletConfirm(),
                                    style: textNormalCustom(
                                      AppTheme.getInstance().blueText(),
                                      14,
                                      null,
                                    ).copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          spaceH15,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  S.current.collection_type,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteWithOpacity(),
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Text(
                                  widget.nftStandard,
                                  style: textNormalCustom(
                                    null,
                                    14,
                                    null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          spaceH15,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: widget.category?.isEmpty ?? true
                                    ? const SizedBox.shrink()
                                    : Text(
                                        S.current.category,
                                        style: textNormalCustom(
                                          AppTheme.getInstance()
                                              .whiteWithOpacity(),
                                          14,
                                          FontWeight.w400,
                                        ),
                                      ),
                              ),
                              Expanded(
                                flex: 7,
                                child: widget.category?.isEmpty ?? true
                                    ? const SizedBox.shrink()
                                    : Text(
                                        widget.category ?? '',
                                        style: textNormalCustom(
                                          null,
                                          14,
                                          null,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      spaceH20,
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.detailCollectionBloc.isShowMoreStream.sink
                        .add(!isShow);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      right: 16.w,
                      left: 16.w,
                    ),
                    height: 40.h,
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
                          isShow ? S.current.view_less : S.current.see_more,
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
    );
  }
}
