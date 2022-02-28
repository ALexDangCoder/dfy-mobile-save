import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/extension/upload_file_controller.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';

class UploadDocumentWidget extends StatelessWidget {
  final ProvideHardNftCubit cubit;
  final isVisibleDoc;

  const UploadDocumentWidget({
    Key? key,
    required this.cubit,
    this.isVisibleDoc = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: StreamBuilder<List<String>>(
        stream: cubit.listDocumentPathSubject,
        builder: (context, snapshot) {
          final _listPath = snapshot.data ?? [];
          if (_listPath.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _listPath.length,
              itemBuilder: (_, index) => Container(
                height: 20.h,
                margin: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        basename(
                          _listPath[index],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textCustom(),
                      ),
                    ),
                    spaceW10,
                    Visibility(
                      visible: isVisibleDoc,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          cubit.removeDocument(index);
                        },
                        child: sizedSvgImage(
                          w: 16,
                          h: 16,
                          image: ImageAssets.ic_delete_x_svg,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
