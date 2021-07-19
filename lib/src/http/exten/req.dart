import 'package:palace/src/http/request.dart';

extension ReqGetters on Request {
  String get contentType => request.headers.contentType.toString();
}
