// import 'package:mysql1/mysql1.dart';

// abstract class PalaceDB {
//   static late MySqlConnection _connection;
//   static MySqlConnection get instance => _connection;
//   static MySqlConnection get i => instance;

//   /// should be called by the palace itself
//   static Future<void> init() async {
//     final settings = ConnectionSettings(
//       // TODO(2) UPDATE FROM YAML
//       host: 'localhost',
//       port: 3306,
//       user: 'root',
//       // password: '',
//       db: 'test',
//     );

//     _connection = await MySqlConnection.connect(settings);
//   }
// }
