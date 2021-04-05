import 'package:palace/palace.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'database.dart';
import 'todo_dto.dart';

Future<void> createOne(Request req, Response res) async {
  print(req.body);
  print(req.bodyType);
  print(req.body['isDone'].runtimeType);
  final dto = req.validate<CreateTodoDto>();
  final _db = await AppDatabase.instance;

  final todo = await _db.collection('todo').insert({
    'text': dto.text,
    'isDone': dto.isDone,
    'priority': dto.priority,
  });
  return res.created(data: todo);
}

Future<void> findMany(Request req, Response res) async {
  final _db = await AppDatabase.instance;
  final data = await _db.collection('todo').find().toList();

  return res.ok(data: data);
}

Future<void> updateOne(Request req, Response res) async {
  final dto = req.validate<CreateTodoDto>();
  final _db = await AppDatabase.instance;
  final id = req.params['id'];
  final coll = _db.collection('todo');
  if (!await _isTodoExist(id)) {
    return await res.notFound();
  }
  final result = await coll.updateOne(
    where.id(ObjectId.parse(id)),
    modify
        .set('text', dto.text)
        .set('isDone', dto.isDone)
        .set('priority', dto.priority),
  );
  //  TODO IDK :: why mongo return null after update
  // but it updates fine

  return res.ok(
      data: await coll.findOne(where.id(ObjectId.parse(id))) ?? 'why null');
}

Future<void> deleteOne(Request req, Response res) async {
  final _db = await AppDatabase.instance;
  final id = req.params['id'];
  final coll = _db.collection('todo');
  if (!await _isTodoExist(id)) {
    return await res.notFound();
  }
  final result = await coll.deleteOne(where.id(ObjectId.parse(id)));
  return res.ok(data: result.document);
}

Future<bool> _isTodoExist(String id) async {
  final _db = await AppDatabase.instance;
  final coll = _db.collection('todo');
  final doc = await coll.findOne(where.id(ObjectId.parse(id)));
  return doc != null;
}
