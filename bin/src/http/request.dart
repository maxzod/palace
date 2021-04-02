import 'dart:io' as io;

///* contains simplified logic to extract data from the io req class
class Request {
  final io.HttpRequest _request;

  late final Map<String, dynamic> _queryParams;

  Request(this._request) {
    _queryParams = _request.requestedUri.queryParameters;
  }

  Map<String, dynamic> get params => _queryParams;

  io.HttpRequest get request => _request;

  io.X509Certificate? get certificate => _request.certificate;

  io.HttpConnectionInfo? get connectionInfo => _request.connectionInfo;

  List<io.Cookie> get cookies => request.cookies;

  io.HttpHeaders get headers => request.headers;

  Uri get requestedUri => request.requestedUri;

  io.HttpResponse get response => request.response;

  io.HttpSession get session => request.session;
  // TODO :: Extract it directly here with getter for ease of access
  Uri get uri => request.uri;

  String get method => _request.method;

  @override
  String toString() {
    /// dart io will use it to convert the exception to data and give to the client
    /// TODO :: base on content-type you might need to convert to JSON first
    return '${super.toString()} ';
  }
}
