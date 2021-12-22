// import 'package:Dfy/config/resources/styles.dart';
// import 'package:Dfy/config/themes/app_theme.dart';
// import 'package:Dfy/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class ShowLoadingTransaction extends StatelessWidget {
//   const ShowLoadingTransaction({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 20.0.r,
//               ),
//             ),
//           ),
//           backgroundColor: AppTheme.getInstance().selectDialogColor(),
//           title: Column(
//             children: [
//               Expanded(
//                 child: SizedBox(
//                   width: 24.w,
//                   height: 24.h,
//                   child: CircularProgressIndicator(
//                     backgroundColor: AppTheme.getInstance().disableColor(),
//                     strokeWidth: 3.w,
//                     color: AppTheme.getInstance().fillColor(),
//                   ),
//                 ),
//               ),
//               spaceH5,
//               Expanded(
//                 child: Text(
//                   S.current.tran_submit,
//                   style: textNormalCustom(
//                     AppTheme.getInstance().textThemeColor(),
//                     16,
//                     FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Text(
//                   S.current.waiting_for_cf,
//                   style: textNormalCustom(
//                     AppTheme.getInstance().textThemeColor(),
//                     14,
//                     FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           // const <Widget>[
//           //   Center(
//           //     child: CircularProgressIndicator(),
//           //   ),
//           // ],
//         );
//       },
//     );
//   }
// }
