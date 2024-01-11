class ItemCreateException implements Exception {
  final String message;
  ItemCreateException(this.message);

  @override
  String toString() {
    return '$this $message';
  }
}
