import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:flutter/material.dart';

class AddAsset extends StatefulWidget {
  const AddAsset({
    Key? key,
    required this.supportFile,
    required this.maxSizeFile,
    required this.height,
    required this.width,
  }) : super(key: key);
  final String supportFile;
  final String maxSizeFile;
  final double height;
  final double width;

  @override
  _AddAssetState createState() => _AddAssetState();
}

class _AddAssetState extends State<AddAsset> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(33),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Column(
              children: [
                SizedBox(
                  height: 0.16 * widget.height,
                ),
                const Image(
                  image: AssetImage(ImageAssets.img_empty),
                ),
                SizedBox(
                  height: 0.1 * widget.height,
                ),
                Text(
                  S.current.up_load,
                  style: textNormal(Colors.black, 14),
                ),
                Text(
                  '(${S.current.max} ${widget.maxSizeFile})',
                  style: textNormal(Colors.black, 14),
                ),
                SizedBox(
                  height: 0.1 * widget.height,
                ),
                Text(
                  '${S.current.support_type} ${widget.supportFile}',
                  style: textNormal(Colors.black, 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
