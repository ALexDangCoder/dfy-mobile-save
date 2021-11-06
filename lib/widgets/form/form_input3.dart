import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/widgets/scan_qr/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormInput3 extends StatelessWidget {
  final String urlIcon1;
  final String urlIcon2;
  final ImportTokenNftBloc bloc;
  final String hint;

  FormInput3({
    Key? key,
    required this.urlIcon1,
    required this.urlIcon2,
    required this.bloc,
    required this.hint,
  }) : super(key: key);
  final textAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 26.w),
      padding: EdgeInsets.only(right: 15.w, left: 15.w),
      decoration: const BoxDecoration(
        color: Color(0xff32324c),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Image.asset(
            urlIcon1,
          ),
          SizedBox(
            width: 20.5.w,
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc.tokenAddressTextNft,
              builder: (context, AsyncSnapshot<String> snapshot) {
                textAddress.text = snapshot.data ?? '';
                return Container(
                  margin: EdgeInsets.only(bottom: 1.h, right: 5.w),
                  child: Expanded(
                    child: TextFormField(
                      // maxLines: 5,
                      controller: textAddress,
                      onChanged: (value) {
                        bloc.tokenAddressTextNft.sink.add(value);
                      },
                      cursorColor: Colors.white,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: textNormal(
                          Colors.white54,
                          16.sp,
                        ),
                        border: InputBorder.none,
                      ),
                      // onFieldSubmitted: ,
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return QRViewExample(
                      bloc: bloc,
                    );
                  },
                ),
              );
            },
            child: Image.asset(
              urlIcon2,
            ),
          ),
        ],
      ),
    );
  }
}
