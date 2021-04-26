import 'package:palace/src/imp/palace_response.dart';

class Created extends PalaceResponse {
  Created([Object? data])
      : super(
          statusCode: HttpStatus.ok,
          data: data,
        );

  @override
  String get message => 'Ok';
}
