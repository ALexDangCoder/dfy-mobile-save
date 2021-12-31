import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension IndexedIterable<E> on List<E> {
  Iterable<T> indexedMap<T>(T Function(E element, int index) f) {
    var index = 0;
    return map((e) => f(e, index++));
  }
}

class InputWithSelectType extends StatefulWidget {
  final List<Widget> typeInput;
  final double? heightOfWidget;
  final String? hintText;
  final int? chooseIndex;
  final Function? onchangeText;
  final int? maxSize;
  final List<TextInputFormatter>? inputFormatters;

  final Function? onChangeType;
  final TextInputType? keyboardType;

  const InputWithSelectType(
      {Key? key,
      required this.typeInput,
      this.hintText,
      this.heightOfWidget,
      this.chooseIndex,
      this.onchangeText,
      this.onChangeType,
      this.keyboardType,
      this.inputFormatters,
      this.maxSize})
      : super(key: key);

  @override
  InputWithSelectTypeState createState() => InputWithSelectTypeState();
}

class InputWithSelectTypeState extends State<InputWithSelectType> {
  GlobalKey dropdownKey = GlobalKey();
  late double width, height, xPosition, yPosition;
  late OverlayEntry floatingDropdown;
  int chooseIndex = 0;
  bool isDropdownOpened = false;

  @override
  void initState() {
    chooseIndex = widget.chooseIndex ?? 0;
    // TODO: implement initState
    super.initState();
  }

  void findDropDownSize() {
    height = dropdownKey.currentContext?.size?.height ?? 0;
    width = dropdownKey.currentContext?.size?.width ?? 0;
    Offset offset =
        (dropdownKey.currentContext?.findRenderObject() as RenderBox)
            .localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _customOverlayEntry() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        right: 0,
        top: yPosition + height,
        child: Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: AppTheme.getInstance().selectDialogColor(),
              constraints:
                  BoxConstraints(maxHeight: (widget.heightOfWidget ?? 64) * 3),
              child: SingleChildScrollView(
                child: Column(
                    children: widget.typeInput
                        .indexedMap((e, index) => GestureDetector(
                              onTap: () {
                                if (widget.onChangeType != null) {
                                  widget.onChangeType!(index);
                                }
                                setState(() {
                                  chooseIndex = index;
                                });
                                final FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                closeDropDown();
                              },
                              child: Container(
                                color: index == chooseIndex
                                    ? Colors.white.withOpacity(0.1)
                                    : AppTheme.getInstance()
                                        .selectDialogColor(),
                                height: widget.heightOfWidget ?? 64,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    e,
                                    const SizedBox(
                                      width: 25,
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList()),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: AppTheme.getInstance().backgroundBTSColor()),
          height: widget.heightOfWidget ?? 64,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType ?? TextInputType.text,
                  onTap: () {
                    if (isDropdownOpened) {
                      floatingDropdown.remove();
                      isDropdownOpened = false;
                    }
                  },
                  onChanged: (value) {
                    if (isDropdownOpened) {
                      floatingDropdown.remove();
                      isDropdownOpened = false;
                    }
                    if (widget.onchangeText != null) {
                      widget.onchangeText!(value);
                    }
                  },
                  cursorColor: AppTheme.getInstance().whiteColor(),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  maxLength: widget.maxSize ?? 100,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                    counterText: '',
                    hintText: widget.hintText,
                    hintStyle: textNormal(
                      Colors.white.withOpacity(0.5),
                      16,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 32,
                width: 1,
                color: AppTheme.getInstance().accentColor().withOpacity(0.2),
              ),
              GestureDetector(
                key: dropdownKey,
                onTap: () {
                  final FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (isDropdownOpened) {
                    floatingDropdown.remove();
                  } else {
                    findDropDownSize();
                    setState(() {
                      floatingDropdown = _customOverlayEntry();
                      Overlay.of(context)!.insert(floatingDropdown);
                    });
                  }
                  isDropdownOpened = !isDropdownOpened;
                  setState(() {});
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                      height: widget.heightOfWidget ?? 64,
                    ),
                    if (widget.typeInput.isNotEmpty)
                      widget.typeInput[chooseIndex]
                    else
                      Container(),
                    SizedBox(
                      width: 25,
                      height: widget.heightOfWidget ?? 64,
                      child: Image.asset(
                        ImageAssets.ic_line_down,
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void closeDropDown() {
    if (isDropdownOpened) {
      floatingDropdown.remove();
      isDropdownOpened = false;
    }
  }
}
