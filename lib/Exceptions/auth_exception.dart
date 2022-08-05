abstract class AuthException implements Exception {}

class NotLoggedInException extends AuthException {
  NotLoggedInException();
}
