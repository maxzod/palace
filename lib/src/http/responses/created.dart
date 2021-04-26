import 'package:palace/src/imp/palace_response.dart';

class Accepted extends PalaceResponse {
  Accepted([Object? data])
      : super(
          statusCode: HttpStatus.accepted,
          data: data,
        );

  @override
  String get message => 'Accepted';
}
