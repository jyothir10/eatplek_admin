class APIException implements Exception {
  final int code;
  final Map<String, dynamic> message;

  APIException(this.code, this.message);

  @override
  String toString() {
    return "APIException[code:$code, message:$message]";
  }
}
