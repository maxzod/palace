import 'package:core/src/http/responses/imp.dart';

class NotAcceptable extends PalaceResponse {
  NotAcceptable([Object? data])
      : super(
          statusCode: HttpStatus.notAcceptable,
          data: data,
        );

  @override
  String get message => 'Not Acceptable';
}
