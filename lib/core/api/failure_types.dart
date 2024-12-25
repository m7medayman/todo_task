import 'package:task/core/failure/failure_model.dart';

class AuthorizationFailure extends Failure {
  AuthorizationFailure(
      {super.message = 'Authorization Failure', super.id = 403});
}

class NotFoundFailure extends Failure {
  NotFoundFailure({super.message = 'Not Found', super.id = 404});
}

class ServerFailure extends Failure {
  ServerFailure({super.message = 'Server Error', super.id = 500});
}

class BadRequestFailure extends Failure {
  BadRequestFailure({super.message = 'Bad Request', super.id = 400});
}

class UnknownFailure extends Failure {
  UnknownFailure({super.message = 'Unknown Error', super.id = 0});
}

class TimeoutFailure extends Failure {
  TimeoutFailure({super.message = 'Request Timeout', super.id = 408});
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure({super.message = 'UnAuthorized', super.id = 403});
}

class NoIternetConnection extends Failure {
  NoIternetConnection({super.message = 'No iternet connection', super.id = 3});
}

class CancleFailure extends Failure {
  CancleFailure({super.message = 'Cancle Failure', super.id = 1});
}

class ConflictFailure extends Failure {
  ConflictFailure({super.message = 'Conflict Failure', super.id = 409});
}

class InternalServerError extends Failure {
  InternalServerError(
      {super.message = 'Internal Server Error', super.id = 500});
}

enum FailureType {
  conflict,
  authorization,
  noInternetConnection,
  notFound,
  cancel,
  server,
  badRequest,
  unknown,
  timeout,
  unAuthorized,
  internalServerError
}

extension FailureTypeExtension on FailureType {
  Failure get failure {
    switch (this) {
      case FailureType.conflict:
        return ConflictFailure();
      case FailureType.authorization:
        return AuthorizationFailure();
      case FailureType.notFound:
        return NotFoundFailure();
      case FailureType.server:
        return ServerFailure();
      case FailureType.badRequest:
        return BadRequestFailure();
      case FailureType.unknown:
        return UnknownFailure();
      case FailureType.timeout:
        return TimeoutFailure();
      case FailureType.unAuthorized:
        return UnAuthorizedFailure();
      case FailureType.cancel:
        return CancleFailure();
      case FailureType.noInternetConnection:
        return NoIternetConnection();
      case FailureType.internalServerError:
        // TODO: Handle this case.
        return InternalServerError();
    }
  }
}
