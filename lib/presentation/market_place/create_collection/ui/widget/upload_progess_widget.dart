import 'dart:async';
import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/rxdart.dart';

class UploadProgress extends StatefulWidget {
  const UploadProgress({Key? key}) : super(key: key);

  @override
  State<UploadProgress> createState() => _UploadProgressState();
}

class _UploadProgressState extends State<UploadProgress>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Test bloc = Test();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 244.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 20.h,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.getInstance().selectDialogColor(),
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Cover photo',
                  style: textNormal(
                    Colors.white,
                    16,
                  ),
                ),
                StreamBuilder<int>(
                  stream: bloc.progressBarSubject,
                  builder: (context, snapshot) {
                    log(_animationController.status.toString());
                    final cid = snapshot.data ?? 0;
                    if (cid != 1) {
                      if (_animationController.isCompleted) {
                        _animationController.reset();
                      }
                      cid == 0
                          ? _animationController.forward()
                          : _animationController.stop();
                      return SizedBox(
                        height: 6.h,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(3.r),
                                ),
                                color: AppTheme.getInstance()
                                    .bgProgressingColors(),
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (_, child) {
                                return Container(
                                  width: (_animationController.value *
                                          MediaQuery.of(context).size.width)
                                      .w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(3.r),
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: AppTheme.getInstance()
                                          .gradientButtonColor(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Text('AAAAAAAAAAAAAAAAA');
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    bloc.setProgress(0);
                  },
                  child: const Text('RESET'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Test {
  BehaviorSubject<int> progressBarSubject = BehaviorSubject();

  Future<void> setProgress(double duration) async {
    progressBarSubject.sink.add(0);
    log('START');
    await Future.delayed(const Duration(seconds: 3));
    progressBarSubject.sink.add(1);
    log('END');
  }
}
