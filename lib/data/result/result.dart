import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/network/network_checker.dart';
import 'package:Dfy/data/network/network_handler.dart';
import 'package:Dfy/domain/locals/logger.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

part 'result.freezed.dart';

LoginRepository get loginRepo => Get.find();

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.error(AppException exception) = Error<T>;
}

Result<T> runCatching<T>(T Function() block) {
  try {
    return Result.success(block());
  } catch (e) {
    return Result.error(
      AppException(
        S.current.error,
        S.current.something_went_wrong,
      ),
    );
  }
}

Future<Result<E>> runCatchingAsync<T, E>(
  Future<T> Function() block,
  E Function(T) map,
) async {
  final connected = await CheckerNetwork.checkNetwork();
  if (!connected) {
    return Result.error(NoNetworkException());
  }
  try {
    final response = await block();
    return Result.success(map(response));
  } catch (e) {
    logger.e(e);
    if (e is DioError) {
      final error = NetworkHandler.handleError(e);
      if (error is UnauthorizedException) {
        final result = await loginRepo.refreshToken(
          loginFromJson(PrefsService.getWalletLogin()).refreshToken ?? '',
        );
        return result.when(
          success: (res) {
            PrefsService.saveWalletLogin(
              loginToJson(res),
            );
            return Result.error(error);
          },
          error: (err) {
            PrefsService.clearWalletLogin();
            Get.dialog(
              GestureDetector(
                onTap: () => Get.back(),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(minHeight: 177.h),
                        width: 312.w,
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().bgBtsColor(),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(36)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, bottom: 19),
                              child: Text(
                                S.current.notify,
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  20,
                                ).copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.only(
                                right: 35,
                                bottom: 24,
                                left: 35,
                              ),
                              child: Text(
                                S.current.login_expired,
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1.w,
                                    color: AppTheme.getInstance()
                                        .whiteBackgroundButtonColor(),
                                  ),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.off(
                                    const MainScreen(
                                      index: loginIndex,
                                      isFormConnectWlDialog: true,
                                    ),
                                  );
                                },
                                behavior: HitTestBehavior.opaque,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 19,
                                    top: 17,
                                  ),
                                  child: Text(
                                    'OK',
                                    style: textNormal(
                                      AppTheme.getInstance().fillColor(),
                                      20,
                                    ).copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
            return Result.error(
              AppException(
                S.current.notify,
                S.current.something_went_wrong,
              ),
            );
          },
        );
      } else {
        return Result.error(error);
      }
    } else {
      return Result.error(
        AppException(
          S.current.error,
          S.current.something_went_wrong,
        ),
      );
    }
  }
}
