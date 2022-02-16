import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/network/network_checker.dart';
import 'package:Dfy/data/network/network_handler.dart';
import 'package:Dfy/domain/locals/logger.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:dio/dio.dart';
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
            return Result.error(NoNetworkException());
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
