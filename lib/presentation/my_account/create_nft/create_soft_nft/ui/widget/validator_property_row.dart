import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/extension_create_nft/properties_control.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class PropertyRowWidget extends StatefulWidget {
  final CreateNftCubit cubit;
  final int index;
  final Map<String, String> property;
  final Function onTap;

  const PropertyRowWidget({
    Key? key,
    required this.cubit,
    required this.index,
    required this.property,
    required this.onTap,
  }) : super(key: key);

  @override
  State<PropertyRowWidget> createState() => _PropertyRowWidgetState();
}

class _PropertyRowWidgetState extends State<PropertyRowWidget> {
  final GlobalKey<FormGroupState> _keyForm = GlobalKey<FormGroupState>();

  @override
  Widget build(BuildContext context) {
    String _key = '';
    String _value = '';
    final BehaviorSubject<String> mess = BehaviorSubject();
    return FormGroup(
      key: _keyForm,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextFieldValidator(
                          hint: S.current.properties,
                          maxInputChar: 31,
                          errorTextHeight: 0,
                          onChange: (vl) {
                            _key = vl;
                            mess.sink.add(widget.cubit.getError(_key, _value));
                            widget.cubit.changeKey(widget.index, vl);
                            widget.cubit.boolProperties[widget.index] =
                                _keyForm.currentState?.checkValidator() ??
                                    false;
                            widget.cubit.checkProperty();
                          },
                          validator: (value) {
                            final String vl = value ?? '';
                            if (vl.isEmpty) {
                              return S.current.property_is_required;
                            }
                            if (vl.length > 30) {
                              return S.current.property_maximum_char;
                            }
                            return null;
                          },
                        ),
                      ),
                      line,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextFieldValidator(
                          hint: S.current.value,
                          maxInputChar: 31,
                          errorTextHeight: 0,
                          onChange: (vl) {
                            _value = vl;
                            mess.sink.add(widget.cubit.getError(_key, _value));
                            widget.cubit.changeValue(widget.index, vl);
                            widget.cubit.boolProperties[widget.index] =
                                _keyForm.currentState?.checkValidator() ??
                                    false;
                            widget.cubit.checkProperty();
                          },
                          validator: (value) {
                            final String vl = value ?? '';
                            if (vl.isEmpty) {
                              return S.current.value_is_required;
                            }
                            if (vl.length > 30) {
                              return S.current.value_maximum_char;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.w),
                  child: GestureDetector(
                    onTap: () {
                      widget.onTap();
                    },
                    child: sizedSvgImage(
                      w: 20,
                      h: 20,
                      image: ImageAssets.delete_svg,
                    ),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder<String>(
            stream: mess,
            builder: (context, snapshot) {
              final er = snapshot.data ?? '';
              return er.isNotEmpty
                  ? Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      er,
                      style: errorText(),
                    ),
                  )
                  : const SizedBox.shrink();
            },
          ),
          spaceH16,
        ],
      ),
    );
  }
}
