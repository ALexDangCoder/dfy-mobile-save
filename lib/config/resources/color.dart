import 'package:flutter/material.dart';

///=========== Colors for default when didn't setup app theme ===============
///https://stackoverflow.com/a/17239853
const colorPrimary = Color(0xff0ABAB5);
const colorPrimaryTransparent = Color(0x720ABAB5);
const colorAccent = Color(0xffDCFFFE);
const colorSelected = Color(0xFFE0F2F1);
const mainTxtColor = Color(0xFF30536F);
const dfTxtColor = Color(0xFF303742);
const secondTxtColor = Color(0xFF808FA8);
const highlightTxtColor = Color(0xff303742);
const backgroundBottomSheetColor = Color(0xff32324c);
const textErrorLoad = Color(0xffE6E6E6);
const formColor = Color(0xff6F6FC5);
const subTitleTxtColor = Color(0xff9097A3);
const listBackgroundColor = [Color(0xFF3C3B54), Color(0xFF171527)];
const backgroundMarketColor = [Color(0xFF3C3B54), Color(0xFF24203A)];
const dateColor = Color(0xffD4D5D7);
const amountColor = Color(0xffDBA83D);
const listAddWalletColor = [
  Color.fromRGBO(60, 59, 84, 1),
  Color.fromRGBO(23, 21, 39, 1)
];
const purple = Color(0xff9997FF);
const successTransactionColor = Color(0xFF61C777);
const failTransactionColor = Color(0xFFFF6C6C);
const listButtonColor = [Color(0xFFFFE284), Color(0xFFE4AC1A)];
const textHistory = Color(0xFFE4E4E4);

//skeleton
const colorSkeletonLight = Color(0xFF605F83);
const colorSkeleton = Color(0xFF585782);
//bottom navigation color
const bgBottomTab = Color(0xFF3A3956);
const tabSelected = Color(0xff0ABAB5);
const tabUnselected = Color(0xFFA9B8BD);
const backSearch = Color(0xFF31334C);

//custom color
Color whiteOpacityZeroFire = Colors.white.withOpacity(0.5);
const borderItemColors = Color(0xff474666);
const borderColor = Color(0xff7E7EAA);
const fillYellowColor = Color(0xffE4AC1A);
const borderApprovedButton  = Color(0xff39984E);
const disableText = Color(0xff979797);
const fillApprovedButton = Color(0xffD4ECD9);
const buttonGrey = Color.fromRGBO(255, 255, 255, 0.2);
const errorColor = Color(0xFFCDCDCD);
const dialogColor = Color(0xff585782);
const suffixFieldColor = Colors.white30;
const whiteRGBO = Color.fromRGBO(255, 255, 255, 1);
const activeYellowColor = Color.fromRGBO(228, 172, 26, 1);
const wrongRedColor = Color.fromRGBO(255, 108, 108, 1);
const backgroundBottomSheet = Color(0xff3E3D5C);
const colorTextField = Color(0xff32324c);
const signInRowColor = Color(0xFFA9B8BD);
const signInTextColor = Color(0xff0ABAB5);
const sideTextInactiveColor = Color(0xFFB9C4D0);
const signInTextSecondaryColor = Color(0xFF8F8F8F);
const dotActiveColor = Color(0xff0ABAB5);
const dividerColor = Color(0xffcacfd7);
const sideBtnSelected = Color(0xff0ABAB5);
const sideBtnUnselected = Color(0xff9097A3);
const underLine = Color(0xffDBDBDB);
const specialPriceColor = Color(0xffEB5757);
const otherColor = Color(0xff303742);
const pendingColor = Color(0xff303742);
const processingColor = Color(0xffFE8922);
const deliveredColor = Color(0xff19A865);
const canceledColor = Color(0xffF94444);
const subMenuColor = Color(0xff303742);
const colorLineSearch = Color(0x80CACFD7);
const colorPressedItemMenu = Color(0xffE7F8F8);
const fittingBg = Color(0xFFF2F2F2);
const shadowTabIcon = Color(0xFF6C6CF4);
const divideColor = Color(0xFF8f8fad);
const unselectedTabLabel = Color(0xFF9997FF);
const bgErrorLoadData = Color(0xFF474666);

///=========== Using to make change app theme ================================
const bgTranSubmitColor = Color(0xff585782);

///=========== Using to make change app theme ================================
abstract class AppColor {
  Color bgTranSubmit();

  Color bgErrorLoad();

  Color skeletonLight();

  Color skeleton();

  Color amountTextColor();

  Color activityDateColor();

  Color backgroundBTSColor();

  Color redColor();

  Color colorTextFieldZeroFire();

  Color colorTextReset();

  Color borderItemColor();

  Color primaryColor();

  Color accentColor();

  Color statusColor();

  Color mainColor();

  Color bgColor();

  Color dfTxtColor();

  Color secondTxtColor();

  Color dfBtnColor();

  Color dfBtnTxtColor();

  Color txtLightColor();

  Color sideBtnColor();

  Color disableColor();

  Color bgBtsColor();

  Color itemBtsColors();

  Color divideColor();

  Color wrongColor();

  Color fillColor();

  Color activeColor();

  Color whiteWithOpacity();

  Color blueText();

  Color whiteWithOpacityFireZero();

  Color whiteWithOpacitySevenZero();

  Color textThemeColor();

  Color suffixColor();

  Color errorColorButton();

  Color selectDialogColor();

  Color columnButtonColor();

  List<Color> listColorAddWalletSeedPhrase();

  List<Color> gradientButtonColor();

  Color whiteColor();

  Color backgroundLoginTextField();

  Color currencyDetailTokenColor();

  Color successTransactionColors();

  Color failTransactionColors();

  Color pendingTransactionColors();

  Color blueColor();

  Color backgroundButtonColor();

  Color whiteBackgroundButtonColor();

  Color timeBorderColor();

  Color unselectedTabLabelColor();

  Color titleTabColor();

  Color disableRadioColor();

  List<Color> listBackgroundMarketColor();

  Color bgProgressingColors();
}

class LightApp extends AppColor {
  @override
  Color primaryColor() {
    return colorPrimary;
  }

  @override
  Color accentColor() {
    return colorAccent;
  }

  @override
  Color statusColor() {
    return const Color(0xFFFCFCFC);
  }

  @override
  Color mainColor() {
    return const Color(0xFF30536F);
  }

  @override
  Color bgColor() {
    return const Color(0xFFFCFCFC);
  }

  @override
  Color dfBtnColor() {
    return const Color(0xFF324452);
  }

  @override
  Color dfBtnTxtColor() {
    return const Color(0xFFFFFFFF);
  }

  @override
  Color dfTxtColor() {
    return const Color(0xFF303742);
  }

  @override
  Color secondTxtColor() {
    return const Color(0xFF9097A3);
  }

  @override
  Color txtLightColor() {
    return Colors.white.withOpacity(0.85);
  }

  @override
  Color sideBtnColor() {
    return const Color(0xFFDCFFFE);
  }

  @override
  Color disableColor() {
    return const Color(0xFFA9B8BD);
  }

  @override
  Color bgBtsColor() {
    return backgroundBottomSheet;
  }

  @override
  Color itemBtsColors() {
    return colorTextField;
  }

  @override
  Color divideColor() {
    return const Color.fromRGBO(255, 255, 255, 0.1);
  }

  @override
  Color wrongColor() {
    return wrongRedColor;
  }

  @override
  Color activeColor() {
    return activeYellowColor;
  }

  @override
  Color fillColor() {
    return fillYellowColor;
  }

  @override
  Color whiteWithOpacity() {
    return whiteRGBO;
  }

  @override
  List<Color> listColorAddWalletSeedPhrase() {
    return listAddWalletColor;
  }

  @override
  Color suffixColor() {
    return suffixFieldColor;
  }

  @override
  List<Color> gradientButtonColor() {
    return listButtonColor;
  }

  @override
  Color textThemeColor() {
    return Colors.white;
  }

  @override
  Color selectDialogColor() {
    return dialogColor;
  }

  @override
  Color errorColorButton() {
    return errorColor;
  }

  @override
  Color columnButtonColor() {
    return buttonGrey;
  }

  @override
  Color backgroundLoginTextField() {
    return Colors.white;
  }

  @override
  Color whiteColor() {
    return Colors.white;
  }

  @override
  Color currencyDetailTokenColor() {
    return Colors.white.withOpacity(0.7);
  }

  @override
  Color successTransactionColors() {
    return successTransactionColor;
  }

  @override
  Color failTransactionColors() {
    return failTransactionColor;
  }

  @override
  Color blueColor() {
    return const Color(0xFF46BCFF);
  }

  @override
  Color pendingTransactionColors() {
    return const Color(0XFFFFBD48);
  }

  @override
  Color backgroundButtonColor() {
    return backgroundBottomSheet.withOpacity(0.6);
  }

  @override
  Color whiteBackgroundButtonColor() {
    // TODO: implement whiteBackgroundButtonColor
    return Colors.white.withOpacity(0.1);
  }

  @override
  List<Color> listBackgroundMarketColor() {
    return backgroundMarketColor;
  }

  @override
  Color borderItemColor() {
    return borderItemColors;
  }

  @override
  Color timeBorderColor() {
    return borderColor;
  }

  @override
  Color unselectedTabLabelColor() {
    return unselectedTabLabel;
  }

  @override
  Color titleTabColor() {
    return purple;
  }

  @override
  Color whiteWithOpacityFireZero() {
    // TODO: implement whiteWithOpacityFireZero
    return whiteOpacityZeroFire;
  }

  @override
  Color backgroundBTSColor() {
    // TODO: implement backgroundBTSColor
    return backgroundBottomSheetColor;
  }

  @override
  Color colorTextFieldZeroFire() {
    // TODO: implement colorTextFieldZeroFire
    return colorTextField.withOpacity(0.5);
  }

  @override
  Color redColor() {
    return Colors.red;
  }

  @override
  Color bgTranSubmit() {
    // TODO: implement bgTranSubmit
    return bgTranSubmitColor;
  }

  @override
  Color disableRadioColor() {
    // TODO: implement disableRadioColor
    return const Color(0xFFE0E0E0);
  }

  @override
  Color skeleton() {
    // TODO: implement skeleton
    return colorSkeleton;
  }

  @override
  Color skeletonLight() {
    // TODO: implement skeletonLight
    return colorSkeletonLight;
  }

  @override
  Color bgErrorLoad() {
    // TODO: implement bgErrorLoad
    return bgErrorLoadData;
  }

  @override
  Color activityDateColor() {
    // TODO: implement activityDateColor
    return dateColor;
  }

  @override
  Color whiteWithOpacitySevenZero() {
    // TODO: implement whiteWithOpacitySevenZero
   return Colors.white.withOpacity(0.7);
  }

  @override
  Color amountTextColor() {
    // TODO: implement amountTextColor
  return amountColor;
  }

  @override
  Color blueText() {
    // TODO: implement blueText
    return const Color(0xff46BCFF);
  }

  @override
  Color colorTextReset() {
    // TODO: implement colorTextReset
    return const Color(0xff585782);
  }

  @override
  Color bgProgressingColors() {
    // TODO: implement bgProgressingColors
    return const Color(0xFF3E3D5C);
  }
}

class DarkApp extends AppColor {
  @override
  Color primaryColor() {
    return Colors.black;
  }

  @override
  Color accentColor() {
    return Colors.black;
  }

  @override
  Color statusColor() {
    return Colors.black;
  }

  @override
  Color mainColor() {
    return Colors.black.withOpacity(0.8);
  }

  @override
  Color bgColor() {
    return Colors.black.withOpacity(0.8);
  }

  @override
  Color dfBtnColor() {
    return Colors.white.withOpacity(0.8);
  }

  @override
  Color dfBtnTxtColor() {
    return Colors.black.withOpacity(0.6);
  }

  @override
  Color dfTxtColor() {
    return Colors.white.withOpacity(0.6);
  }

  @override
  Color secondTxtColor() {
    return Colors.black.withOpacity(0.4);
  }

  @override
  Color txtLightColor() {
    return Colors.white.withOpacity(0.85);
  }

  @override
  Color sideBtnColor() {
    return const Color(0xFFA9B8BD);
  }

  @override
  Color disableColor() {
    return Colors.grey;
  }

  @override
  Color currencyDetailTokenColor() {
    // TODO: implement currencyDetailTokenColor
    return Colors.white.withOpacity(0.7);
  }

  @override
  Color bgBtsColor() {
    // TODO: implement backgroundBtsColor
    throw UnimplementedError();
  }

  @override
  Color itemBtsColors() {
    // TODO: implement itemBtsColor
    throw UnimplementedError();
  }

  @override
  Color divideColor() {
    // TODO: implement divideColor
    throw UnimplementedError();
  }

  @override
  Color wrongColor() {
    // TODO: implement wrongColor
    throw UnimplementedError();
  }

  @override
  Color activeColor() {
    // TODO: implement activeColor
    throw UnimplementedError();
  }

  @override
  Color fillColor() {
    // TODO: implement fillColor
    throw UnimplementedError();
  }

  @override
  Color whiteWithOpacity() {
    // TODO: implement listColorAddWalletSeedPhrase
    throw UnimplementedError();
  }

  @override
  List<Color> listColorAddWalletSeedPhrase() {
    // TODO: implement listColorAddWalletSeedPhrase
    throw UnimplementedError();
  }

  @override
  Color suffixColor() {
    // TODO: implement suffixColor
    throw UnimplementedError();
  }

  @override
  List<Color> gradientButtonColor() {
    // TODO: implement listButtonColor
    throw UnimplementedError();
  }

  @override
  Color textThemeColor() {
    // TODO: implement textThemeColor
    throw UnimplementedError();
  }

  @override
  Color selectDialogColor() {
    // TODO: implement selectDialogColor
    throw UnimplementedError();
  }

  @override
  Color errorColorButton() {
    // TODO: implement errorColorButton
    throw UnimplementedError();
  }

  @override
  Color columnButtonColor() {
    // TODO: implement columnButtonColor
    throw UnimplementedError();
  }

  @override
  Color whiteColor() {
    // TODO: implement whiteColor
    throw UnimplementedError();
  }

  @override
  Color backgroundLoginTextField() {
    // TODO: implement backgroundLoginTextField
    throw UnimplementedError();
  }

  @override
  Color pendingTransactionColors() {
    // TODO: implement pendingTransactionColors
    throw UnimplementedError();
  }

  @override
  Color successTransactionColors() {
    // TODO: implement successTransactionColors
    throw UnimplementedError();
  }

  @override
  Color blueColor() {
    // TODO: implement blueColor
    throw UnimplementedError();
  }

  @override
  Color failTransactionColors() {
    // TODO: implement failTransactionColors
    throw UnimplementedError();
  }

  @override
  Color backgroundButtonColor() {
    // TODO: implement backgroundButtonColor
    throw UnimplementedError();
  }

  @override
  List<Color> listBackgroundMarketColor() {
    // TODO: implement listBackgroundMarketColor
    throw UnimplementedError();
  }

  @override
  Color whiteBackgroundButtonColor() {
    // TODO: implement whiteBackgroundButtonColor
    throw UnimplementedError();
  }

  @override
  Color borderItemColor() {
    // TODO: implement borderItemColor
    throw UnimplementedError();
  }

  @override
  Color timeBorderColor() {
    // TODO: implement timeBorderColor
    throw UnimplementedError();
  }

  @override
  Color unselectedTabLabelColor() {
    // TODO: implement unselectedTabLabelColor
    return unselectedTabLabel;
  }

  @override
  Color titleTabColor() {
    // TODO: implement titleTabColor
    throw UnimplementedError();
  }

  @override
  Color whiteWithOpacityFireZero() {
    return whiteOpacityZeroFire;
  }

  @override
  Color backgroundBTSColor() {
    // TODO: implement backgroundBTSColor
    return colorTextField.withOpacity(0.5);
  }

  @override
  Color colorTextFieldZeroFire() {
    // TODO: implement colorTextFieldZeroFire
    throw UnimplementedError();
  }

  @override
  Color redColor() {
    // TODO: implement redColor
    throw UnimplementedError();
  }

  @override
  Color bgTranSubmit() {
    // TODO: implement bgTranSubmit
    throw UnimplementedError();
  }

  @override
  Color disableRadioColor() {
    // TODO: implement disableRadioColor
    throw UnimplementedError();
  }

  @override
  Color skeleton() {
    return colorSkeleton;
  }

  @override
  Color skeletonLight() {
    return colorSkeletonLight;
  }

  @override
  Color bgErrorLoad() {
    return bgErrorLoadData;
  }

  @override
  Color activityDateColor() {
    // TODO: implement activityDateColor
    throw UnimplementedError();
  }

  @override
  Color whiteWithOpacitySevenZero() {
    // TODO: implement whiteWithOpacitySevenZero
    throw UnimplementedError();
  }

  @override
  Color amountTextColor() {
    // TODO: implement amountTextColor
    throw UnimplementedError();
  }

  @override
  Color blueText() {
    // TODO: implement blueText
    throw UnimplementedError();
  }

  @override
  Color colorTextReset() {
    // TODO: implement colorTextReset
    throw UnimplementedError();
  }

  @override
  Color bgProgressingColors() {
    // TODO: implement bgProgressingColors
    throw UnimplementedError();
  }
}

///============ End setup app theme ======================================
