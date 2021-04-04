// import 'package:dio/dio.dart';
import 'package:palace/palace.dart';
import 'package:test/test.dart';

void main() {
  late Palace router;

  // final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000', followRedirects: true, validateStatus: (_) => true));

  setUp(() async {
    router = Palace();
    await router.openGates();
  });
  tearDown(() async {
    await router.closeGates();
  });
}
