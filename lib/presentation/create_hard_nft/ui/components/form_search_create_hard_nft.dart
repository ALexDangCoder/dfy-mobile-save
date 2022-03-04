import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSearchCreateHardNft extends StatelessWidget {
  const FormSearchCreateHardNft({
    Key? key,
    required this.cubit,
    required this.hintSearch,
  }) : super(key: key);
  final String hintSearch;

  final ProvideHardNftCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312.w,
      height: 320.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(36.r),
        ),
        color: AppTheme.getInstance().bgTranSubmit(),
      ),
      child: Column(
        children: [
          TextFormField(
            style: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
            ),
            onChanged: (value) {
              cubit.searchPhones(value);
            },
            decoration: InputDecoration(
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(36.r),
                  topLeft: Radius.circular(36.r),
                ),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(36.r),
                  topLeft: Radius.circular(36.r),
                ),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(36.r),
                  topLeft: Radius.circular(36.r),
                ),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(36.r),
                  topLeft: Radius.circular(36.r),
                ),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              fillColor: AppTheme.getInstance().backgroundBTSColor(),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18.w, vertical: 21.h),
              counterText: '',
              hintText: hintSearch,
              hintStyle: textNormal(
                Colors.white.withOpacity(0.5),
                16,
              ),
            ),
          ),
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: cubit.phonesCodeBHVSJ.stream,
            initialData: cubit.phonesCode,
            builder: (context, snapshot) {
              if ((snapshot.data ?? []).isEmpty) {
                return Container(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Text(
                    S.current.empty_data,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                );
              } else {
                return SizedBox(
                  height: 248.h,
                  child: ListView.builder(
                    itemCount: (snapshot.data ?? []).length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.dataStep1.phoneCodeModel.id =
                                  snapshot.data?.elementAt(index)['id'] as int;
                              cubit.dataStep1.phoneCodeModel.code =
                                  snapshot.data?.elementAt(index)['code'];
                              cubit.mapValidate['phone'] = true;
                              cubit.validateAll();
                              cubit.resultPhoneChoose.sink.add(
                                cubit.dataStep1.phoneCodeModel.code ?? '',
                              );
                              cubit.searchPhones('');
                              Navigator.pop(context);
                            },
                            child: Text(
                              '${snapshot.data?.elementAt(index)['label']}',
                              style: textNormalCustom(
                                AppTheme.getInstance().whiteColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                          ),
                          spaceH20,
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
