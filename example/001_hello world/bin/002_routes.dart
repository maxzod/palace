import 'package:palace/palace.dart';

Future<void> main(List<String> arguments) async {
  final router = Palace();
  router.get(
    '/api/home',
    (req, res) => res.json(
      {
        'top_packages': [
          'palace'
              'palace_validators'
              'queen_validators'
              'queen_alerts'
        ]
      },
    ),
  );

  router.get('/packages/:id', (req, res) => res.write('package ${req.params['id']} data'));
  router.get('/packages/:id/likes', (req, res) => res.write('package likes count from package with id: ${req.params['id']}'));
  router.post('/packages', (req, res) {
    if (req.body['package_name']) {
      return res.badRequest(data: 'you must enter the new package name !');
    } else {
      return res.accepted(data: 'new product has been created successfully ! ');
    }
  });
  await router.openGates();
}
