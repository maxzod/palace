export 'dart:io' show HttpStatus;

/// for some cases you don't have access to `Response` instance
/// `like validation functionally` or `building authorization servers` you may not have access to
///  to the `res` instance so for more readable and cleaner code you can response with this `exceptions`
/// you can throw `BadRequest(data?)` or `NotFound` or `Unauthorized` and palace will
/// ! end the `request` lifecycle
/// ? response to the request based on your exception
/// so if you `throw NotFound()` the palace will make the response with code 404
/// and if you add data to the exception it will be included in the to the response body

abstract class PalaceException implements Exception {
  final int statusCode;
  final Object? data;
  PalaceException(
    this.statusCode, {
    this.data,
  });

  Map<String, dynamic> toMap();
}
