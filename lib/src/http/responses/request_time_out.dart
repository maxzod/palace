import 'package:palace/src/imp/palace_response.dart';

class RequestTimeout extends PalaceResponse {
  RequestTimeout([Object? data])
      : super(
          statusCode: HttpStatus.requestTimeout,
          data: data,
        );

  @override
  String get message => 'Request Time Out';
}
