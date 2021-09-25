import 'package:core/src/http/responses/imp.dart';

class RequestTimeout extends PalaceResponse {
  RequestTimeout([Object? data])
      : super(
          statusCode: HttpStatus.requestTimeout,
          data: data,
        );

  @override
  String get message => 'Request Time Out';
}
