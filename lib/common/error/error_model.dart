import 'package:dio/dio.dart';

sealed class ErrorModel {
  final String message;
  final String? errorCode;

  ErrorModel({required this.message, this.errorCode});

  factory ErrorModel.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return NetworkError();

      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final data = exception.response?.data;
        final serverMessage = data is Map ? data['message'] as String? : null;
        final serverCode = data is Map ? data['code'] as String? : null;

        if (statusCode == 401 || statusCode == 403) {
          return AuthError(errorMessage: serverMessage, errorCode: serverCode);
        }
        return GeneralError(
          errorMessage: serverMessage,
          errorCode: serverCode ?? statusCode?.toString(),
        );

      case DioExceptionType.cancel:
        return GeneralError(errorMessage: "request was cancelled");

      case DioExceptionType.badCertificate:
        return GeneralError(errorMessage: "bad certificate");

      case DioExceptionType.unknown:
        // The real cause (SocketException, HandshakeException, ...) is only in error
        return GeneralError(
          errorMessage: exception.message ?? exception.error?.toString(),
        );
    }
  }
}

class GeneralError extends ErrorModel {
  GeneralError({String? errorMessage, super.errorCode})
    : super(message: errorMessage ?? "something went wrong ");
}

class AuthError extends ErrorModel {
  AuthError({String? errorMessage, super.errorCode})
    : super(message: errorMessage ?? "auth error  ");
}

class TypeParseError extends ErrorModel {
  TypeParseError({String? errorMessage, super.errorCode})
    : super(message: errorMessage ?? "type parse error data ");
}

class NetworkError extends ErrorModel {
  NetworkError() : super(message: "no network connection");
}
