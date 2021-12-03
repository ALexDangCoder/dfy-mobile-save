// import 'package:Dfy/config/resources/styles.dart';
// import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class FormInput2 extends StatelessWidget {
//   final String urlIcon1;
//   final WalletCubit bloc;
//   final String hint;
//
//   const FormInput2({
//     Key? key,
//     required this.urlIcon1,
//     required this.bloc,
//     required this.hint,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 343.w,
//       height: 64.h,
//       margin: EdgeInsets.symmetric(horizontal: 16.w),
//       padding: EdgeInsets.only(right: 15.w, left: 15.w),
//       decoration: const BoxDecoration(
//         color: Color(0xff32324c),
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//       child: Row(
//         children: [
//           Image.asset(
//             urlIcon1,
//           ),
//           SizedBox(
//             width: 20.5.w,
//           ),
//           StreamBuilder(
//             stream: bloc.tokenSymbol,
//             builder: (context, snapshot) => Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(bottom: 1.h, right: 5.w),
//                 child: TextFormField(
//                   onChanged: (value) {
//                     bloc.tokenSymbolText.sink.add(value);
//                   },
//                   cursorColor: Colors.white,
//                   style: textNormal(
//                     Colors.white54,
//                     16,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: hint,
//                     hintStyle: textNormal(
//                       Colors.white54,
//                       16,
//                     ),
//                     border: InputBorder.none,
//                   ),
//                   // onFieldSubmitted: ,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
