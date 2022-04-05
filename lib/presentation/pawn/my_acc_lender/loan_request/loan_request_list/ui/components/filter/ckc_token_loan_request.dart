// import 'package:Dfy/config/resources/styles.dart';
// import 'package:Dfy/config/themes/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// class CheckBoxToken extends StatefulWidget {
//   const CheckBoxToken({Key? key}) : super(key: key);
//
//   @override
//   _CheckBoxTokenState createState() => _CheckBoxTokenState();
// }
//
// class _CheckBoxTokenState extends State<CheckBoxToken> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           width: 24.w,
//           child: Transform.scale(
//             scale: 1.34.sp,
//             child: Checkbox(
//               fillColor: MaterialStateProperty.all(
//                 AppTheme.getInstance().fillColor(),
//               ),
//               checkColor: AppTheme.getInstance().whiteColor(),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(6.r),
//               ),
//               side: BorderSide(
//                 width: 1.w,
//                 color: AppTheme.getInstance().whiteColor(),
//               ),
//               value: isCheck,
//               onChanged: (value) {
//                 check();
//               },
//             ),
//           ),
//         ),
//         spaceW4,
//         GestureDetector(
//           onTap: () {
//             check();
//           },
//           child: Image.network(
//             urlSymbol,
//             width: 20.w,
//             height: 20.w,
//             fit: BoxFit.fill,
//             errorBuilder: (context, error, stackTrace) => Container(
//               color: AppTheme.getInstance().bgBtsColor(),
//               width: 20.w,
//               height: 20.w,
//             ),
//           ),
//         ),
//         spaceW4,
//         Expanded(
//           flex: 8,
//           child: GestureDetector(
//             onTap: () {
//               check();
//             },
//             child: Text(
//               name,
//               maxLines: 1,
//               style: textNormalCustom(
//                 null,
//                 16,
//                 FontWeight.w400,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
//
