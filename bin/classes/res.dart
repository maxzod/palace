import 'package:meta/meta.dart';

@immutable
abstract class Res {
  // TODO Emp res object

  final int statusCode;
  final dynamic data;
  const Res({
    required this.statusCode,
    required this.data,
  });

  @override
  String toString() {
    /// override this  method
    /// dart io will use it to convert the response to data and give to the client
    /// TODO :: base on content-type you might need to convert to JSON first
    return '${super.toString()} ';
  }
}
