import 'package:Dfy/config/base/base_app_bar.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/widgets/common_bts/base_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseCustomScrollView extends StatefulWidget {
  const BaseCustomScrollView({
    Key? key,
    required this.content,
    required this.image,
    required this.initHeight,
    required this.leading,
    required this.actions,
    required this.title,
    required this.tabBar,
    required this.tabBarView,
    required this.bottomBar,
  }) : super(key: key);
  final List<Widget> content;
  final String image;
  final double initHeight;
  final Widget leading;
  final String title;
  final List<Widget> actions;
  final TabBar tabBar;
  final TabBarView tabBarView;
  final Widget bottomBar;

  @override
  _BaseCustomScrollViewState createState() => _BaseCustomScrollViewState();
}

class _BaseCustomScrollViewState extends State<BaseCustomScrollView> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.bottomBar,
      backgroundColor: AppTheme.getInstance().bgBtsColor(),
      body: SafeArea(
        child: CustomScrollView(
          controller: _controller,
          physics: const ClampingScrollPhysics(),
          slivers: [
            BaseAppBar(
              image: widget.image,
              title: widget.title,
              initHeight: widget.initHeight,
              leading: widget.leading,
              actions: widget.actions,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: widget.content,
                    ),
                  )
                ],
              ),
            ),
            SliverPersistentHeader(
              delegate: BaseSliverHeader(widget.tabBar),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 1000.h,
                      ),
                      child: SizedBox(
                        child: widget.tabBarView,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
