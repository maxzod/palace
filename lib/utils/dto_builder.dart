import 'dart:mirrors';

Object buildDto<T>(Map<String, dynamic> body) {
  final dtoClassRef = reflectClass(T);
  final dtoMirror = dtoClassRef.newInstance(Symbol.empty, []);
  final fields = dtoMirror.type.declarations.values.whereType<VariableMirror>();
  for (final key in body.keys) {
    if (fields.where((f) => key == MirrorSystem.getName(f.simpleName)).isNotEmpty) {
      dtoMirror.setField(Symbol(key), body[key]);
    }
  }
  return dtoMirror.reflectee as Object;
}
