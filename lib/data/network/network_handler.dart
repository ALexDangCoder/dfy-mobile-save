import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/widgets/listener/event_bus.dart';
import 'package:dio/dio.dart';

class NetworkHandler {
  static AppException handleError(DioError error) {
    return _handleError(error);
  }

  static AppException _handleError(error) {
    if (error is! DioError) {
      return AppException(S.current.error, S.current.something_went_wrong);
    }
    if (_isNetWorkError(error)) {
      eventBus.fire(TimeOutEvent(error.message));
      return AppException(S.current.error, S.current.something_went_wrong);
    }
    final parsedException = _parseError(error);
    final errorCode = error.response?.statusCode;
    if (errorCode == CODE_ERROR_MAINTAIN) {
      return MaintenanceException();
    }
    if(errorCode == CODE_ERROR_NOT_FOUND){
      return AppException(
        S.current.error,
        error.response?.data['rd'],
        code: error.response?.statusCode,
      );
    }
    if (errorCode == CODE_ERROR_AUTH) {
      return UnauthorizedException();
    }
    return parsedException;
  }

  static bool _isNetWorkError(DioError error) {
    final errorType = error.type;
    switch (errorType) {
      case DioErrorType.cancel:
        return true;
      case DioErrorType.connectTimeout:
        return true;
      case DioErrorType.receiveTimeout:
        return true;
      case DioErrorType.sendTimeout:
        return true;
      case DioErrorType.other:
        return true;
      case DioErrorType.response:
        return false;
      default:
        return true;
    }
  }

  static AppException _parseError(DioError error) {
    if (error.response?.data is! Map<String, dynamic>) {
      return AppException(S.current.error, S.current.something_went_wrong);
    }
    return AppException(S.current.error, S.current.something_went_wrong);
  }
}
