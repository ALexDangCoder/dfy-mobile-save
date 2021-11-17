// import 'package:flutter/material.dart';
//
// class HeaderWallet extends StatelessWidget {
//   const HeaderWallet({
//     this.leftImgAssets,
//     this.rightImgAssets,
//     required this.title,
//     this.leftBtnCallback,
//     this.rightBtnCallback,
//     Key? key,
//   }) : super(key: key);
//
//   final String? leftImgAssets;
//   final String? rightImgAssets;
//   final String title;
//   final Function()? leftBtnCallback;
//   final Function()? rightBtnCallback;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//       EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h, bottom: 20.h),
//       child: Row(
//         children: [
//           Expanded(
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Image.asset('assets/images/back_arrow.png'),
//             ),
//           ),
//           SizedBox(
//             width: 66.w,
//           ),
//           Text(
//             'Create new wallet',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(
//             width: 64.48.w,
//           ),
//           Expanded(
//             child: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Image.asset('assets/images/ic_group.png'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
