import 'package:dio/dio.dart';
import 'package:palace/palace.dart';
import 'package:palace_body_parser/body_parser.dart';

void main(List<String> args) async {
  final palace = Palace();
  palace.get('/', (req, res) async {
    final result = await parseIoReq(req.request);
    res.send(result.toString());
  });

  palace.openGates();
  final result = await Dio().get(
    'http://localhost:3000/?foo=[1,2,3,4,5,6]',
  );
  print(result.data);
}
