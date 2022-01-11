import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/list_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  _InputWithSelectTypeState createState() => _InputWithSelectTypeState();
}

class _InputWithSelectTypeState extends State<InputWithSelectType> {
  GlobalKey dropdownKey = GlobalKey();
  late double width, height, xPosition, yPosition;
  int chooseIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: AppTheme.getInstance().backgroundBTSColor(),
          ),
          height: widget.heightOfWidget ?? 64,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  inputFormatters: widget.inputFormatters,
                  keyboardType: widget.keyboardType ?? TextInputType.text,
                  onChanged: (value) {
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
                onTap: () async {
                  findDropDownSize();
                  final index = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration.zero,
                      opaque: false,
                      pageBuilder: (_, __, ___) => DropDown(
                        chooseIndex: chooseIndex,
                        width: width,
                        height: height,
                        xPosition: xPosition,
                        yPosition: yPosition,
                        typeInput: widget.typeInput,
                      ),
                    ),
                  );
                  setState(() {
                    chooseIndex = index ?? chooseIndex;
                    if (widget.onChangeType != null) {
                      widget.onChangeType!(chooseIndex);
                    }
                  });
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
                      width: 20,
                      height: widget.heightOfWidget ?? 64,
                      child: Image.asset(
                        ImageAssets.ic_line_down,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 15)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DropDown extends StatelessWidget {
  final double height;
  final double yPosition;
  final double width;
  final double? heightOfWidget;
  final int? chooseIndex;
  final List<Widget> typeInput;

  final double xPosition;

  const DropDown({
    Key? key,
    required this.height,
    required this.yPosition,
    required this.width,
    required this.xPosition,
    this.heightOfWidget,
    required this.typeInput,
    this.chooseIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isBelow =
        (MediaQuery.of(context).size.height - (yPosition + height)) >
            ((heightOfWidget ?? 64) * 3) + 10;
    final _scrollController = ScrollController(
      initialScrollOffset: (heightOfWidget ?? 64) * (chooseIndex ?? 0),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            right: 16.w,
            top: isBelow
                ? yPosition + height
                : typeInput.length < 3
                    ? yPosition -
                        (((heightOfWidget ?? 64) * typeInput.length) + 10)
                    : yPosition - (((heightOfWidget ?? 64) * 3) + 10),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(10),
                bottomLeft: isBelow ? const Radius.circular(10) : Radius.zero,
                bottomRight: const Radius.circular(10),
                topLeft: isBelow ? Radius.zero : const Radius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: isBelow ? 10 : 0, bottom: isBelow ? 0 : 10),
                color: AppTheme.getInstance().selectDialogColor(),
                constraints: BoxConstraints(
                  maxHeight: ((heightOfWidget ?? 64) * 3) + 10,
                ),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Scrollbar(
                    radius: const Radius.circular(10),
                    controller: _scrollController,
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: typeInput
                            .indexedMap(
                              (e, index) => GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  color: index == chooseIndex
                                      ? Colors.white.withOpacity(0.1)
                                      : AppTheme.getInstance()
                                          .selectDialogColor(),
                                  height: heightOfWidget ?? 64,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      e,
                                      const SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
