import 'dart:io';
import 'package:trogon_test/exports_main.dart';
import 'package:http/http.dart';

abstract class Failure {
  int? get statusCode;
  String get message;
}

// Define specific failure enums extending the base failure class
class ServerFailure extends Failure {
  final int errorCode;
  final String msg;
  ServerFailure({required this.errorCode, required this.msg});
  @override
  String get message => msg;

  @override
  int? get statusCode => errorCode;
}

class CacheFailure extends Failure {
  final int errorCode;
  CacheFailure({required this.errorCode});
  @override
  String get message => 'Cache Failure';

  @override
  int? get statusCode => errorCode;
}

class NetworkFailure extends Failure {
  @override
  String get message => 'No Internet Connection';

  @override
  int? get statusCode => null;
}

class UnknownFailure extends Failure {
  @override
  String get message => 'Unknown Failure';

  @override
  int? get statusCode => null;
}

class OtpFailure extends Failure {
  final int errorCode;
  OtpFailure({required this.errorCode});
  @override
  String get message => 'Invalid OTP';

  @override
  int? get statusCode => errorCode;
}

class EmailFailure extends Failure {
  final int errorCode;
  EmailFailure({required this.errorCode});
  @override
  String get message => 'Invalid Email';

  @override
  int? get statusCode => errorCode;
}

class ExceptionFailure extends Failure {
  @override
  String get message => 'Exception Failure';

  @override
  int? get statusCode => null;
}

class NotFoundFailure extends Failure {
  final int errorCode;
  final String? msg;
  NotFoundFailure({this.msg, required this.errorCode});
  @override
  String get message => msg ?? 'Not Found Failure';

  @override
  int? get statusCode => errorCode;
}

class ServerErrorFailure extends Failure {
  final int errorCode;
  ServerErrorFailure({required this.errorCode});
  @override
  String get message => 'Server Error Failure';

  @override
  int? get statusCode => errorCode;
}

class BadRequestFailure extends Failure {
  final int errorCode;
  final String? msg;
  BadRequestFailure({this.msg, required this.errorCode});
  @override
  String get message => msg ?? 'Bad Request';

  @override
  int? get statusCode => errorCode;
}

class StatusCodeFailure extends Failure {
  final int errorCode;
  final String msg;
  StatusCodeFailure({required this.errorCode, required this.msg});
  @override
  String get message => msg;

  @override
  int? get statusCode => errorCode;
}

class UnAuthorizedFailure extends Failure {
  final int errorCode;
  final String msg;
  UnAuthorizedFailure({required this.msg, required this.errorCode});
  @override
  String get message => msg;

  @override
  int? get statusCode => errorCode;
}

class FormatException extends Failure {
  @override
  String get message => 'Format exception';

  @override
  int? get statusCode => null;
}

class HandleForwarding extends Failure {
  @override
  String get message => 'Handle Forwarding';

  @override
  int? get statusCode => 308;
}

Failure handleStatusCode(int statusCode, String? message) {
  switch (statusCode) {
    case 308:
      return HandleForwarding();
    case 401:
      return UnAuthorizedFailure(
        errorCode: 401,
        msg: message ?? 'UnAuthorized Access',
      );
    case 400:
      return BadRequestFailure(
        errorCode: 400,
        msg: message ?? 'Bad Request',
      );
    case 404:
      return NotFoundFailure(
        errorCode: 404,
        msg: 'Not Found',
      );
    case 500:
      return ServerErrorFailure(errorCode: 500);
    default:
      return StatusCodeFailure(
        errorCode: statusCode,
        msg: message ?? 'An error occurred',
      );
  }
}

Failure handleException(Object e) {
  if (e is ClientException && e is SocketException) {
    return NetworkFailure();
  } else {
    return UnknownFailure();
  }
}

Future<T?> showErrorHandleDialog<T>({
  required BuildContext context,
  required Failure? failure,
  required String badRequestMessage,
}) {
  if (failure is ServerFailure) {
    return showDialog(
      context: context,
      builder: (context) {
        return const AppErrorAlert(
          title: 'request_failed',
          content: 'server_error',
        );
      },
    );
  }
  if (failure is NetworkFailure) {
    return showDialog(
      context: context,
      builder: (context) {
        return const AppErrorAlert(
          title: 'request_failed',
          content: 'no_internet_connection',
        );
      },
    );
  }
  if (failure is BadRequestFailure) {
    return showDialog(
      context: context,
      builder: (context) {
        return AppErrorAlert(
          title: 'request_failed',
          content: badRequestMessage,
        );
      },
    );
  }
  return Future(() => null);
}
