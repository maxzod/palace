class BadRequest implements Exception {
  final Object? data;
  BadRequest({
    this.data,
  });
}
