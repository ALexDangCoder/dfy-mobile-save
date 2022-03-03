import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/bloc/borrow_lend_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorrowItem extends StatefulWidget {
  const BorrowItem({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final BorrowLendBloc bloc;

  @override
  _BorrowItemState createState() => _BorrowItemState();
}

class _BorrowItemState extends State<BorrowItem> {
  TextEditingController textAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = widget.bloc;
    return GestureDetector(
      onTap: () {
        bloc.isChooseToken.add(false);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 40.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.what_you_can_borrow,
                  style: textNormalCustom(
                    null,
                    20,
                    FontWeight.w700,
                  ),
                ),
                spaceH20,
                Text(
                  S.current.how_much,
                  style: textNormalCustom(
                    null,
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,
                Container(
                  width: 343.w,
                  height: 64.h,
                  padding: EdgeInsets.only(right: 15.w, left: 15.w),
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().backgroundBTSColor(),
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textAmountController,
                          maxLength: 50,
                          onChanged: (value) {
                            bloc.textAmount.add(value);
                            bloc.funValidateAmount(value);
                          },
                          cursorColor: AppTheme.getInstance().whiteColor(),
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            16,
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isCollapsed: true,
                            counterText: '',
                            hintText: S.current.enter_amount,
                            hintStyle: textNormal(
                              Colors.white.withOpacity(0.5),
                              16,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: bloc.textAmount,
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          return GestureDetector(
                            onTap: () {
                              bloc.textAmount.add('');
                              textAmountController.text = '';
                            },
                            child: snapshot.data?.isNotEmpty ?? false
                                ? Image.asset(
                                    ImageAssets.ic_close,
                                    width: 20.w,
                                    height: 20.h,
                                  )
                                : SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                spaceH4,
                StreamBuilder<bool>(
                  stream: bloc.isAmount,
                  builder: (context, snapshot) {
                    return snapshot.data ?? false
                        ? SizedBox(
                            width: 343.w,
                            child: Text(
                              S.current.invalid_amount,
                              style: textNormal(
                                Colors.red,
                                14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
                spaceH16,
                Text(
                  S.current.which_token,
                  style: textNormalCustom(
                    null,
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,
                InkWell(
                  onTap: () {
                    bloc.isChooseToken.sink.add(true);
                  },
                  child: StreamBuilder<String>(
                    stream: bloc.tokenSymbol,
                    builder: (context, snapshot) {
                      final String tokenSymbol =
                          (snapshot.data ?? '').toUpperCase();
                      return Container(
                        height: 64.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.5.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().itemBtsColors(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  child: tokenSymbol ==
                                          S.current.all.toUpperCase()
                                      ? const SizedBox.shrink()
                                      : Image.asset(
                                          ImageAssets.getSymbolAsset(
                                            tokenSymbol,
                                          ),
                                          height: 24.w,
                                          width: 24.w,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                            height: 24.w,
                                            width: 24.w,
                                            decoration: BoxDecoration(
                                              color: AppTheme.getInstance()
                                                  .bgBtsColor(),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                tokenSymbol.substring(0, 1),
                                                style: textNormalCustom(
                                                  null,
                                                  16,
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                spaceW4,
                                SizedBox(
                                  child: Text(
                                    tokenSymbol,
                                    style: textNormal(
                                      null,
                                      16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              child: Image.asset(
                                ImageAssets.ic_line_down,
                                height: 20.67.h,
                                width: 20.14.w,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<bool>(
            initialData: false,
            stream: bloc.isChooseToken,
            builder: (ctx, snapshot) {
              return Visibility(
                visible: snapshot.data ?? false,
                child: Positioned(
                  top: 265.h,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppTheme.getInstance().colorTextReset(),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.r),
                      ),
                    ),
                    width: 343.w,
                    height: 123.h,
                    child: ListView.builder(
                      itemCount: bloc.listToken.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            bloc.chooseAddressFilter(
                              bloc.listToken[index],
                            );
                          },
                          child: Container(
                            height: 54.h,
                            padding: EdgeInsets.only(
                              left: 24.w,
                              right: 24.w,
                            ),
                            color:
                                bloc.listToken[index] == bloc.tokenSymbol.value
                                    ? AppTheme.getInstance()
                                        .whiteColor()
                                        .withOpacity(0.3)
                                    : Colors.transparent,
                            child: Row(
                              children: [
                                SizedBox(
                                  child: bloc.listToken[index].toUpperCase() ==
                                          S.current.all.toUpperCase()
                                      ? const SizedBox.shrink()
                                      : Image.asset(
                                          ImageAssets.getSymbolAsset(
                                            bloc.listToken[index].toUpperCase(),
                                          ),
                                          height: 24.w,
                                          width: 24.w,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Container(
                                            height: 24.w,
                                            width: 24.w,
                                            decoration: BoxDecoration(
                                              color: AppTheme.getInstance()
                                                  .bgBtsColor(),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                bloc.listToken[index]
                                                    .toUpperCase()
                                                    .substring(0, 1),
                                                style: textNormalCustom(
                                                  null,
                                                  16,
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                                spaceW4,
                                Text(
                                  bloc.listToken[index] == S.current.all
                                      ? S.current.all
                                      : bloc.listToken[index].toUpperCase(),
                                  style: textNormalCustom(null, 16, null),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
