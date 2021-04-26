import 'package:palace/src/imp/palace_response.dart';

class Created extends PalaceResponse {
  Created([Object? data])
      : super(
          statusCode: HttpStatus.created,
          data: data,
        );

  @override
  String get message => 'Created';
}
