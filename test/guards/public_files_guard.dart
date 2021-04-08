import 'package:dio/dio.dart';
import 'package:palace/palace.dart';
import 'package:palace/src/exceptions/imp_exception.dart';
import 'package:palace/src/guards/static_file_guard.dart';
import 'package:test/test.dart';

void main() {
  late Palace? router;

  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000', followRedirects: true, validateStatus: (_) => true));

  setUp(() async {
    router = Palace();
    await router!.openGates();
  });

  tearDown(() async {
    await router!.closeGates();
    router = null;
  });

  test('if there is no files guard it will not work', () async {
    router!.use(PublicFilesGuard(path: 'test/public'));
    final res = await _dio.get('/public/bugs.png');
    expect(res.statusCode, equals(HttpStatus.notFound));
  });
  test('if the file does not exist it will return 404', () async {
    router!.use(PublicFilesGuard(path: 'test/public'));
    final res = await _dio.get('/public/bugs.png');
    expect(res.statusCode, equals(HttpStatus.notFound));
  });

  test('if files exist it will return it', () async {
    router!.use(PublicFilesGuard(path: '/test/public'));
    final res = await _dio.get('/test/public/background.png');
    expect(res.statusCode, equals(HttpStatus.ok));
    print(res.data);
  });
  test('if files exist <sub-folder> it will return it', () async {
    router!.use(PublicFilesGuard(path: '/test/public'));
    final res = await _dio.get('/test/public/images/try_catch_meme.png');
    expect(res.statusCode, equals(HttpStatus.ok));
  });
}
