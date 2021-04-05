import 'package:palace_validators/palace_validators.dart';

class CreateTodoDto {
  @IsRequired()
  String? text;
  bool? isDone = false;
  @IsRequired()
  int? priority;
}
