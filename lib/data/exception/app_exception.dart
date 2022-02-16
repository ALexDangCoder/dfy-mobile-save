import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';

class AppException implements Exception {
  int? code = CODE_ERROR_NETWORK;
  String title;
  String message;

  AppException(this.title, this.message, {this.code});

  @override
  String toString() => '$title $message';
}

class CommonException extends AppException {
  CommonException() : super(S.current.error, S.current.something_went_wrong);
}

class NoNetworkException extends AppException {
  NoNetworkException() : super(S.current.error, S.current.error_network);
}

class ExpiredException extends AppException {
  ExpiredException() : super(S.current.error, S.current.error_network);
}

class UnauthorizedException extends AppException {
  UnauthorizedException()
      : super(
          S.current.error,
          S.current.error_network,
          code: CODE_ERROR_AUTH,
        );
}

class MaintenanceException extends AppException {
  MaintenanceException()
      : super(
          S.current.error,
          S.current.error_network,
          code: CODE_ERROR_MAINTAIN,
        );
}
