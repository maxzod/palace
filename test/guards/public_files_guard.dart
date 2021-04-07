import 'package:dio/dio.dart';
import 'package:palace/palace.dart';
import 'package:palace/src/guards/static_file_guard.dart';
import 'package:test/test.dart';

void main() {
  late Palace router;

  final _dio = Dio(BaseOptions(baseUrl: 'http://localhost:3000', followRedirects: true, validateStatus: (_) => true));

  setUp(() async {
    router = Palace();

    await router.openGates();
  });
  tearDown(() async {
    await router.closeGates();
  });
  test('if the file does not exist it will return 404', () async {
    router.get('/home', (req, res) => res.json(req.body));
    router.use(PublicFilesGuard());
  });
  test('if files exist it will return it', () async {});
  // TODO :: TEST THE FILE
}
