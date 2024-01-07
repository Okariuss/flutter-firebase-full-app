class VersionCustomException implements Exception {
  final String message;
  VersionCustomException(this.message);

  @override
  String toString() {
    return '$this $message';
  }
}
