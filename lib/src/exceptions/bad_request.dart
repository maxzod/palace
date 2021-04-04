// for some cases you don't have access to `Response` instance
// 'like validation functionally'
// 'and if you created new instance you will not effect the req lifecycle
// and  cause un expected behavior so
// you can throw BadRequest({data?})
// and the palace will response to the request with res.badRequest
class BadRequest implements Exception {
  final Object? data;
  BadRequest({
    this.data,
  });
}
