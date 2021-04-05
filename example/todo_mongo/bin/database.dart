import 'package:mongo_dart/mongo_dart.dart';
import 'package:palace/palace.dart';

class AppDatabase {
  static Db? _instance;
  static Future<Db> get instance async {
    return _instance ??= await AppDatabase._init();
  }

  AppDatabase._();

  static Future<Db> _init() async {
    final db = Db(await yaml('DATABASE_CONNECTION'));
    await db.open();
    return db;
  }
}
