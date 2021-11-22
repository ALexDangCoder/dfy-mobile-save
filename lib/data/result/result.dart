import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/network/network_checker.dart';
import 'package:Dfy/data/network/network_handler.dart';
import 'package:Dfy/domain/locals/logger.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

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

Future<Result<T>> runCatchingAsync<T>(Future<T> Function() block) async {
  final connected = await CheckerNetwork.checkNetwork();
  if (!connected) {
    return Result.error(NoNetworkException());
  }
  try {
    final response = await block();
    return Result.success(response);
  } catch (e) {
    logger.e(e);
    if (e is DioError) {
      return Result.error(NetworkHandler.handleError(e));
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
