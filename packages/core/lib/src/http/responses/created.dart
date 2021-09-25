import 'package:core/src/http/responses/imp.dart';

class Created extends PalaceResponse {
  Created([Object? data])
      : super(
          statusCode: HttpStatus.created,
          data: data,
        );

  @override
  String get message => 'Created';
}
