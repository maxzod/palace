import 'package:palace/palace.dart';

import 'todos_controller.dart';

void main(List<String> arguments) async {
  final palace = Palace();
  palace.use(BodyParser());
  palace.post('/todos', createOne);
  palace.get('/todos', findMany);
  palace.put('/todos/:id', updateOne);
  palace.delete('/todos/:id', deleteOne);
  await palace.openGates();
}
