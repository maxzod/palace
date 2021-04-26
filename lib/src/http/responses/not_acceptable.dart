import 'package:palace/src/imp/palace_response.dart';

class NotAcceptable extends PalaceResponse {
  NotAcceptable([Object? data])
      : super(
          statusCode: HttpStatus.notAcceptable,
          data: data,
        );

  @override
  String get message => 'Not Acceptable';
}
