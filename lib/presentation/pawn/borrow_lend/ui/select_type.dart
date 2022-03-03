import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/bloc/borrow_lend_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeLend { NFT, CRYPTO }

class SelectType extends StatefulWidget {
  const SelectType({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final BorrowLendBloc bloc;

  @override
  _SelectTypeState createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  late TypeLend _type;

  @override
  void initState() {
    super.initState();
    _type = widget.bloc.typeScreen;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _type = TypeLend.CRYPTO;
                  widget.bloc.typeScreen = _type;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().colorTextReset(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20.r,
                    ),
                  ),
                ),
                width: 162.w,
                height: 133.h,
                child: Image.asset(ImageAssets.img_crypto),
              ),
            ),
            spaceH16,
            Row(
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          AppTheme.getInstance().whiteColor(),
                    ),
                    child: Radio<TypeLend>(
                      value: TypeLend.CRYPTO,
                      activeColor: AppTheme.getInstance().fillColor(),
                      groupValue: _type,
                      onChanged: (TypeLend? value) {
                        setState(() {
                          _type = value ?? TypeLend.CRYPTO;
                          widget.bloc.typeScreen = _type;
                        });
                      },
                    ),
                  ),
                ),
                spaceW4,
                Text(
                  S.current.crypto,
                  style: textNormalCustom(
                    null,
                    16,
                    null,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _type = TypeLend.NFT;
                  widget.bloc.typeScreen = _type;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().colorTextReset(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20.r,
                    ),
                  ),
                ),
                width: 162.w,
                height: 133.h,
                child: Image.asset(
                  ImageAssets.img_nft,
                ),
              ),
            ),
            spaceH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          AppTheme.getInstance().whiteColor(),
                    ),
                    child: Radio<TypeLend>(
                      activeColor: AppTheme.getInstance().fillColor(),
                      value: TypeLend.NFT,
                      groupValue: _type,
                      onChanged: (TypeLend? value) {
                        setState(() {
                          _type = value ?? TypeLend.CRYPTO;
                          widget.bloc.typeScreen = _type;
                        });
                      },
                    ),
                  ),
                ),
                spaceW4,
                Text(
                  S.current.nft,
                  style: textNormalCustom(
                    null,
                    16,
                    null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
