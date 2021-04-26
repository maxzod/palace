import 'package:palace/src/imp/palace_response.dart';

class NotFound extends PalaceResponse {
  NotFound([Object? data])
      : super(
          statusCode: HttpStatus.notFound,
          data: data,
        );

  @override
  String get message => 'Not found';
}
