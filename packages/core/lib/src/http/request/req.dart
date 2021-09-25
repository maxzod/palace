import 'package:core/core.dart';

extension ReqGetters on Request {
  String get contentType => request.headers.contentType.toString();
}
